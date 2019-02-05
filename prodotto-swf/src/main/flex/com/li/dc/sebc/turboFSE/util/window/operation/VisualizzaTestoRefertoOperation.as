package com.li.dc.sebc.turboFSE.util.window.operation
{
	import com.li.dc.sebc.turboFSE.business.FactoryService;
	import com.li.dc.sebc.turboFSE.fseTurbo;
	import com.li.dc.sebc.turboFSE.model.ConstDataProxy;
	import com.li.dc.sebc.turboFSE.model.FSEModel;
	import com.li.dc.sebc.turboFSE.util.WrapResponder;
	import com.li.dc.sebc.turboFSE.util.window.ListenerWindow;
	import com.li.dc.sebc.turboFSE.view.nodeView.AreaLavoro;
	
	import flash.utils.Dictionary;
	
	import it.lisit.siss.flex.communication.crm.voTestoReferto.VoOutputTestoreferto;
	import it.lisit.siss.flex.communication.util.voCreaStrutturato.VoOutputCreaStrutturato;
	import it.lispa.siss.sebc.flex.debug.Debug;
	import it.lispa.siss.sebc.flex.messages.MessageManager;
	import it.lispa.siss.sebc.middleground.entity.Cittadino;
	
	use namespace fseTurbo
	public class VisualizzaTestoRefertoOperation
	{
		public static var dict64:Dictionary 	= new Dictionary();
		private static var flagCall:Boolean		= false;
		private var reference:ListenerWindow;
		private var uri:String;
		private var type:String;
		public function VisualizzaTestoRefertoOperation(reference:ListenerWindow)
		{
			this.reference = reference;
		}
		public function execute(param:Array):void
		{
			if(param!=null && param.length>=2)
			{
				uri		= param[0];
				type	= param[1];
				Debug.logDebug("VisualizzaTestoRefertoOperation.execute :uri: "+uri+", type : "+type);
				if(!flagCall)
				{
					var m:FSEModel = FSEModel.getInstance();
					m.retrieveProxy( ConstDataProxy.STATE_AREA_LAVORO ).update( AreaLavoro.WAIT );
					Debug.logDebug("VisualizzaTestoRefertoOperation.execute :(dict64[uri]!=null): "+(dict64[uri]!=null));
					if(dict64[uri]!=null)
					{
						parsingVisualizzaReferto( dict64[uri] );
					}else
					{
						var codiceFiscale:String = (FSEModel.getInstance().retrieveProxy(ConstDataProxy.DATA_CITTADINO).getData() as Cittadino).codiceFiscale;
						
						if(codiceFiscale!=null && codiceFiscale.length>0)
						{
							Debug.logDebug("VisualizzaTestoRefertoOperation.execute :codiceFiscale: "+codiceFiscale);
							flagCall = true;
							// per arrivare direttamente all'oggetto
							var wrap:WrapResponder = new WrapResponder(new ResponderLoadVisualizza(this));
							FactoryService.getInstance().getVisualizzaTestoReferto(wrap,uri,codiceFiscale).execute();
						}
					}
				}	
			}
		}
		// fallisce da VisualizzaTestoReferto
		internal function faultLaodDocument(info:Object):void
		{
			Debug.logDebug("VisualizzaTestoRefertoOperation.faultLaodDocument " );
			callBackVisualizzaReferto({type:"error",msg:"Si è verificato un errore nel caricamento del documento",info:info}); 
		}
		internal function resultLaodDocument(data:Object):void
		{ 
			Debug.logDebug("VisualizzaTestoRefertoOperation.resultLaodDocument (data!=null) "+(data!=null));
			if(data!=null)
			{
				// {uri:uri,output:output};
				Debug.logDebug("VisualizzaTestoRefertoOperation.resultLaodDocument dentro1 " );
				dict64[data.uri] 		= data.output as VoOutputTestoreferto;
				parsingVisualizzaReferto( dict64[data.uri] );
			}else
			{
				Debug.logDebug("VisualizzaTestoRefertoOperation.resultLaodDocument dentro2 " );
				callBackVisualizzaReferto({type:"error",msg:"Si è verificato un errore nel caricamento del documento",info:{msg:"Si è verificato un errore nel caricamento del documento"}}); 
			}
		}
		 
		
		private function parsingVisualizzaReferto(data:Object):void
		{
			Debug.logDebug("VisualizzaTestoRefertoOperation.parsingVisualizzaReferto");
			var wrap:WrapResponder = new WrapResponder( new ResponderVisualizerPlugin(this) );
			FactoryService.getInstance().getContentVisualizerPlugin(wrap,data).execute();
		}
		 
		
		internal function faultPlugIn(info:Object):void
		{
			Debug.logDebug("VisualizzaTestoRefertoOperation.faultPlugIn");
			callBackVisualizzaReferto({type:"error",msg:"Si è verificato un errore nel caricamento del documento",info:info});
		}
		
		
		
		internal function resultPlugIn(data:Object):void
		{
			// 
			Debug.logDebug("VisualizzaTestoRefertoOperation.resultPlugIn");
			if(data!=null)
			{
				callBackVisualizzaReferto( {type:"visualizza",nomeFile:(data as VoOutputCreaStrutturato).nomeFile} );
			}else
			{
				callBackVisualizzaReferto({type:"error",msg:"Si è verificato un errore nel caricamento del documento",info:{msg:"Si è verificato un errore nel caricamento del documento"}}); 
			}
		}
		 
		/////////////////////////
		private function callBackVisualizzaReferto(data:Object):void
		{
			Debug.logDebug("VisualizzaTestoRefertoOperation.callBackVisualizzaReferto data.type: "+data.type);
			var m:FSEModel = FSEModel.getInstance();
			m.retrieveProxy( ConstDataProxy.STATE_AREA_LAVORO ).update( AreaLavoro.ACTIVE );
			// {type:"error",msg:"Si è verificato un errore nel caricamento del documento"};
			//{type:"visualizza",nomeFile:(data as VoOutputCreaStrutturato).nomeFile}
			flagCall = false;
			 
			if(data.type.toUpperCase() == "ERROR")
			{
				// type 
				this.reference.send( ["responseVisualizzaTestoReferto",data.type,data.msg] );
				MessageManager.getInstance().addMessage( data.info );
			}else
			{ 
				//var type:String	= (dict64[data.uri] as VoOutputTestoreferto).descTipoTestoReferto ;
				Debug.logDebug("VisualizzaTestoRefertoOperation.callBackVisualizzaReferto data.type: "+data.type+", type : "+type+", uri : "+data.nomeFile);
				this.reference.send( ["responseVisualizzaTestoReferto",type,data.nomeFile] );
			}
		}
	}
}