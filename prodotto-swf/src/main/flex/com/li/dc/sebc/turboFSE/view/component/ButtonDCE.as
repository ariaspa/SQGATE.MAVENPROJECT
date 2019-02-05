package com.li.dc.sebc.turboFSE.view.component
{
	import com.li.dc.sebc.turboFSE.view.skin.IconButtonFolder;
	
	import flash.events.MouseEvent;
	
	import mx.controls.Button;
	import mx.core.mx_internal;
	import mx.skins.halo.ButtonSkin;
	
	use namespace mx_internal;
	public class ButtonDCE extends Button
	{
		private var flag:Boolean;
		public function ButtonDCE()
		{
			super();
			this.setStyle("upIcon",IconButtonFolder);
			this.setStyle("overIcon",IconButtonFolder);
			this.setStyle("downIcon",IconButtonFolder);
			this.setStyle("selectedUpIcon",IconButtonFolder);
			this.setStyle("selectedOverIcon",IconButtonFolder);
			this.setStyle("selectedDownIcon",IconButtonFolder);
			this.setStyle("skin",ButtonDCESkin);
			this.setStyle("textAlign","left");
			this.setStyle("fontSize",12);
			this.styleName 		= "buttonDCE";
			this.labelPlacement = "right";
			this.toggle 		= true; 
			flag 				= false;
		} 
		public override function get label():String
		{
			return flag ? "" : super.label;
		}
		override protected function measure():void
		{
			flag = true;
			super.measure();
			flag = false;
		} 
	}
}
	import mx.skins.halo.ButtonSkin;
	import mx.styles.StyleManager;
	import it.lisit.siss.flex.utility.debug.Debug;
	import mx.utils.ColorUtil;
	import mx.core.IButton;
	import flash.display.GradientType;
	import flash.display.Graphics;
	
class ButtonDCESkin extends ButtonSkin
{
	public function ButtonDCESkin()
	{
		super();
	}
	override protected function updateDisplayList(w:Number, h:Number):void
	{
		var x:Number = 4;
		var y:Number = 4;
		w = w-8;
		h = h-8;
		var cornerRadius:Number 	= getStyle("cornerRadius");
		var highlightAlphas:Array 	= getStyle("highlightAlphas");
		var fillAlphas:Array = [0,0.8];
		var fillColors:Array = [0xFFFFFF,0];
		var cr:Number = Math.max(0, cornerRadius);
		var cr1:Number = Math.max(0, cornerRadius - 1);
		graphics.clear();
		switch (name)
		{
			case "upSkin":
				break;
			case "selectedOverSkin":
			case "overSkin":
				fillAlphas = [0.4,0.8];
				break;
			case "downSkin":
			case "selectedUpSkin":
			case "selectedDownSkin":
		}	
		drawRoundRect( x, y, w , h ,cr,fillColors,fillAlphas,verticalGradientMatrix(x, y, w, h ));	
		drawRoundRect(x+1, y+1, w - 2, (h - 2) / 2,{ tl: cr1, tr: cr1, bl: 0, br: 0 },[ 0xFFFFFF, 0xFFFFFF ], highlightAlphas,verticalGradientMatrix(1, 1, w - 2, (h - 2) / 2)); 
		
		var g:Graphics = graphics;
		 
		g.beginFill(0xFFFFFF,1);
		g.moveTo( 0, 0 );
		g.lineTo( w+x+x , 0 );
		g.lineTo( w+x+x , h+y+y );
		g.lineTo( 0 , h+y+y );
		g.lineTo( 0 , 0 );
		g.lineTo( x , y );
		g.lineTo( w+x , y );
		g.lineTo( w+x , h+y );
		g.lineTo( x , h+y );
		g.lineTo( x , y );
		g.endFill();
			 
	}
} 