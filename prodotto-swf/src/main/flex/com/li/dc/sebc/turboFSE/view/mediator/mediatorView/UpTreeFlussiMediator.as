package com.li.dc.sebc.turboFSE.view.mediator.mediatorView
{
	import com.li.dc.sebc.turboFSE.model.vo.EventoTree;
	import com.li.dc.sebc.turboFSE.util.ConstImageTree;
	import com.li.dc.sebc.turboFSE.view.component.UpTree;
	import com.li.dc.sebc.turboFSE.view.skin.ItemRenderFSE;
	
	import it.lispa.siss.sebc.flex.debug.Debug;
	import it.lispa.siss.sebc.flex.mvc.view.Mediator;
	
	import mx.core.ClassFactory;

	public class UpTreeFlussiMediator extends Mediator
	{
		private var upTree:UpTree;
		public function UpTreeFlussiMediator()
		{
			super();
		}
		override protected function finalize():void
		{
		}
		override protected function initialize( ):void
		{
			upTree = (this.view as UpTree);
			initializeData();
			initializeView();	 
		}
		private function initializeData():void
		{
		
		}
		private function initializeView():void
		{
			upTree.styleName	 		= "canvasViewAndTree";
			upTree.showDataTips	 		= true;
			upTree.iconFunction 		= iconFunctionTreeUp;
			upTree.dataTipFunction 		= tipFunctionTreeUp;
			upTree.itemRenderer			= new ClassFactory( ItemRenderFSE );
			
			upTree.setStyle("disclosureOpenIcon",ConstImageTree.DISCLOSUREOPEN); 
			upTree.setStyle("disclosureOpenIcon",ConstImageTree.DISCLOSUREOPEN); 
			upTree.setStyle("disclosureClosedIcon",ConstImageTree.DISCLOSURECLOSE); 
			   
		}
		private function tipFunctionTreeUp(item:Object):String
		{
			if(item is EventoTree)
			{
				return (item as EventoTree).tooltip;
			}
			return "";
		}
		private function iconFunctionTreeUp(item:Object):void
		{
			if(!(item is EventoTree))return;
			var folder:EventoTree = item as EventoTree;
			var classOpen:Class ;
			var classClose:Class ;
			var figli:Boolean 	= (folder.children !=null && folder.children.length>0);
					
			if(folder.isRoot)
			{
				if(figli){
					classOpen 	= ConstImageTree.ICONVERDEOPEN;
					classClose 	= ConstImageTree.ICONVERDECLOSE;
				}else
				{
					classOpen 	= ConstImageTree.ICONGRIGIA;
					classClose 	= ConstImageTree.ICONGRIGIA;
				}
			}else
			{
				classOpen 	= ConstImageTree.ICONVERDEFOGLIA;
				classClose 	= ConstImageTree.ICONVERDEFOGLIA;
				
			} 
			if(classOpen!=null && classClose!=null)
			{ 
				upTree.setItemIcon( item,classClose,classOpen);
			}
		}
	}
}