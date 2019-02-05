package com.li.dc.sebc.turboFSE.controller.commands
{
	import com.li.dc.sebc.turboFSE.business.FactoryService;
	import com.li.dc.sebc.turboFSE.controller.commands.serviceCommand.ControlWait;

	public class RichiediUrlImmagineCommand extends ControlWait
	{
		private var callback:Function;
		public function RichiediUrlImmagineCommand()
		{
			super();
		}
		override protected function executeCommand(data:Object=null):void
		{
			if(data!=null)
			{
				callback = data.callback;
				FactoryService.getInstance().geRichiediUrlImmagine( this, data ).execute();
			}
		}
		override protected function executeFault(info:Object):void
		{
			callback(null);
		}
		override protected function executeResult(result:Object):void
		{
			callback(result);
		}
	}
}