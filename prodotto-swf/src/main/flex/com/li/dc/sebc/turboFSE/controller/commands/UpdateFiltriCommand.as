package com.li.dc.sebc.turboFSE.controller.commands
{
	import com.li.dc.sebc.turboFSE.controller.ConstCommand;
	import com.li.dc.sebc.turboFSE.model.ConstDataProxy;
	import com.li.dc.sebc.turboFSE.model.FSEModel;
	import com.li.dc.sebc.turboFSE.model.filters.ManagerFilters;
	import com.li.dc.sebc.turboFSE.model.vo.Tree;
	import com.li.dc.sebc.turboFSE.util.Utils;
	import com.li.dc.sebc.turboFSE.view.nodeView.PanelFilters;
	
	import it.lispa.siss.sebc.flex.mvc.controller.Command;
	import it.lispa.siss.sebc.flex.mvc.controller.Controller;
	
	import mx.collections.ArrayCollection;

	public class UpdateFiltriCommand extends Command
	{
		public function UpdateFiltriCommand()
		{
			super();
		}
		override public function execute(data:Object=null):void
		{
			if(data != null)
			{
				var panel:PanelFilters 		= data as PanelFilters;
				Controller.getInstance().executeCommand(ConstCommand.FILTRA_DATA_TREE);
				Controller.getInstance().executeCommand(ConstCommand.CHIUDI_PANEL_FILTRI,panel);
			}
		}
	}
}