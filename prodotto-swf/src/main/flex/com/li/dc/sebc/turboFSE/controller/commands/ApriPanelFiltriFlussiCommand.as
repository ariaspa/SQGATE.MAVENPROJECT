package com.li.dc.sebc.turboFSE.controller.commands
{
	import com.li.dc.sebc.turboFSE.model.FSEModel;
	import com.li.dc.sebc.turboFSE.util.UtilDate;
	import com.li.dc.sebc.turboFSE.util.ViewMessageManager;
	import com.li.dc.sebc.turboFSE.view.component.PanelFiltriFlussi;
	import com.li.dc.sebc.turboFSE.view.mediator.ConstMediator;
	import com.li.dc.sebc.turboFSE.view.mediator.TurboView;
	
	import it.lispa.siss.sebc.flex.color.HTMLTabColor;
	import it.lispa.siss.sebc.flex.mvc.controller.Command;

	public class ApriPanelFiltriFlussiCommand extends Command
	{
		public function ApriPanelFiltriFlussiCommand()
		{
			super();
		}
		override public function execute(data:Object=null):void
		{
			if(FSEModel.getInstance().panelFiltersFlussi==null)
			{
				FSEModel.getInstance().panelFiltersFlussi = new PanelFiltriFlussi();
				TurboView.getInstance().createMediator(ConstMediator.PANEL_FILTER_FLUSSI,ConstMediator.PANEL_FILTER_FLUSSI,FSEModel.getInstance().panelFiltersFlussi);
			}
			openPanel( );
		}
		private function openPanel( ):void
		{
			if(ViewMessageManager.getInstance().popUpBusy())return;
			var panel:PanelFiltriFlussi 	= FSEModel.getInstance().panelFiltersFlussi;
		//	var pad:Object			= {horizontal:100,vertical:100}; 
			ViewMessageManager.getInstance().showPanel( panel ,HTMLTabColor.GREEN );
		}
	}
}