package com.li.dc.sebc.turboFSE.view.builders
{
	import com.li.dc.sebc.turboFSE.controller.ConstCommand;
	import com.li.dc.sebc.turboFSE.model.vo.DataLabelTree;
	import com.li.dc.sebc.turboFSE.view.viste.Vista;
	
	import it.lispa.siss.sebc.flex.mvc.controller.Controller;
	
	public class TemporaleBuilder extends Builder
	{
		public function TemporaleBuilder()
		{
			super();
		}
		// metto il click
		override protected function createMediator( v:Vista ):void
		{
			//this.currentData as DataLabelTree;
			Controller.getInstance().executeCommand(ConstCommand.GO_TEMPORALE);
		}
	}
}