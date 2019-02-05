package com.li.dc.sebc.turboFSE.controller.commands
{
	import mx.rpc.IResponder;
	import it.lispa.siss.sebc.flex.mvc.controller.Command;

	public class ResponderCommand extends Command implements IResponder
	{
		public function ResponderCommand()
		{
			super();
		}
		
		public function result(data:Object):void
		{
		}
		
		public function fault(info:Object):void
		{
		}
		
	}
}