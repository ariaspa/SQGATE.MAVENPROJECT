package com.li.dc.sebc.turboFSE.util
{
	import com.li.dc.sebc.turboFSE.view.component.ButtonFolder;
	import com.li.dc.sebc.turboFSE.view.component.LabelFolder;
	
	import mx.containers.VBox;
	import mx.controls.Button;
	import mx.controls.Label;

	public class CreateComp
	{
		/* Bottoni rettangolari che aprono il contenuto dei metadati dei folder */
		public static function getButtonRect(lab:String,tip:String):ButtonFolder
		{
			var btn:ButtonFolder 	= new ButtonFolder();
			btn.toggle  			= true;
			btn.percentWidth 		= 100;
			btn.height 				= 30;
			btn.buttonMode			= true;
			btn.label				= lab;
			btn.toolTip				= lab;
			btn.setStyle("cornerRadius",0);
			return btn;
		}
		
		 
		public static function getlabelFolder():LabelFolder
		{
			return new LabelFolder();
		}
		public static function getBox():VBox
		{
			var box:VBox  				= getBoxWithScroll();
			box.verticalScrollPolicy 	= "off";
			box.horizontalScrollPolicy 	= "off";
			return box;
		}
		
		public static function getLabelLabel():Label
		{
			var label:Label 		= new Label();
			label.setStyle("color",0x336600);
			label.setStyle("fontSize",12);
			return label;
		}
		public static function getLabelValue():Label
		{
			var label:Label 	= new Label();
			label.selectable 	= true;
			label.setStyle("color",0);
			return label;
		}
		public static function getBoxWithScroll():VBox
		{
			var box:VBox  			= new VBox();
			//box.percentHeight 		= 100;
			box.percentWidth 		= 100;
			box.setStyle("verticalGap",0 );
			box.setStyle("paddingBottom",4 );
			box.setStyle("paddingLeft",4 );
			box.setStyle("paddingRight",4 );
			box.setStyle("paddingTop",4);
			box.setStyle("backgroundAlpha",0);
			return box;
		}
		public static function createBox():VBox
		{
			var box:VBox  = getBox();
			box.setStyle("verticalGap",4 );
			box.setStyle("paddingBottom",4 );
			box.setStyle("paddingLeft",4 );
			box.setStyle("paddingRight",4 );
			box.setStyle("paddingTop",4 );
			box.setStyle("backgroundAlpha",0.5);
			
			box.setStyle("backgroundColor",0xEEFFEF);
			
			box.setStyle("borderStyle","solid");
			box.setStyle("borderThickness",1);
			box.setStyle("borderColor",0x336600);
			return box;
		}
	}
}