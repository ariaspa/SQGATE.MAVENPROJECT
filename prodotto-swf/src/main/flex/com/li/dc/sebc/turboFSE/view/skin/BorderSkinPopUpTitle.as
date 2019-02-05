package com.li.dc.sebc.turboFSE.view.skin
{
	import flash.display.GradientType;
	import flash.display.InterpolationMethod;
	import flash.display.SpreadMethod;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	
	import it.lispa.siss.sebc.flex.utils.GraphicsUtils;
	
	import mx.skins.ProgrammaticSkin;
	import mx.utils.ColorUtil;
	
	public class BorderSkinPopUpTitle extends ProgrammaticSkin
	{
		public function BorderSkinPopUpTitle()
		{
			super();
		}
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			var w:Number			= unscaledWidth;
			var h:Number			= unscaledHeight;
			var cornerRadius:int 	= getStyle("cornerRadius"); 
			var themeColor:uint 	= 0;
			var titleColorObject:Object = getStyle("titleColor");
			if(titleColorObject!=null)
			{
				themeColor = titleColorObject as uint;
			}else
			{
				themeColor = getStyle("backgroundColor");
			}
			var buttonColor:uint 	= ColorUtil.adjustBrightness(themeColor,-50);
		 	graphics.clear();
		 	graphics.beginFill(buttonColor,1);
		 	graphics.drawRoundRectComplex(0,0,unscaledWidth,unscaledHeight,cornerRadius,cornerRadius,0,0);
		 	graphics.endFill();
		 	 
			var white:uint 			= 0xFFFFFF; 
			//var color4:uint 		= ColorUtil.adjustBrightness( buttonColor , 50 );  
			var rect:Rectangle		= new Rectangle(0,0,w,h);
			//	 
			// background
			graphics.beginFill(buttonColor,1);
			graphics.drawRoundRect(rect.y,rect.y,rect.width,rect.height,cornerRadius,cornerRadius);
			graphics.endFill();
			//
			var type:String  		= GradientType.LINEAR;
			var spreadMethod:String = SpreadMethod.PAD;
			var interp:String 		= InterpolationMethod.LINEAR_RGB;
			var focalPtRatio:Number = 0;
			var boxWidth:Number 	= rect.width;
			var boxHeight:Number 	= rect.height;
			var rotation:Number 	= -90 * Math.PI / 180;
			var tx:Number 			= 0;
			var ty:Number 			= 0;
			//
			var matrix:Matrix 		= new Matrix();
			var colors:Array 		= [buttonColor, white];
			var alphas:Array 		= [0.5, 0]; 
			var ratios:Array 		= [127,255];
		 	matrix.createGradientBox(boxWidth, boxHeight, rotation, tx, ty);
			graphics.beginGradientFill(type, 
			                            colors,
			                            alphas,
			                            ratios, 
			                            matrix, 
			                            spreadMethod, 
			                            interp, 
			                            focalPtRatio);
			                            
			graphics.drawRoundRectComplex(rect.y,rect.y,rect.width,rect.height,cornerRadius,cornerRadius,0,0);                      
			graphics.endFill();  
		 	
		 	
		 	// horizontal nuance
		  	rotation 				= 0;
			colors 					= [white,themeColor];
			alphas 					= [0.6, 0.1, 0.1, 0.6]; 
			ratios 					= GraphicsUtils.getRatios(4);
			matrix					= new Matrix();
			matrix.createGradientBox(boxWidth, boxHeight, rotation, 10, ty);
			graphics.beginGradientFill(type, 
			                            colors,
			                            alphas,
			                            ratios, 
			                            matrix, 
			                            spreadMethod, 
			                            interp, 
			                            focalPtRatio);
			                            
			graphics.drawRoundRectComplex(rect.y,rect.y,rect.width,rect.height,cornerRadius,cornerRadius,0,0);                      
			graphics.endFill();  
			// horizontal nuance
		  	rotation 				= 0;
			colors 					= [ themeColor, white , white , themeColor ]
			alphas 					= [0.6, 0.1, 0.1, 0.6]; 
			ratios 					= GraphicsUtils.getRatios(4);
			matrix					= new Matrix();
			matrix.createGradientBox(boxWidth, boxHeight, rotation, tx, ty);
			graphics.beginGradientFill(type, 
			                            colors,
			                            alphas,
			                            ratios, 
			                            matrix, 
			                            spreadMethod, 
			                            interp, 
			                            focalPtRatio);
			                            
			graphics.drawRoundRectComplex(rect.y,rect.y,rect.width,rect.height,cornerRadius,cornerRadius,0,0);                      
			graphics.endFill();  
			// vertical nuance 
			colors 					= [ themeColor, buttonColor , white , themeColor ];
			alphas 					= [0.6, 0.2, 0.2, 0.6]; 
			//ratios 					= [63,127,170,245];
			rotation 				= -90 * Math.PI / 180;
			matrix 					= new Matrix();
			matrix.createGradientBox(boxWidth, boxHeight, rotation, tx, ty);
			graphics.beginGradientFill(type, 
			                            colors,
			                            alphas,
			                            ratios, 
			                            matrix, 
			                            spreadMethod, 
			                            interp, 
			                            focalPtRatio);
			                            
			graphics.drawRoundRectComplex(rect.y,rect.y,rect.width,rect.height,cornerRadius,cornerRadius,0,0);                      
			graphics.endFill();
			// line
			graphics.lineStyle(1.5,themeColor,0.8,true);
			graphics.drawRoundRectComplex(rect.y,rect.y,rect.width,rect.height,cornerRadius,cornerRadius,0,0);
			graphics.endFill();
		}
	}
}