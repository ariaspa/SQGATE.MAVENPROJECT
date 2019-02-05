package com.li.dc.sebc.turboFSE.controller.commands
{
	import com.li.dc.sebc.turboFSE.util.ViewMessageManager;
	import com.li.dc.sebc.turboFSE.view.nodeView.PanelFilters;
	
	import it.lispa.siss.sebc.flex.mvc.controller.Command;
	
	import mx.events.CloseEvent;

	public class ChiudiPanelFiltriCommand extends Command
	{
		public function ChiudiPanelFiltriCommand()
		{
			super();
		}
		override public function execute(data:Object = null):void
		{
			if(data!=null)
			{
				//var panel:PanelFilters = data as PanelFilters;
				ViewMessageManager.getInstance().closeDisplayer();
			}
		}
	}
}