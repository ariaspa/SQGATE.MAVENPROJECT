package com.li.dc.sebc.turboFSE.controller.commands.serviceCommand
{
	import com.li.dc.sebc.turboFSE.controller.commands.ResponderCommand;
	import com.li.dc.sebc.turboFSE.model.ConstDataProxy;
	import com.li.dc.sebc.turboFSE.model.FSEModel;
	import com.li.dc.sebc.turboFSE.view.nodeView.AreaLavoro;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class ControlWait extends ResponderCommand
	{
		public function ControlWait()
		{
			super();
		}
		final override public function execute(data:Object=null):void
		{
			openWait();
			executeCommand( data );
		}
		protected function executeCommand(data:Object=null):void
		{
			
		}
		protected function executeResult(info:Object):void
		{
			
		
		}
		protected function executeFault(info:Object):void
		{
			
		}
		protected function closeWait():void
		{
			var m:FSEModel = FSEModel.getInstance();
			m.retrieveProxy(ConstDataProxy.STATE_AREA_LAVORO).update( AreaLavoro.ACTIVE );
			
			//var nt:Timer = new Timer(150);
			//nt.addEventListener(TimerEvent.TIMER,onTimer);
			//nt.start();
		}
		private function onTimer(e:TimerEvent):void
		{
			(e.target as Timer).stop();
			(e.target as Timer).removeEventListener(TimerEvent.TIMER,onTimer);
			var m:FSEModel = FSEModel.getInstance();
			m.retrieveProxy(ConstDataProxy.STATE_AREA_LAVORO).update( AreaLavoro.ACTIVE );
		}
		protected function openWait(msg:String=null):void
		{
			var m:FSEModel = FSEModel.getInstance();
			m.retrieveProxy(ConstDataProxy.STATE_AREA_LAVORO).update( AreaLavoro.WAIT );
		}
		 
		final override public function result(data:Object):void
		{
			closeWait();
			executeResult(data);
		}
		final override public function fault(info:Object):void
		{
			closeWait();
			executeFault(info);
		}
	}
}