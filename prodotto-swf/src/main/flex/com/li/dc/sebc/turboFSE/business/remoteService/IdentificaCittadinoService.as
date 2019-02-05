package com.li.dc.sebc.turboFSE.business.remoteService
{
	import it.lispa.siss.sebc.middleground.entity.Cittadino;
	import it.lispa.siss.sebc.middleground.entity.Operatore;

	public class IdentificaCittadinoService extends RemoteService
	{
		public var cittadino:Cittadino
		public var operatore:Operatore;
		public var numPagine:String;
		public var useWildCard:String;
		public var maxRecord:String;
		public var omettiEsenzioni:String;
		public function IdentificaCittadinoService()
		{
			super();
			numPagine = "";
			useWildCard = "";
			maxRecord = "";
			omettiEsenzioni = "";
		}
		override public function execute():void
		{
			if(cittadino!=null && operatore!=null )
			{
				getRemote().getCittadino(cittadino,operatore,numPagine,useWildCard,maxRecord,omettiEsenzioni);
			}else
			{
				callInternalFault("Uno dei parametri risulta null");
			}
		}
	}
}