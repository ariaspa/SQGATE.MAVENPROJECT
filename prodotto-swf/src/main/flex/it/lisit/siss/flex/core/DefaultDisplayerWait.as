package it.lisit.siss.flex.core
{
	import it.lisit.siss.flex.component.PopUpAttesa;
	import it.lisit.siss.flex.sebwebsiss;
	
	import mx.core.Application;
	import mx.effects.Fade;
	import mx.effects.Move;
	import mx.effects.Parallel;
	import mx.events.EffectEvent;
	import mx.managers.PopUpManager;
	use namespace sebwebsiss;
	public class DefaultDisplayerWait implements IDisplayerWait
	{
		private var cbackAfterHide:Function;
		private var cbackAfterShow:Function;
		private var added:Boolean;
		private var playShow:Boolean;
		private var effect:Parallel;
		private var targetWait:IWait;
		public var parentWait:Application;
		private var maxWpan:Number;
		private var maxHpan:Number;
		public function DefaultDisplayerWait()
		{
			parentWait 	= Core._app;
			maxWpan		= 404;
			maxHpan		= 120;
			targetWait 	= getPanel();
			effect		= getEffect();
			added		= false;
			playShow	= false;
			effect.addEventListener(EffectEvent.EFFECT_END,onEndEffect);
		}
		
		private function getEffect():Parallel
		{
			
			var eff:Parallel 	= new Parallel();
			eff.duration		= 500;
			var move:Move 		= new Move();
			move.xFrom			= (parentWait.width - maxWpan)/2 ;
			move.xTo			= move.xFrom;
			move.yFrom			= -maxHpan;
			move.yTo			= (parentWait.height-maxHpan)/2;
			var fade:Fade 		= new Fade();
			fade.alphaFrom		= 0;
			fade.alphaTo		= 1;
			eff.addChild( move );
			eff.addChild( fade );
			return eff;
		}
		private function getPanel():IWait
		{
			/*var t:PopUpAttesa = new PopUpAttesa();
			t.width		= maxWpan;
			t.height	= maxHpan;*/
			var t:PopUpAttesa = new PopUpAttesa();
			//t.title			= "Attendere prego... elaborazione in corso";
			t.width			= maxWpan;
			t.height		= maxHpan;
			//
			return t as IWait; 
		}
		public function show(info:Object=null):void
		{
			if(!added)
			{
				PopUpManager.addPopUp(targetWait,parentWait,true);
				PopUpManager.centerPopUp( targetWait );
				added  = true;
				if(cbackAfterShow!=null)
					cbackAfterShow();
			}
			/*if(effect.isPlaying)
			{
			 	if(!playShow)
			 	{
			 		playShow = true;
			 		effect.stop();
			 		cbackAfterHide();
			 		effect.reverse();
			 	}
			}else
			{
				if(!added)
				{
					added  = true;
					PopUpManager.addPopUp(targetWait,parentWait,true);
					effect.play( [targetWait] );
				}
			}*/ 
		}
		public function hide():void
		{
			if(added)
			{
				PopUpManager.removePopUp( targetWait );	
				added  = false;
				if(cbackAfterHide!=null)
					cbackAfterHide();
			}
			/*if(effect.isPlaying)
			{
				if(playShow)
			 	{
			 		playShow = false;
			 		effect.stop();
			 		cbackAfterShow();
			 		effect.reverse();
			 	}
			}else
			{
				playShow = false;
				effect.reverse();
			}*/ 
		} 
		private function onEndEffect(e:EffectEvent):void
		{
			if(playShow)
			{
				if(cbackAfterShow!=null)
					cbackAfterShow();
			}else
			{
				if(targetWait!=null)
				{
					added  = false;
					PopUpManager.removePopUp( targetWait );					
				}
				if(cbackAfterHide!=null)
					cbackAfterHide();
			}
		}
		public function update(info:Object=null):void
		{
			if(info!=null && info is String)
			{
				targetWait.title = info as String;
			}
		}
		public function hideImmediate():void
		{	
			if(added)
			{
				PopUpManager.removePopUp( targetWait );	
				added  = false;
				if(cbackAfterHide!=null)
					cbackAfterHide();
			} 
			/*if(effect.isPlaying)
			{
				effect.stop();
			}
			//var oldPlay:Boolean	= playShow;
			playShow = false;
			if(targetWait!=null && added)
			{
				PopUpManager.removePopUp( targetWait );					
			} 
			added  = false;*/
		}
		public function callbackAfterShow(callback:Function):void
		{
			this.cbackAfterShow = callback;
		}
		public function callbackAfterHide(callback:Function):void
		{
			this.cbackAfterHide = callback; 
		}
	}
}