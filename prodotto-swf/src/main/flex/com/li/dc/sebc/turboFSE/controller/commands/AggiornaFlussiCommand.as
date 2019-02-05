package com.li.dc.sebc.turboFSE.controller.commands
{
	import com.li.dc.sebc.turboFSE.controller.ConstCommand;
	import com.li.dc.sebc.turboFSE.model.ConstDataProxy;
	import com.li.dc.sebc.turboFSE.model.FSEModel;
	import com.li.dc.sebc.turboFSE.util.window.GestWindows;
	
	import it.lispa.siss.sebc.flex.mvc.controller.Command;
	import it.lispa.siss.sebc.flex.mvc.controller.Controller;
	
	import mx.collections.ArrayCollection;

	public class AggiornaFlussiCommand extends Command
	{
		public function AggiornaFlussiCommand()
		{
			super();
		}
		override public function execute(data:Object=null):void
		{
			GestWindows.getInstance().clearAll();
			FSEModel.getInstance().hashViste.clear();
			
			/* promemoria per quando ci sarà la gestione delle popup esterne */
			//GestWindows.getInstance().clearAll();
			// pulire la parte delle viste 
			 
			FSEModel.getInstance().retrieveProxy(ConstDataProxy.DATA_FLUSSI_SELECT).update( null );
			FSEModel.getInstance().retrieveProxy( ConstDataProxy.DATA_VISIBLE_UP_FLUSSI ).update( new ArrayCollection() );
			
			Controller.getInstance().executeCommand(ConstCommand.DAMMI_FLUSSI); 
		}
	}
}