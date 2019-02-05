package com.li.dc.sebc.turboFSE.controller.commands.pdt
{
	import com.li.dc.sebc.turboFSE.controller.ConstCommand;
	
	import it.lispa.siss.sebc.flex.debug.Debug;
	import it.lispa.siss.sebc.flex.messages.MessageManager;
	import it.lispa.siss.sebc.flex.mvc.controller.SequenceCommand;

	public class ClosePdtInFascicolo extends SequenceCommand
	{
		 
		public function ClosePdtInFascicolo()
		{
			super();
		}
		override protected function initialize(): void
	    { 
	    	super.initialize();
	    	Debug.logDebug( " ClosePdtInFascicolo " );
	    	 
			addCommand(ConstCommand.CLOSE_PDT_SERVICE);

			addCommand(ConstCommand.REFRESH_FOLDER_PDT);
			 
	    }
		 
		override protected function completeSequence(data:Object=null):void
		{
			Debug.logDebug( "ClosePdtInFascicolo.completeSequence " ); 
			if(data!=null)
			{
				// mi sta arrivando un errore da CLOSE_PDT_SERVICE
				MessageManager.getInstance().addMessage( data );
			}
		}
	}
}