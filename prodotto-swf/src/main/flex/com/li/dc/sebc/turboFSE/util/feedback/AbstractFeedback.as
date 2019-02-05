package com.li.dc.sebc.turboFSE.util.feedback
{
	import flash.display.Graphics;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import it.lispa.siss.sebc.flex.color.HTMLTabColor;
	
	import mx.core.IUIComponent;
	import mx.core.UIComponent;
	import mx.effects.Blur;
	import mx.effects.Effect;
	import mx.events.EffectEvent;
	 
	public class AbstractFeedback
	{
		protected var layer:UIComponent;
		protected var target:IUIComponent;
		protected var sprite:UIComponent;
		protected var rectangle:Rectangle;
		protected var effect:Effect;
		private const ADDW:Number = 10;
		private const ADDH:Number = 10;
		public function AbstractFeedback(target:IUIComponent,layer:UIComponent)
		{
			this.target = target;
			this.layer 	= layer;
		}
		public function show():void 
		{
			sprite 		= new UIComponent();
			rectangle 	= target.getRect( target.stage );
			if(rectangle.width>0 && rectangle.height>0)
			{	
				if(layer.stage!=null)
				{
					draw(rectangle.width ,rectangle.height);
					position();
					effect = getEffec();
					effect.addEventListener(EffectEvent.EFFECT_END,onEnd);
					layer.addChild( sprite );
					effect.target	= sprite;
					effect.play();
				}
			}
		} 
		 
		private function position( ):void
		{
			var p:Point	= new Point(target.x,target.y);
			p = target.parent.localToGlobal( p )
			//p = layer.globalToLocal( p );
			sprite.x = p.x ;
			sprite.y = p.y ;
		}
		private function draw(w:Number,h:Number):void
		{
			var g:Graphics 	= sprite.graphics;
			g.clear();
			g.lineStyle(2,getColor(),getAlpha());
			g.drawRect(0,0, w  ,h  );
			g.endFill();
		}
		protected function getEffec( ):Effect
		{
			var blur:Blur			= new Blur();
			blur.blurXFrom			= 20 ;
			blur.blurYFrom			= 20 ;
			blur.blurXTo			= 0;
			blur.blurYTo			= 0;
			blur.duration			= 700;
			return blur;
		}
		
		private function onEnd(e:EffectEvent):void
		{
			Effect(e.target).removeEventListener(EffectEvent.EFFECT_END,onEnd);
		}
		protected function getAlpha():Number{return 0.7;}
		protected function getColor():int{return HTMLTabColor.CYAN;}
		/////////////////////////////////
		protected function removeChild():void
		{
			if(layer.contains( sprite ))
			{
				layer.removeChild( sprite );
				sprite  = null;
			}
		}
		public function hide():void 
		{
			if(effect.isPlaying)
			{
				effect.stop();
				effect.removeEventListener(EffectEvent.EFFECT_END,onEnd);
			}
			removeChild();
		} 
	}
}