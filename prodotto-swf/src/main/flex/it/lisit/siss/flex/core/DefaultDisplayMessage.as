package it.lisit.siss.flex.core
{
	import flash.events.Event;
	import flash.geom.Point;
	import flash.utils.setTimeout;
	
	import it.lisit.siss.flex.component.PopMessage;
	import it.lisit.siss.flex.graphic.ImageDefinition;
	import it.lisit.siss.flex.sebwebsiss;
	
	import mx.core.Application;
	import mx.core.UIComponent;
	import mx.effects.Fade;
	import mx.effects.Move;
	import mx.effects.Parallel;
	import mx.effects.Resize;
	import mx.events.CloseEvent;
	import mx.events.EffectEvent;
	import mx.managers.PopUpManager;
	use namespace sebwebsiss;
	public class DefaultDisplayMessage implements IDisplayerMessage
	{
		private var application:Application;
		private var afterClose:Function;
		private var currentpop:PopMessage;
		private var showEffect:Parallel
		private var hideEffect:Parallel
		private var displayObject:UIComponent
		private var isOpen:Boolean;
		//
		private var startPoint:Point;
		private var endPoint:Point;
		public var maxWidthPanel:Number;
		public var maxHeightPanel:Number;
		public function DefaultDisplayMessage(displayObject:UIComponent)
		{
			isOpen = false;
			this.displayObject = displayObject; 
			displayObject.addEventListener(Event.ADDED_TO_STAGE,onAdded);
		}
		private function onRemove(e:Event):void
		{
			UIComponent(e.target).removeEventListener(Event.REMOVED_FROM_STAGE,onRemove);
			UIComponent(e.target).addEventListener(Event.ADDED_TO_STAGE,onAdded);
			showEffect.removeEventListener(EffectEvent.EFFECT_END,onEndEffShow);
			hideEffect.removeEventListener(EffectEvent.EFFECT_END,onEndEffHide);
			application = null;
		}
		private function onAdded(e:Event):void
		{
			UIComponent(e.target).removeEventListener(Event.ADDED_TO_STAGE,onAdded);
			UIComponent(e.target).addEventListener(Event.REMOVED_FROM_STAGE,onRemove);
			application 	= UIComponent(e.target).parentApplication as Application; 
			if(isNaN(maxWidthPanel))
				maxWidthPanel 	= application.width 	- 200;
			if(isNaN(maxHeightPanel))	
				maxHeightPanel 	= application.height 	- 200;
			startPoint	= new Point(displayObject.x,displayObject.y);
			startPoint	= displayObject.localToGlobal(startPoint);
			//
			var finalX:Number	= (application.width - maxWidthPanel)/2;	
			var finalY:Number	= (application.height - maxHeightPanel)/2;	
			endPoint	= new Point(finalX,finalY);
			//
			showEffect = getShowEffect();
			showEffect.addEventListener(EffectEvent.EFFECT_END,onEndEffShow);
			hideEffect = getHideEffect();
			hideEffect.addEventListener(EffectEvent.EFFECT_END,onEndEffHide)
		}
		private function getShowEffect():Parallel
		{
			var par:Parallel 	= new Parallel();
			par.duration	 	= 600;
			var fade:Fade		= new Fade();
			fade.alphaFrom		= 0;
			fade.alphaTo		= 1;
			par.addChild( fade ); 
			var move:Move		= new Move();
			move.xFrom			= startPoint.x;
			move.yFrom			= startPoint.y;
			move.xTo			= endPoint.x;
			move.yTo			= endPoint.y;
			par.addChild( move );
			var size:Resize		= new Resize();
			size.widthFrom		= 0;
			size.widthTo		= maxWidthPanel;
			size.heightFrom		= 0;
			size.heightTo		= maxHeightPanel;
			par.addChild( size );
			return par;
		}
		private function getHideEffect():Parallel
		{
			var par:Parallel 	= new Parallel();
			par.duration	 	= 500;
			var fade:Fade		= new Fade();
			fade.alphaFrom		= 1;
			fade.alphaTo		= 0;
			par.addChild( fade ); 
			var move:Move		= new Move();
			move.xFrom			= endPoint.x;
			move.yFrom			= endPoint.y;
			move.xTo			= startPoint.x;
			move.yTo			= startPoint.y;
			par.addChild( move );
			var size:Resize		= new Resize();
			size.widthFrom		= maxWidthPanel;
			size.widthTo		= 0;
			size.heightFrom		= maxHeightPanel;
			size.heightTo		= 0;
			par.addChild( size );
			return par;
		}
		public function afterCloseDisplayer(callbackFunction:Function):void
		{
			afterClose = callbackFunction;
		}
		private function getIcon(type:String):Class
		{
			switch(type)
			{
				case ConstStatusBar.ERROR:
					return ImageDefinition.ICONA_ERROR;
				case ConstStatusBar.INFO:
					return ImageDefinition.ICONA_INFO;
				case ConstStatusBar.WARNING:
					return ImageDefinition.ICONA_WARNING;
			}
			return null;
		}
		private function getValidType(type:String):Boolean
		{
			switch(type)
			{
				case ConstStatusBar.ERROR:
				case ConstStatusBar.INFO:
				case ConstStatusBar.WARNING:
					 return true
			}
			return false;
		}
		public function showDisplayer( message:MessageObject):void
		{
			var validType:Boolean	= getValidType(message.type);
			if(validType && application!=null && currentpop==null)
			{
				ManagerWaitPopUp.getInstance().hideImmediate();
				currentpop 			= new PopMessage();
				currentpop.title	= message.title;
				currentpop.message	= message.message;
				var ico:Class		= getIcon(message.type);
				if(ico!=null)
					 currentpop.titleIcon = ico;
				currentpop.showCloseButton	= true;
				currentpop.addEventListener(CloseEvent.CLOSE,onClosePop);
				//
				//currentpop.visible = false;
				isOpen = true;
				PopUpManager.addPopUp(currentpop,application,true);
				setTimeout(playShow,10);
			}else
			{
				afterClose();
			}
		}
		public function closeDisplayer():void
		{
			if(currentpop!=null && isOpen)
			{
				internalClose(currentpop);
			}
		} 
		private function playShow():void
		{
			//currentpop.visible = true;
			showEffect.play( [currentpop] );
		}
		private function onEndEffHide(e:EffectEvent):void
		{
			isOpen = false;
			PopUpManager.removePopUp( currentpop );
			currentpop = null
			afterClose();
		}
		private function onEndEffShow(e:EffectEvent):void
		{
			PopUpManager.centerPopUp( currentpop );
		}
		private function internalClose(pop:PopMessage):void
		{
			pop.removeEventListener(CloseEvent.CLOSE,onClosePop);
			hideEffect.play([currentpop]);	
		}
		private function onClosePop(e:Event):void
		{
			internalClose(e.target as PopMessage);
		}
	}
} 