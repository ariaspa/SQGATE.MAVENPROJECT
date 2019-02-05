package com.li.dc.sebc.turboFSE.view.component
{
	import mx.controls.Button;
	
	[Style(name="checkUpSkin", type="Class", inherit="no")]
	[Style(name="checkSelectUpSkin", type="Class", inherit="no")]
	[Style(name="checkOverSkin", type="Class", inherit="no")]
	[Style(name="checkSelectOverSkin", type="Class", inherit="no")]
	[Style(name="checkDownSkin", type="Class", inherit="no")]
	[Style(name="checkSelectDownSkin", type="Class", inherit="no")]
	[Style(name="backgroundColor", type="Class", inherit="no")]
	public class ButtonIconaFocus extends Button
	{
		public function ButtonIconaFocus()
		{
			super();
			this.styleName = "titleBarView";
			this.toggle = true;
			this.height = this.width = this.measuredMinWidth  = this.measuredMinHeight = 22;
		}
		public override function initialize():void
		{
		 	super.initialize();
		 	
		 	var skin:* ;
		 	if((skin =  this.getStyle("checkUpSkin")) != null)
		 	{
		 		this.setStyle("upSkin",skin);
		 	}
		 	if((skin =  this.getStyle("checkSelectUpSkin")) != null)
		 	{
		 		this.setStyle("selectedUpSkin", skin);
		 	}
		 	if((skin =  this.getStyle("checkOverSkin")) != null)
		 	{
		 		this.setStyle("overSkin", skin);
		 	}
		 	 if((skin =  this.getStyle("checkSelectOverSkin")) != null)
		 	{
		 		this.setStyle("selectedOverSkin", skin);
		 	}
		 	if((skin =  this.getStyle("checkDownSkin")) != null)
		 	{
		 		this.setStyle("downSkin", skin);
		 	}
		 	if((skin =  this.getStyle("checkSelectDownSkin")) != null)
		 	{
		 		this.setStyle("selectedDownSkin", skin);
		 	}
		}
	}
}
	import flash.display.GradientType;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	
	import mx.skins.halo.ButtonSkin;
	import mx.utils.ColorUtil;
	import flash.filters.GradientGlowFilter;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BitmapFilterType;
	import flash.display.SpreadMethod;
	import flash.display.InterpolationMethod;
	
class SkinFocus extends mx.skins.halo.ButtonSkin
{
	public function SkinFocus()
	{
		super();
	}
	private function getDrawProperty():Object
	{
		var o:Object			= {};
		o.cornerRadius  		= getStyle("cornerRadius");   
		o.borderColor 			= getStyle("borderColor");
		o.backgroundAlpha   	= getStyle("backgroundAlpha");
		o.backgroundColor   	= getStyle("backgroundColor");
		o.fillColors			= getStyle("fillColors");
		o.fillAlphas 			= getStyle("fillAlphas");
		o.fillShadowColors 		= getStyle("fillShadowColors");
		o.fillShadowAlphas 		= getStyle("fillShadowAlphas");
		o.fillDisabledColor 	= getStyle("fillDisabledColor");
		o.fillDisabledAlpha 	= getStyle("fillDisabledAlpha");	
		return o;
	}
	override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
	{
		super.updateDisplayList(unscaledWidth,unscaledHeight);
		graphics.clear();
		this.filters = [];
		switch(name)
		{
			case "upSkin":
				drawUpSkin(unscaledWidth,unscaledHeight);
				break;
			case "overSkin":
				drawOverSkin(unscaledWidth,unscaledHeight);
				break;
			case "downSkin":
				drawDownSkin(unscaledWidth,unscaledHeight);
				break;
			case "selectedUpSkin":
				drawSelectedUpSkin(unscaledWidth,unscaledHeight);
				break;
			case "selectedOverSkin":
				drawSelectedOverSkin(unscaledWidth,unscaledHeight);
				break;
			case "selectedDownSkin":
				drawSelectedDownSkin(unscaledWidth,unscaledHeight);
				break;
			case "disabledSkin":
			case "selectedDisabledSkin":
				drawDisabled(unscaledWidth,unscaledHeight);
				break;
		}
	}
		 
	private function drawBackGround(w:Number,h:Number,backgroundColor:int,borderColor:int,corner:Number):void
	{
		graphics.lineStyle(2,borderColor,0.4);
		graphics.drawRoundRect(0,0,w,h,corner,corner);
		graphics.endFill();
		//
		graphics.beginFill(backgroundColor,0.1);
		graphics.drawRoundRect(1,1,w-2,h-2,corner,corner); 
		graphics.endFill();
	}	
	private function drawUpSkin(w:Number,h:Number):void
	{
		var o:Object	= getDrawProperty();
		
		var corner:Number	= (o.cornerRadius!=null) ? o.cornerRadius : 2 ;
		
		var backgroundColor:int = (o.backgroundColor!= null) ? o.backgroundColor  : 0x009966 ;
		var borderColor:int 	= (o.borderColor!= null) ? o.borderColor  : ColorUtil.adjustBrightness2(backgroundColor, -50) ;
		//
		var min:Number 			= Math.max(w,h);
		 
		drawBackGround(min,min,backgroundColor,borderColor,corner);
		 
		/*var fillType:String 		= GradientType.RADIAL;
		var spreadMethod:String 	= SpreadMethod.PAD;
		var matr:Matrix 			= new Matrix();
		
		matr.createGradientBox(25, 25, 45 ,-ww,-(ww+5)); 
		var colors:Array	= [borderColor,backgroundColor];
		var alphas:Array	= [0.5,0.5];
		var ratios:Array	= [0,255];
		  
		graphics.beginGradientFill(fillType, colors, alphas, ratios, matr, spreadMethod,InterpolationMethod.LINEAR_RGB);   
		graphics.drawCircle(w/2,w/2,w);
		graphics.endFill();*/
	}
	private function drawOverSkin(w:Number,h:Number):void
	{
		drawUpSkin(w,h);
	}
	
	private function drawDownSkin(w:Number,h:Number):void
	{
		drawSelectedUpSkin(w,h);
	}
	
	private function drawSelectedUpSkin(w:Number,h:Number):void
	{
		drawUpSkin(w,h);
		var aaa:Number			= Math.min(w,h);
		var min:Number 			= aaa / 2 ;
		var barr:Number	= min / 3;
		
		var p:Number = (aaa-min)/2;
		
		graphics.lineStyle(2,0xFFFFFF,1);
		graphics.drawRect(p,p,min,min);
		graphics.endFill();
		
		graphics.beginFill(0xFFFFFF,1);
		graphics.drawRect(p,p,min,barr);
		graphics.endFill();
		
		var o:Object			= getDrawProperty();
		var backgroundColor:int = (o.backgroundColor!= null) ? o.backgroundColor  : 0x009966 ;
		var borderColor:int 	= (o.borderColor!= null) ? o.borderColor  : backgroundColor ;
		
		var gradientGlow:GradientGlowFilter = new GradientGlowFilter();
		gradientGlow.distance 	= 0;
		gradientGlow.angle 		= 45;
		gradientGlow.colors 	= [backgroundColor, borderColor];
		gradientGlow.alphas 	= [0, 1];
		gradientGlow.ratios 	= [0, 255];
		gradientGlow.blurX 		= 10;
		gradientGlow.blurY 		= 10;
		gradientGlow.strength 	= 2;
		gradientGlow.quality 	= BitmapFilterQuality.HIGH;
		gradientGlow.type 		= BitmapFilterType.OUTER;
		this.filters 			= [gradientGlow];
		/*
		var o:Object			= getDrawProperty();
		var backgroundColor:int = (o.backgroundColor!= null) ? o.backgroundColor  : 0x009966 ;
		var borderColor:int 	= (o.borderColor!= null) ? o.borderColor  : backgroundColor ;
		var corner:Number	= o.cornerRadius;
		backgroundColor 		= ColorUtil.adjustBrightness2(backgroundColor, 60) ;
		borderColor 			= ColorUtil.adjustBrightness2(borderColor, 60) ;
		
		var gradientGlow:GradientGlowFilter = new GradientGlowFilter();
		gradientGlow.distance 	= 0;
		gradientGlow.angle 		= 45;
		gradientGlow.colors 	= [backgroundColor, borderColor];
		gradientGlow.alphas 	= [0, 1];
		gradientGlow.ratios 	= [0, 255];
		gradientGlow.blurX 		= 10;
		gradientGlow.blurY 		= 10;
		gradientGlow.strength 	= 2;
		gradientGlow.quality 	= BitmapFilterQuality.HIGH;
		gradientGlow.type 		= BitmapFilterType.OUTER;
		this.filters 			= [gradientGlow];
		*/
	}
	private function drawSelectedOverSkin(w:Number,h:Number):void
	{
		drawSelectedUpSkin(w,h);
	}
	
	private function drawSelectedDownSkin(w:Number,h:Number):void
	{
		drawSelectedUpSkin(w,h);
	}
	
	private function drawDisabled(w:Number,h:Number):void
	{
		/*var o:Object	= getDrawProperty();
		var backgroundColor:int = (o.backgroundColor!= null) ? o.backgroundColor  : 0x009966 ;
		var borderColor:int 	= (o.borderColor!= null) ? o.borderColor  : ColorUtil.adjustBrightness2(backgroundColor, -50) ;
		//
		var ww:Number	= ((w - 5) <5) ? 5 : w - 5;  	
		var hh:Number	= ((h - 5) <5) ? 5 : h - 5;  	
		//
		drawBackGround(ww,hh,backgroundColor,borderColor);*/ 
	} 
}