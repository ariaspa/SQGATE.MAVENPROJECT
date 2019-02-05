package com.li.dc.sebc.turboFSE.business.remoteService
{
	import it.lispa.siss.sebc.middleground.entity.Cittadino;
	import it.lispa.siss.sebc.middleground.entity.Operatore;
	
	import mx.rpc.IResponder;
	
	public class EventiCittadinoService extends RemoteService
	{
		 public var cittadino:Cittadino;
		 public var operatore:Operatore;
		 public var idTipoEvento:String;
		 public var dataInizio:String;
		 public var dataFine:String;
		 
		public function EventiCittadinoService(responder:IResponder = null,destination:String=null,cittadino:Cittadino=null,
									operatore:Operatore=null,idTipoEvento:String=null, dataInizio:String=null, dataFine:String=null)
		{
			super(responder,destination);
			this.cittadino 			= cittadino;
			this.operatore 			= operatore;
			this.idTipoEvento 		= idTipoEvento;
			this.dataInizio 		= dataInizio;
			this.dataFine 			= dataFine;
		}
		override public function execute():void
		{
			if(cittadino!=null && operatore!=null && dataInizio != null && dataFine != null){
				getRemote().getEventi(cittadino , operatore, idTipoEvento, dataInizio, dataFine);
			}else
			{
				callInternalFault("Uno dei parametri risulta null");
			}
		}
	}
}