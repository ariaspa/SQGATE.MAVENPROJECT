package com.li.dc.sebc.turboFSE.controller.commands.pdt
{
	import com.li.dc.sebc.turboFSE.controller.ConstCommand;
	
	import it.lispa.siss.sebc.flex.debug.Debug;
	import it.lispa.siss.sebc.flex.messages.MessageManager;
	import it.lispa.siss.sebc.flex.mvc.controller.SequenceCommand;

	public class AddPdtInFascicolo extends SequenceCommand
	{
		public function AddPdtInFascicolo()
		{
			super();
		}
		override protected function initialize(): void
	    { 
	    	super.initialize();
	    	Debug.logDebug( " AddPdtInFascicolo " );
	    	 
			addCommand(ConstCommand.OPEN_PDT_SERVICE);

			addCommand(ConstCommand.REFRESH_FOLDER_PDT);
			 
	    }
		override protected function completeSequence(data:Object=null):void
		{
			Debug.logDebug( "AddPdtInFascicolo.completeSequence " ); 
			//FSEModel.getInstance().retrieveProxy(ConstDataProxy.STATE_STACK).update( Root.STATE_STACK_VISUALIZZA );
			if(data!=null)
			{
				// mi sta arrivando un errore da OPEN_PDT_SERVICE
				MessageManager.getInstance().addMessage( data );
			}
		}
	}
}