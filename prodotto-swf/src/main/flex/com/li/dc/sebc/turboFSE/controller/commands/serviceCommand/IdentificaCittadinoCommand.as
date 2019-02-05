package com.li.dc.sebc.turboFSE.controller.commands.serviceCommand
{
	import com.li.dc.sebc.turboFSE.business.FactoryService;
	import com.li.dc.sebc.turboFSE.model.ConstDataProxy;
	import com.li.dc.sebc.turboFSE.model.FSEModel;
	import com.li.dc.sebc.turboFSE.model.vo.CittadiniIdentificati;
	import com.li.dc.sebc.turboFSE.model.vo.DataIdentificaCittadino;
	import com.li.dc.sebc.turboFSE.util.WrapResponder;
	
	import it.lispa.siss.sebc.flex.debug.Debug;
	import it.lispa.siss.sebc.flex.messages.ConstStatus;
	import it.lispa.siss.sebc.flex.messages.Message;
	import it.lispa.siss.sebc.flex.messages.MessageManager;
	import it.lispa.siss.sebc.middleground.entity.Assistenza;
	import it.lispa.siss.sebc.middleground.entity.Cittadino;
	import it.lispa.siss.sebc.middleground.entity.Comune;
	
	import mx.collections.ArrayCollection;
	
	public class IdentificaCittadinoCommand extends ControlWait
	{
		private var local:Boolean;
		public function IdentificaCittadinoCommand()
		{
			super();
		}
		override protected function executeCommand(data:Object=null):void
		{
			Debug.logDebug("IdentificaCittadinoCommand execute");
			if(data != null)
			{
				var dtIden:DataIdentificaCittadino = data as DataIdentificaCittadino;
				var cit:Cittadino		= getCittadino(dtIden);
				var maxRecord:String	= dtIden.maxRecords;
				var numPagine:String	= dtIden.pageNumber;
				var useWildCard:String	= dtIden.useWildcard;
				var ometti:String		= dtIden.omettiEsenzioni;
				FactoryService.getInstance().getListaCittadini(new WrapResponder(this),cit,maxRecord,numPagine,useWildCard,ometti).execute();
			}else
			{
				internalFault();
			}
		}
		
		override protected function executeResult(data:Object):void
		{
			if(data is CittadiniIdentificati)
			{
				var risposta:CittadiniIdentificati	=  data as CittadiniIdentificati;
				  
				if(risposta.esitoNegativo!=null)
				{
					MessageManager.getInstance().addMessage( risposta.esitoNegativo );
				}else if(risposta.fault!=null)
				{
					MessageManager.getInstance().addMessage( risposta.fault );
				}else
				{
					var model:FSEModel = FSEModel.getInstance();
					if(risposta.listaCittadini!=null)
					{
						var coll:ArrayCollection = risposta.listaCittadini as ArrayCollection;
						model.retrieveProxy(ConstDataProxy.DATA_ELENCO_CITTADINI).update( coll.toArray() );
					}else
					{
						if(risposta.listaWarning!=null && risposta.listaWarning.warning !=null && risposta.listaWarning.warning.length>0)
						{
							MessageManager.getInstance().addMessage( risposta.listaWarning.warning );
						}else
						{
							var msg:String	= "Non sono presenti cittadini";
							MessageManager.getInstance().addMessage( new Message("Attenzione",msg,ConstStatus.WARNING) );
						}
					}
				}
			}
		}
		 
		override protected function executeFault(info:Object):void
		{
			var message:Message = MessageManager.getInstance().reader.createMessage( info );
			MessageManager.getInstance().addMessage("Identifica Cittadino : "+ message.message);
		}
		private function getCittadino(dt:DataIdentificaCittadino):Cittadino
		{
			var cit:Cittadino 	= new Cittadino();
			cit.codiceFiscale	= dt.codiceFiscale;
			cit.assistenza		= new Assistenza();
			cit.assistenza.idAssistito	= dt.idAssistito;
			cit.codiceSesso		= dt.codiceSesso;
			cit.cognome			= dt.cognome;
			cit.dataNascita		= dt.dataNascita;
			cit.localitaNascita	= new Comune();
			cit.localitaNascita.codiceIstat = dt.idLocalitaNascita;
			cit.nome			= dt.nome;
			return cit;
		}
		 
		private function internalFault():void
		{
			fault({label:"internalFault"});
		}
		 
	}
}