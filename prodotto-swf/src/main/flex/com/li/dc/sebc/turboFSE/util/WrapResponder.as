package com.li.dc.sebc.turboFSE.util
{
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;

	public class WrapResponder implements IResponder
	{
		private var rep:IResponder;
		public function WrapResponder(rep:IResponder)
		{
			this.rep = rep;
		}
		public function result(data:Object):void
		{
			if(data is ResultEvent)
			{
				this.rep.result( (data as ResultEvent).result );
			}else 
			{
				this.rep.result( data );
			}
		}
		 
		public function fault(info:Object):void
		{
			if(info is FaultEvent)
			{
				this.rep.fault( (info as FaultEvent).fault );
			}else 
			{
				this.rep.result( info );
			}
		}
	}
}