package com.li.dc.sebc.turboFSE.util.window.operation
{
	import it.lispa.siss.sebc.flex.debug.Debug;
	
	import mx.rpc.IResponder;

	public class ResponderVisualizerPlugin implements IResponder
	{
		private var reference:VisualizzaTestoRefertoOperation;
		public function ResponderVisualizerPlugin(reference:VisualizzaTestoRefertoOperation)
		{
			this.reference = reference;
			Debug.logDebug("ResponderVisualizerPlugin instance reference = "+reference);
		}

		public function result(data:Object):void
		{
			Debug.logDebug("ResponderVisualizerPlugin result");
			this.reference.resultPlugIn( data );
		}
		
		public function fault(info:Object):void
		{
			Debug.logDebug("ResponderVisualizerPlugin fault");
			this.reference.faultPlugIn( info );
		}
		
	}
}