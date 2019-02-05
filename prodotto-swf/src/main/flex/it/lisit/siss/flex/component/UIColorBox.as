package it.lisit.siss.flex.component
{
	import flash.display.Graphics;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	
	import it.lisit.siss.flex.effects.AnimateColor;
	
	import mx.core.UIComponent;
	import mx.events.EffectEvent;
	import mx.events.TweenEvent;

	internal class UIColorBox extends UIComponent
	{
		private var toC:uint;
		private var fromC:uint;
		private var duration:uint;
		private var animate:AnimateColor;
		private var _actColor:uint;
		public function set actColor(value:uint):void
		{
			_actColor = value;
			var ct:ColorTransform = this.transform.colorTransform;
			ct.color	= _actColor;
			this.transform.colorTransform = ct;
		}
		public function get actColor():uint
		{
			return _actColor;
		}
		public function UIColorBox(w:Number,h:Number,fromCol:uint,toCol:uint,duration:uint)
		{
			super();
			toC 		= toCol;
			fromC 		= fromCol;
			_actColor	= toC;
			this.duration	= duration;
			drawBox(w,h,toC);
		}
		private function removeAndStop():void
		{
			animate.stop();
			animate.removeEventListener(TweenEvent.TWEEN_END,onEnd);
		}
		private function onEnd(e:EffectEvent):void
		{
			e.stopPropagation();
			removeAndStop();
			dispatchEvent(new Event("stopEffect"));
		}
		public function play():void
		{
			if(animate!=null && animate.isPlaying)
			{
				removeAndStop();
			}
			animate = new AnimateColor();
			animate.addEventListener(EffectEvent.EFFECT_END,onEnd);
			animate.duration	= duration;
			animate.fromValue	= fromC;
			animate.toValue		= toC;
			animate.property	= "actColor";
			animate.isStyle		= false;
			animate.play([this]);
		}
		private function drawBox(w:Number,h:Number,col:uint):void
		{
			var g:Graphics = graphics;
			g.clear();
			g.beginFill(col,1);
			g.drawRect(0,0,w,h);
			g.endFill();	
		}
	}
}