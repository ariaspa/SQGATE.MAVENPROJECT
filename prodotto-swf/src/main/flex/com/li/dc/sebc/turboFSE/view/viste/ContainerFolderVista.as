package com.li.dc.sebc.turboFSE.view.viste
{
	import com.li.dc.sebc.turboFSE.model.vo.FolderTree;
	import com.li.dc.sebc.turboFSE.util.CreateComp;
	import com.li.dc.sebc.turboFSE.view.component.LabelFolder;
	
	import mx.containers.VBox;
	
	public class ContainerFolderVista extends Vista
	{
		public var vbox:VBox;
		public function ContainerFolderVista()
		{
			super();
			createVBox();
		}
		private function createVBox():void
		{
			vbox = new VBox();
			vbox.setStyle("horizontalAlign","left" );
			vbox.setStyle("verticalAlign","top" );
			vbox.setStyle("verticalGap",4 );
			vbox.setStyle("borderStyle","none" );
		//	vbox.setStyle("backgroundColor",0xADF0A6);
			vbox.setStyle("backgroundAlpha",0);
			vbox.percentHeight	= 100;
			vbox.percentWidth	= 100;
			this.addChild( vbox );
		} 
		private function getLabel(lab:String):LabelFolder
		{
			var labelFolder:LabelFolder	 	= CreateComp.getlabelFolder();
			labelFolder.height 				= 20;
			labelFolder.textLabel 			= lab;
			labelFolder.toolTip 			= lab;
			return labelFolder;
		}
		private function createLabelFolder( ):void
		{
			if(dataVista is Array)
			{
				var children:Array	= dataVista as Array;
				for(var i:uint = 0;i<children.length;i++)
				{
					vbox.addChild( getLabel( children[i] ) );
				}
				this.invalidateDisplayList()
			}
		}
		override protected function updateData():void
	 	{
	 		this.callLater(createLabelFolder);
	 	}
	}
}