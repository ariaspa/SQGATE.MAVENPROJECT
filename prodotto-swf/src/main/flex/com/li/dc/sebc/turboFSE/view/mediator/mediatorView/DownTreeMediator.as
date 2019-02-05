package com.li.dc.sebc.turboFSE.view.mediator.mediatorView
{
	import com.li.dc.sebc.turboFSE.util.ConstImageTree;
	import com.li.dc.sebc.turboFSE.view.component.DownTree;
	
	import it.lispa.siss.sebc.flex.mvc.view.Mediator;

	public class DownTreeMediator extends Mediator
	{
		private var tree:DownTree;
		public function DownTreeMediator()
		{
			super();
		}
		override protected function finalize():void
		{
		}
		override protected function initialize( ):void
		{
			tree = this.view as DownTree;
			initializeData();
			initializeView();
		}
		private function  initializeData():void
		{
			
		}
		 
		private function  initializeView():void
		{
			tree.setStyle("disclosureOpenIcon",ConstImageTree.DISCLOSUREOPEN); 
			tree.setStyle("disclosureClosedIcon",ConstImageTree.DISCLOSURECLOSE); 
			tree.labelField			= "label";
			tree.iconFunction		= iconFunctionTree;
			tree.dataTipFunction 	= tipFunctionTree;	 
		}
		private function tipFunctionTree(item:Object):String
		{
			return item.toolTip;
		}
		private function iconFunctionTree(item:Object):void
		{
			var classOpen:Class 	= ConstImageTree.ICONVISTA;
			var classClose:Class 	= ConstImageTree.ICONVISTA;
			var lab:String 			= item.label; 
			if(lab!=null && lab.toUpperCase()== "VISTE")
			{
				classClose	= ConstImageTree.ICONVISTACLOSE;
				classOpen	= ConstImageTree.ICONVISTAOPEN;
			} 
			tree.setItemIcon(item,classClose,classOpen);
		}
	}
}