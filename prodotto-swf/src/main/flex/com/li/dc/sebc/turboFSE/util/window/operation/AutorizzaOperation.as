package com.li.dc.sebc.turboFSE.util.window.operation
{
	import com.li.dc.sebc.turboFSE.controller.ConstCommand;
	import com.li.dc.sebc.turboFSE.fseTurbo;
	import com.li.dc.sebc.turboFSE.util.window.ListenerWindow;
	
	import it.lispa.siss.sebc.flex.debug.Debug;
	import it.lispa.siss.sebc.flex.messages.MessageManager;
	import it.lispa.siss.sebc.flex.mvc.controller.Controller;
	
	import mx.rpc.IResponder;
	
	use namespace fseTurbo
	public class AutorizzaOperation implements IResponder 
	{
		public static var noteReperibilita:String;
		private var reference:ListenerWindow;
		public function AutorizzaOperation(reference:ListenerWindow)
		{
			this.reference = reference;
		}
		public function execute(note:String,agregazione:Array):void
		{
			Debug.logDebug("AutorizzaOperation.execute note : "+note);
			noteReperibilita = note;
			var data:Object	= {agregazione:agregazione,note:note,responder:this};
			Controller.getInstance().executeCommand(ConstCommand.AUTORIZZA_DCE,data);
		}
		public function result(data:Object):void
		{
			refreshAutorizza(data as Boolean);
		}
		public function fault(info:Object):void
		{
			MessageManager.getInstance().addMessage( info );
		}
		private function refreshAutorizza(flag:Boolean):void
		{
			reference.send( ["responseAutorizza",flag] );
		}
	}
}