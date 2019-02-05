package com.li.dc.sebc.turboFSE.controller.commands.serviceCommand
{
	import com.li.dc.sebc.turboFSE.business.FactoryService;
	
	import it.lisit.siss.flex.communication.util.voVerificaPDC.VoOutputVerificaPDC;
	import it.lispa.siss.sebc.flex.debug.Debug;
	import it.lispa.siss.sebc.middleground.entity.Cittadino;
	import it.lispa.siss.sebc.middleground.entity.supporto.SmartCard;
	
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	
	public class LoadCittadinoSmartCardCommand extends ControlWait
	{
		private var responder:IResponder;
		private var firstResult:ResultEvent; 
		public function LoadCittadinoSmartCardCommand()
		{
			super();
		}
		override protected function executeCommand(data:Object=null):void
		{
			Debug.logDebug( "LoadCittadinoSmartCardCommand . executeCommand" );
			if(data!=null && data is IResponder)
			{
				responder = data as IResponder;
				// getCittadinoSmartCard servizio di lettura della carta
				 
				FactoryService.getInstance().getCittadinoSmartCard( new VerificaSmartCard(this) ).execute();
			} 
		}
		public function loadSmartCard(result:ResultEvent):void
		{
			firstResult = result;
			Debug.logDebug( "CHIEDE LA VERIFICA DELLA PRESENZA DELLA CARTA" );
			// getOttieniSmartCard servizio per la lettura dei dati della smartCard
			FactoryService.getInstance().getOttieniSmartCard( this ).execute();
		}  
		// qui ci arriva dopo che ha chiamato la smart card
		override protected function executeResult(data:Object):void
		{
			Debug.logDebug( "LoadCittadinoSmartCardCommand . result" );
			var obj:Object	= data;
			try{
				if(firstResult !=null && data is ResultEvent && (data as ResultEvent).result!=null  && (data as ResultEvent).result is VoOutputVerificaPDC)
				{
					var citt:Cittadino 			= (firstResult as ResultEvent).result as Cittadino;
					var out:VoOutputVerificaPDC = (data as ResultEvent).result as VoOutputVerificaPDC;
					if(out.codiceFiscale==citt.codiceFiscale)
					{
						
						var smartCard:SmartCard	= new SmartCard();
						smartCard.serialNumber	= out.unicId;
						citt.smartCard 			= smartCard;
						Debug.logDebug( "E' STATO AGGIUNTA L'INFORMAZIONE DELLA SMART CARD" );
					}
					
					obj = firstResult;
				} 
			}catch(e:Error)
			{
				obj = data;
			}
			responder.result( obj );
		}
		override protected function executeFault(info:Object):void
		{
			Debug.logDebug( "LoadCittadinoSmartCardCommand . fault" );
			responder.fault( info );
		}
	}
}
	import mx.rpc.IResponder;
	import com.li.dc.sebc.turboFSE.controller.commands.serviceCommand.LoadCittadinoSmartCardCommand;
	import it.lispa.siss.sebc.middleground.entity.Cittadino;
	import mx.rpc.events.ResultEvent;
	

class VerificaSmartCard implements IResponder
{
	private var commResponder:LoadCittadinoSmartCardCommand; 
	
	public function VerificaSmartCard(resp:LoadCittadinoSmartCardCommand)
	{
		this.commResponder = resp;
	}
	public function result(data:Object):void
	{
		if(data is ResultEvent && (data as ResultEvent).result!=null && (data as ResultEvent).result is Cittadino)
		{
			//var citt:Cittadino = (data as ResultEvent).result as Cittadino;
			commResponder.loadSmartCard(data as ResultEvent);
		}else
		{
			commResponder.result( data );
		}
	}
	public function fault(info:Object):void
	{
		// qualunque sia
		commResponder.fault(info);
	}
} 