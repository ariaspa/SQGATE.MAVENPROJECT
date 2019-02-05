package com.li.dc.sebc.turboFSE.controller.commands.serviceCommand
{
	import com.li.dc.sebc.turboFSE.controller.ConstCommand;
	import com.li.dc.sebc.turboFSE.model.ConstDataProxy;
	import com.li.dc.sebc.turboFSE.model.FSEModel;
	
	import it.lispa.siss.sebc.flex.mvc.controller.Command;
	import it.lispa.siss.sebc.flex.mvc.controller.Controller;
	
	public class AggiornaTimelineCommand extends Command
	{
		/**
		 * Carica i documenti necessari alla vista della time line
		 * e li trasforma  
		 */		
		public function AggiornaTimelineCommand()
		{
			super();
		}
		override public function execute(data:Object=null):void
		{
			
			// cancello i dati visualizzati - l'evento lo raccoglie il mediator
			FSEModel.getInstance().retrieveProxy(ConstDataProxy.DATA_TIMELINE).update( null );
			// carico i dati nuovi
			Controller.getInstance().executeCommand( ConstCommand.DAMMI_TIMELINE  ); 
			
		}
	}
}