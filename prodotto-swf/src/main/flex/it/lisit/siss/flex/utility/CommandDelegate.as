package it.lisit.siss.flex.utility
{
	public class CommandDelegate
	{
		private var fLater:Function;  
		private var argmnts:Array; 
		//
		public function CommandDelegate(funLater:Function,arg:Array = null)
		{
			fLater = funLater;
			argmnts = arg;
		}
		public function execute( ):void
		{
			fLater.apply(null,argmnts);
		}
	}
}