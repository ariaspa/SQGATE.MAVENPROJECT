package com.li.dc.sebc.turboFSE.view.skin
{
	import flash.display.Graphics;
	import flash.filters.DropShadowFilter;
	
	import mx.graphics.RectangularDropShadow;
	import mx.skins.halo.ToolTipBorder;
	import mx.utils.ColorUtil;
 
	
	public class NewToolTipBorder extends ToolTipBorder
	{
		private var dropShadow:RectangularDropShadow;
		public function NewToolTipBorder()
		{
			super();
			 
		}
		/**
	 *  @private
	 *  Draw the background and border.
	 */
	override protected function updateDisplayList(w:Number, h:Number):void
	{	
		super.updateDisplayList(w, h);
		 
		var borderStyle:String 			= getStyle("borderStyle");
		var backgroundColor:uint	 	= getStyle("backgroundColor");
		var backgroundAlpha:Number		= getStyle("backgroundAlpha");
		var borderColor:uint 			= getStyle("borderColor");
		var cornerRadius:Number 		= getStyle("cornerRadius");
		var shadowColor:uint 			= getStyle("shadowColor");
		var shadowAlpha:Number 			= 0.1;
		var g:Graphics 					= this.graphics;
		g.clear();
		
		filters = [];
		
		switch (borderStyle)
		{
			case "toolTip":
			{
				
				// face
				drawRoundRect(
					3, 1, w - 6, h - 4, cornerRadius,
					backgroundColor, backgroundAlpha) 
				
				if (!dropShadow)
					dropShadow = new RectangularDropShadow();

				dropShadow.distance = 4;
				dropShadow.angle = 45;
				dropShadow.color = 0;
				dropShadow.alpha = 0.4;

				dropShadow.tlRadius = cornerRadius + 2;
				dropShadow.trRadius = cornerRadius + 2;
				dropShadow.blRadius = cornerRadius + 2;
				dropShadow.brRadius = cornerRadius + 2;

				dropShadow.drawShadow(graphics, 3, 0, w - 6, h - 4);
				//var bckLine:int	= UtilsColor.adjustBrightness(backgroundColor,-100);
				var bckLine:int	=  ColorUtil.adjustBrightness(backgroundColor,-100);
				graphics.lineStyle(0.5,bckLine,0.5);
				var crn:uint	= cornerRadius + 2;
				graphics.drawRoundRectComplex(3, 0, w - 6, h - 4,crn,crn,crn,crn);
				graphics.endFill();
				break;
			}

			case "errorTipRight":
			{
				// border 
				drawRoundRect(
					11, 0, w - 11, h - 2, 3,
					borderColor, backgroundAlpha); 

				// left pointer 
				g.beginFill(borderColor, backgroundAlpha);
				g.moveTo(11, 7);
				g.lineTo(0, 13);
				g.lineTo(11, 19);
				g.moveTo(11, 7);
				g.endFill();
				filters = [ new DropShadowFilter(2, 90, 0, 0.4) ];
				break;
			}

			case "errorTipAbove":
			{
				// border 
				drawRoundRect(
					0, 0, w, h - 13, 3,
					borderColor, backgroundAlpha); 

				// bottom pointer 
				g.beginFill(borderColor, backgroundAlpha);
				g.moveTo(9, h - 13);
				g.lineTo(15, h - 2);
				g.lineTo(21, h - 13);
				g.moveTo(9, h - 13);
				g.endFill();

				filters = [ new DropShadowFilter(2, 90, 0, 0.4) ];
				break;
			}

			case "errorTipBelow":
			{
				// border 
				drawRoundRect(
					0, 11, w, h - 13, 3,
					borderColor, backgroundAlpha); 

				// top pointer 
				g.beginFill(borderColor, backgroundAlpha);
				g.moveTo(9, 11);
				g.lineTo(15, 0);
				g.lineTo(21, 11);
				g.moveTo(10, 11);
				g.endFill();
				
				filters = [ new DropShadowFilter(2, 90, 0, 0.4) ];
				break;
			}
		}
	}
	}
}

