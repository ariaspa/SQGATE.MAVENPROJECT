package com.li.dc.sebc.turboFSE.controller.commands
{
	import it.lispa.siss.sebc.flex.debug.Debug;
	import it.lispa.siss.sebc.flex.messages.MessageManager;
	import it.lispa.siss.sebc.flex.mvc.controller.Command;

	public class VisualizzaValidateErrorCommand extends Command
	{
		public function VisualizzaValidateErrorCommand()
		{
			super();
		}
		override public function execute(data:Object=null):void
		{
			Debug.logWarning("TODO IMPLEMENTARE VisualizzaValidateErrorCommand");
			MessageManager.getInstance().addMessage( data );
		}
	}
}