package com.li.dc.sebc.turboFSE.controller.commands.serviceCommand
{
	import com.li.dc.sebc.turboFSE.business.FactoryService;
	import com.li.dc.sebc.turboFSE.util.WrapResponder;
	
	import it.lispa.siss.sebc.flex.debug.Debug;
	
	import mx.rpc.Fault;
	import mx.rpc.IResponder;
	
	public class LoadOperatoreCommand extends ControlWait
	{
		//private var responder:IResponder;
		public function LoadOperatoreCommand()
		{
			super();
		}
		
		override protected function executeCommand(data:Object=null):void
		{
			Debug.logDebug( "LoadOperatoreCommand . executeCommand" );
			if(data!=null && data is IResponder)
			{
				//responder = data as IResponder;
				FactoryService.getInstance().getOperatoreOnDemand( data as IResponder ).execute();
			} 
		}
		
	/* 	
		vecchio codice
	override protected function executeResult(data:Object):void
		{
			Debug.logDebug( "LoadOperatoreCommand . result" );
			responder.result( data );
		}
		override protected function executeFault(info:Object):void
		{
			Debug.logDebug( "LoadOperatoreCommand FAULT ");
			if(info is Fault){
				Debug.logDebug( "LoadOperatoreCommand . fault " +(info as Fault).getStackTrace());
			}
			responder.fault( info );
		} */
	}
}




