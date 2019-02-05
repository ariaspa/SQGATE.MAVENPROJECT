package com.li.dc.sebc.turboFSE.view.skin
{
	import flash.utils.describeType;
	import flash.utils.getQualifiedClassName;
	
	import it.lispa.siss.sebc.flex.color.UtilsColor;
	
	import mx.core.EdgeMetrics;
	import mx.core.UIComponent;
	import mx.skins.Border; 
	import mx.skins.halo.HaloColors;
	import mx.utils.ColorUtil;
	
	public class TabSkin extends Border
	{
		//--------------------------------------------------------------------------
		//
		//  Class variables
		//
		//--------------------------------------------------------------------------
	
		/**
		 *  @private
		 */
		private static var cache:Object = {};
	
		//--------------------------------------------------------------------------
		//
		//  Class methods
		//
		//--------------------------------------------------------------------------
	
		/**
		 *  @private
		 *  Several colors used for drawing are calculated from the base colors
		 *  of the component (themeColor, borderColor and fillColors).
		 *  Since these calculations can be a bit expensive,
		 *  we calculate once per color set and cache the results.
		 */
		private static function calcDerivedStyles(themeColor:uint,
												  borderColor:uint,
												  falseFillColor0:uint,
												  falseFillColor1:uint,
												  fillColor0:uint,
												  fillColor1:uint):Object
		{
			var key:String = HaloColors.getCacheKey(themeColor, borderColor,
													falseFillColor0,
													falseFillColor1,
													fillColor0, fillColor1);
			
			if (!cache[key])
			{
				var o:Object = cache[key] = {};
	
				// Cross-component styles.
				HaloColors.addHaloColors(o, themeColor, fillColor0, fillColor1);
				
				// Tab-specific styles.
				o.borderColorDrk1 =
					ColorUtil.adjustBrightness2(borderColor, 10);
				o.falseFillColorBright1 =
					ColorUtil.adjustBrightness(falseFillColor0, 15);
				o.falseFillColorBright2 =
					ColorUtil.adjustBrightness(falseFillColor1, 15);
			}
			
			return cache[key];
		}
	
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
	
		/**
		 *  Constructor.
		 */
		public function TabSkin()
		{
			super();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Overridden properties
		//
		//--------------------------------------------------------------------------
	
		//----------------------------------
		//  borderMetrics
		//----------------------------------
	
		/**
		 *  @private
		 *  Storage for the borderMetrics property.
		 */
		private var _borderMetrics:EdgeMetrics = new EdgeMetrics(1, 1, 1, 1);
	
		/**
		 *  @private
		 */
		override public function get borderMetrics():EdgeMetrics
		{
			return _borderMetrics;
		}
	
		//----------------------------------
		//  measuredWidth
		//----------------------------------
		
		/**
		 *  @private
		 */
		override public function get measuredWidth():Number
		{
			return UIComponent.DEFAULT_MEASURED_MIN_WIDTH;
		}
		
		//----------------------------------
		//  measuredHeight
		//----------------------------------
	
		/**
		 *  @private
		 */
		override public function get measuredHeight():Number
		{
			return UIComponent.DEFAULT_MEASURED_MIN_HEIGHT;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Overridden methods
		//
		//--------------------------------------------------------------------------
		 private function isSelected(name:String):Boolean
		 {
		 	switch (name)
			{
				case "selectedDownSkin":
				case "selectedUpSkin":
				case "selectedDisabledSkin":
				case "selectedOverSkin":
				return true;
				/*case "downSkin":
				case "upSkin":
				case "disabledSkin":
				case "selectedDownSkin":
				case "selectedUpSkin":
				case "selectedDisabledSkin":*/
			}
			return false;
		 }
		 private function isDisabled(name:String):Boolean
		 {
		 	switch (name)
			{
				case "disabledSkin":
				case "selectedDisabledSkin":
				return true;
				/*case "downSkin":
				case "upSkin":
				case "disabledSkin":
				case "selectedDownSkin":
				case "selectedUpSkin":
				case "selectedDisabledSkin":*/
			}
			return false;
		 }
		 private function isOver(name:String):Boolean
		 {
		 	switch (name)
			{
				case "selectedOverSkin":
				case "overSkin":
				return true;
				/*case "downSkin":
				case "upSkin":
				case "disabledSkin":
				case "selectedDownSkin":
				case "selectedUpSkin":
				case "selectedDisabledSkin":*/
			}
			return false;
		 }
		
		/**
		 *  @private
		 */
		override protected function updateDisplayList(w:Number, h:Number):void
		{
			super.updateDisplayList(w, h);
			//------------------------------------------------------------------- 
			var borderColor:uint 			= getStyle("borderColor");
			var backgroundColor:Number 		= getStyle("backgroundColor");
			var backgroundAlpha:Number 		= getStyle("backgroundAlpha");	
			var cornerRadius:Number 		= getStyle("cornerRadius");	
			//
			var backgroundOnColor:int		= getStyle("backgroundOnColor");	
			var backgroundBorderColor:int	= getStyle("backgroundBorderColor");	
			var backgroundOffColor:int		= getStyle("backgroundOffColor");	
			var shadowColor:int				= getStyle("shadowColor");	
			var shadowOnColor:int			= getStyle("shadowOnColor");	
			//-------------------------------------------------------------------
			var cornerRadius2:Number = Math.max(cornerRadius - 2, 0);
			var cr:Object = { tl: cornerRadius, tr: cornerRadius, bl: 0, br: 0 };
			var cr2:Object = { tl: cornerRadius2, tr: cornerRadius2, bl: 0, br: 0 };
			//-------------------------------------------------------------------
			var bckColor:uint;
			var brdContColor:uint;
			var shdAlpha:Number = 0;
			switch (name)
			{
				case "downSkin":
				case "selectedOverSkin":
				case "selectedDownSkin":
				case "selectedUpSkin":
					bckColor 	 = backgroundColor;
					brdContColor = backgroundBorderColor;
					shdAlpha	 = 0;
					break;
				case "overSkin":
					bckColor 	 = backgroundColor;
					brdContColor = borderColor;
					shdAlpha	 = 0.4;
				break;
				case "upSkin":
					bckColor 	 =	backgroundOnColor;
					brdContColor = borderColor;
					shdAlpha	 = 0.4;
				break;
				case "selectedDisabledSkin":
				case "disabledSkin":
					bckColor 	 =	UtilsColor.adjustBrightness( backgroundOffColor, -50);
					brdContColor = borderColor;
					shdAlpha	 = 0;
					break;
			}
			var brdColor:uint = bckColor;
			var shdColor:uint = UtilsColor.adjustBrightness( bckColor , 150 );
			//
			graphics.clear();
			// linea di contorno, sta sotto a tutto
			//drawRoundRect( 1, 1, w - 2, h-1, cr2, 0x000000, 0.6);
			// bck
			 
			drawRoundRect( 2, 2, w - 4, h-2, cr2,bckColor, backgroundAlpha); 
			// border di 2px, aderente al bck	
			var colBlack:uint		= 0x000000;
			// 4 step di colori
			var colorsBorder:Array	= [brdColor,colBlack];
			var alphasBorder:Array	= [backgroundAlpha,backgroundAlpha ];	
						 
			drawRoundRect( 2, 2, w - 4, h-2, cr2,
				colorsBorder, 
				alphasBorder,
				rotatedGradientMatrix( 2, 2, w - 4, h-2,75),"linear",null,
				{x:4,y:4,w:w-8,h:h-4,r:cr2}); 
			// shd
			drawRoundRect( 2, 2, w - 4, h-2, null,
				[bckColor,shadowColor], 
				[0,shdAlpha],
				rotatedGradientMatrix( 2, 2, w - 4, h-2,90),"linear"); 
		}
	
		static private var tabnavs:Object = {};
	
		static private function isTabNavigator(parent:Object):Boolean
		{
			var s:String = getQualifiedClassName(parent);
			if (tabnavs[s] == 1)
				return true;
	
			if (tabnavs[s] == 0)
				return false;
	
			if (s == "mx.containers::TabNavigator")
			{
				tabnavs[s] == 1;
				return true;
			}
	
			var x:XML = describeType(parent);
			var xmllist:XMLList = x.extendsClass.(@type == "mx.containers::TabNavigator");
			if (xmllist.length() == 0)
			{
				tabnavs[s] = 0;
				return false;
			}
			
			tabnavs[s] = 1;
			return true;
		}
		
	}
}