package com.li.dc.sebc.turboFSE.business.remoteService
{
	import com.li.dc.sebc.turboFSE.model.vo.VoInputTimeLine;
	
	import it.lispa.siss.sebc.middleground.entity.Cittadino;
	import it.lispa.siss.sebc.middleground.entity.Operatore;
	
	import mx.rpc.IResponder;

	public class TimelineService extends RemoteService
	{
		public var cittadino:Cittadino;
		public var operatore:Operatore;
		public var input:VoInputTimeLine;
		public function TimelineService(responder:IResponder=null, destination:String=null)
		{
			super(responder, destination);
		}
		override public function execute():void
		{
			if(cittadino!=null && operatore!=null && input!=null)
			{	
				getRemote().getDataTimeline(cittadino , operatore, input );
			}else
			{
				callInternalFault("Uno dei parametri risulta null");
			}
		}
	}
}