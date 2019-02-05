package com.li.dc.sebc.turboFSE.view.skin
{
	import flash.display.Graphics;
	import mx.controls.treeClasses.TreeItemRenderer;

	public class ItemRenderFSE extends TreeItemRenderer
	{
		public function ItemRenderFSE()
		{
			super();
		}
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void{
        	super.updateDisplayList(unscaledWidth,unscaledHeight);
        	if(this.disclosureIcon!=null)
        	{
        		this.disclosureIcon.alpha = 1;
	        	if(data!=null && (data.children==null || data.children.length==0))
	        	{
	        		this.disclosureIcon.alpha = 0;
	        	}
	            var g:Graphics = this.graphics;
	            g.clear();
	            g.lineStyle(1,0x00FF99,0.2);
	            g.drawRect(0,0,this.width,this.height);
	            g.endFill();
         	}
        }
		override public function set data(value:Object):void
		{
            super.data = value;
        }
	}
}