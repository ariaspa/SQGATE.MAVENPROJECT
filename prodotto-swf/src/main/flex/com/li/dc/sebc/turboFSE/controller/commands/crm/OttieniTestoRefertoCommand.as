package com.li.dc.sebc.turboFSE.controller.commands.crm
{
	import com.li.dc.sebc.turboFSE.business.FactoryService;
	import com.li.dc.sebc.turboFSE.controller.commands.serviceCommand.ControlWait;
	import com.li.dc.sebc.turboFSE.model.ConstDataProxy;
	import com.li.dc.sebc.turboFSE.model.FSEModel;
	import com.li.dc.sebc.turboFSE.util.WrapResponder;
	import com.li.dc.sebc.turboFSE.util.window.operation.ResponderLoadVisualizza;

	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.utils.Dictionary;

	import it.lisit.siss.flex.communication.crm.voTestoReferto.VoOutputTestoreferto;
	import it.lisit.siss.flex.communication.util.voCreaStrutturato.VoOutputCreaStrutturato;
	import it.lispa.siss.sebc.flex.debug.Debug;
	import it.lispa.siss.sebc.middleground.entity.Cittadino;
	import it.lispa.siss.sebc.middleground.entity.SetDocumentale;

	import mx.rpc.events.ResultEvent;

	public class OttieniTestoRefertoCommand extends ControlWait
	{
		public static var dict64:Dictionary = new Dictionary();
		private static var flagCall:Boolean	= false;

		public function OttieniTestoRefertoCommand()
		{
			super();
		}

		override protected function executeCommand(data:Object = null):void
		{
			Debug.logDebug("OttieniTestoRefertoCommand.executeCommand (data !=null): " + (data !=null) + ", " + data);
			var setDoc:SetDocumentale = data as SetDocumentale;
			var uri:String = setDoc.documentoTestuale.uri;

			if(!flagCall)
			{
				Debug.logDebug("OttieniTestoRefertoCommand.executeCommand :(dict64[uri]!=null): " + (dict64[uri]!=null));
				if(dict64[uri] != null)
				{
					parsingVisualizzaReferto(dict64[uri]);
				}
				else
				{
					var codiceFiscale:String = (FSEModel.getInstance().retrieveProxy(ConstDataProxy.DATA_CITTADINO).getData() as Cittadino).codiceFiscale;

					if(codiceFiscale != null && codiceFiscale.length > 0)
					{
						Debug.logDebug("OttieniTestoRefertoCommand.executeCommand: codiceFiscale: "+codiceFiscale);
						flagCall = true;
						// per arrivare direttamente all'oggetto
						var wrap:WrapResponder = new WrapResponder(new ResponderVisualizzaTestoReferto(this));
						FactoryService.getInstance().getVisualizzaTestoReferto(wrap, uri, codiceFiscale).execute();
					}
				}
			}
		}


		internal function resultVisualizzaTestoReferto(data:Object):void
		{
			Debug.logDebug("OttieniTestoRefertoCommand.resultVisualizzaTestoReferto (data!=null) " + (data != null));
			if(data != null)
			{
				Debug.logDebug("OttieniTestoRefertoCommand.resultVisualizzaTestoReferto in data != null " );
				dict64[data.uri] = data.output as VoOutputTestoreferto;
				parsingVisualizzaReferto(dict64[data.uri]);
			}
			else
			{
				Debug.logDebug("OttieniTestoRefertoCommand.resultVisualizzaTestoReferto in data == null " );
				flagCall = false;
			}
		}

		internal function faultVisualizzaTestoReferto(info:Object):void
		{
			Debug.logDebug("OttieniTestoRefertoCommand.faultVisualizzaTestoReferto: " + info );
			flagCall = false;
		}

		private function parsingVisualizzaReferto(data:Object):void
		{
			Debug.logDebug("OttieniTestoRefertoCommand.parsingVisualizzaReferto");
			FactoryService.getInstance().getContentVisualizerPlugin(this, data).execute();
		}

		override protected function executeResult(data:Object):void
		{
			Debug.logDebug("OttieniTestoRefertoCommand.resultPlugIn data: " + data);
			flagCall = false;
			if(data != null)
			{
				var nomeFile:String = ((data as ResultEvent).result as VoOutputCreaStrutturato).nomeFile;
				var request:URLRequest = new URLRequest("https://localhost/ope_fse/servlet/proxy_service?url=" + nomeFile);
				navigateToURL(request, "_self");
			}
		}

		override protected function executeFault(info:Object):void
		{
			Debug.logDebug("OttieniTestoRefertoCommand.faultPlugIn info:" + info as String);
			flagCall = false;
		}

	}
}