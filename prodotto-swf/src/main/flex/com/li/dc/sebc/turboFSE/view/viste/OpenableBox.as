package com.li.dc.sebc.turboFSE.view.viste
{
	import mx.effects.Resize;
	import mx.events.TweenEvent;

	public class OpenableBox extends Vista
	{
		private var resize:Resize;
		private var headHeight:Number;
		public var display:Vista
		public function OpenableBox()
		{
			super();	
			headHeight = 0;		
		}
		private function getResize():Resize
		{
			if(resize==null)
			{
				resize 			= new Resize();
				resize.duration = 200;
			}
			return resize;
		}
		/* override public function validateDisplayList():void
		{
			super.validateDisplayList();
			
		} */
		private function startResize(select:Boolean):void
		{
			var esegui:Boolean	= true;
			if(headHeight==0 && display.height>0)
			{
				headHeight = display.height;
			}else if(select && headHeight==0)
			{
				esegui = false;
				this.callLater(startResize,[true]);
			} 
			if(esegui)
			{
				if(getResize().isPlaying)
				{
					getResize().stop();
				}
				getResize().heightFrom 	= select ? 0 : headHeight;
				getResize().heightTo   	= select ? headHeight : 0;
				getResize().play( [this] );
			}
		}
		public function open():void
		{
			if(display!=null && !this.contains(display))
			{
				this.addChildAt(display,0);
			}
			this.callLater(startResize,[true]);
		}
		public function close():void
		{
			getResize().addEventListener(TweenEvent.TWEEN_END,onEnd);
			startResize(false);
		}
		private function onEnd(e:TweenEvent):void
		{
			getResize().removeEventListener(TweenEvent.TWEEN_END,onEnd);
			if(display!=null && this.contains(display))
			{
				this.removeChild(display);
			}
		}
	}
}