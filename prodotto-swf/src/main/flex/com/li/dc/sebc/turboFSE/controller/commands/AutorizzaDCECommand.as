package com.li.dc.sebc.turboFSE.controller.commands
{
	import com.li.dc.sebc.turboFSE.business.FactoryService;
	import com.li.dc.sebc.turboFSE.controller.commands.serviceCommand.ControlWait;
	import com.li.dc.sebc.turboFSE.util.WrapResponder;
	
	import it.lispa.siss.sebc.flex.debug.Debug;
	
	import mx.rpc.IResponder;

	public class AutorizzaDCECommand extends ControlWait
	{
		private var finalResponder:IResponder;
		public function AutorizzaDCECommand()
		{
			super();
		}
		override protected function executeCommand(data:Object=null):void
		{
			//{agregazione:agregazione,note:note,responder:this};
			Debug.logDebug("AutorizzaDCECommand.executeCommand note : "+data.note);
			
			if(data!=null)
			{
				finalResponder = data.responder;
				// {agregazione:agregazione,note:note,responder:this}
				FactoryService.getInstance().getAutorizzaDCE(new WrapResponder(this),data.note,data.agregazione).execute();
			}
		}
		override protected function executeResult(info:Object):void
		{
			Debug.logDebug("AutorizzaDCECommand.executeResult info : "+info);
			finalResponder.result(info);
		}
		override protected function executeFault(info:Object):void
		{
			Debug.logDebug("AutorizzaDCECommand.executeFault info : "+info);
			finalResponder.fault(info);
		}
	}
}