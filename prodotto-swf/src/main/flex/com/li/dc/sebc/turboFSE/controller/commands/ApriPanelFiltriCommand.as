package com.li.dc.sebc.turboFSE.controller.commands
{
	import com.li.dc.sebc.turboFSE.model.FSEModel;
	import com.li.dc.sebc.turboFSE.util.ViewMessageManager;
	import com.li.dc.sebc.turboFSE.view.mediator.ConstMediator;
	import com.li.dc.sebc.turboFSE.view.mediator.TurboView;
	import com.li.dc.sebc.turboFSE.view.nodeView.PanelFilters;
	
	import it.lispa.siss.sebc.flex.color.HTMLTabColor;
	import it.lispa.siss.sebc.flex.mvc.controller.Command;

	public class ApriPanelFiltriCommand extends Command
	{
		public function ApriPanelFiltriCommand()
		{
			super();
		}
		override public function execute(data:Object=null):void
		{
			if(data !=null)
			{
				if(FSEModel.getInstance().panelFilters==null)
				{
					FSEModel.getInstance().panelFilters = new PanelFilters();
					TurboView.getInstance().createMediator(ConstMediator.PANEL_FILTER,ConstMediator.PANEL_FILTER,FSEModel.getInstance().panelFilters);
				}
				openPanel(data as int);
			}
		}
		private function openPanel(index:int):void
		{
			if(ViewMessageManager.getInstance().popUpBusy())return;
			var panel:PanelFilters 	= FSEModel.getInstance().panelFilters;
			//var pad:Object			= {horizontal:20,vertical:20}; 
			ViewMessageManager.getInstance().showPanel( panel ,HTMLTabColor.GREEN );
			panel.indexAccordion = index;
		}
	}
}