package com.li.dc.sebc.turboFSE.util.window.operation
{
	import mx.rpc.IResponder;

	public class ResponderLoadVisualizza implements IResponder
	{
		private var reference:VisualizzaTestoRefertoOperation;
		public function ResponderLoadVisualizza(reference:VisualizzaTestoRefertoOperation)
		{
			this.reference = reference;
		}
		public function result(data:Object):void
		{
			this.reference.resultLaodDocument( data );
		}
		public function fault(info:Object):void
		{
			this.reference.faultLaodDocument( info );
		}
	}
}