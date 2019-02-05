package com.li.dc.sebc.turboFSE.view.viste
{
	import com.li.dc.sebc.turboFSE.events.TurboEvent;
	import com.li.dc.sebc.turboFSE.view.component.BarraAgregazione;
	
	import mx.effects.Resize;
	import mx.events.TweenEvent;
	[Event(name="update", type="com.li.dc.sebc.turboFSE.events.TurboEvent")] 
	[Event(name="completeEvent", type="com.li.dc.sebc.turboFSE.events.TurboEvent")] 
	public class AgreDisciplina extends Vista
	{
		private var listButtons:Array;
		private var heightVista:Number;
		private var headHeight:Number;
		private var resize:Resize;
		 
		public function AgreDisciplina()
		{
			super();
			heightVista		= 0;
			headHeight		= 0;
			this.visible 	= false;
			listButtons 	= new Array();
			resize 			= new Resize();
			resize.addEventListener(TweenEvent.TWEEN_UPDATE,onUpdate);
			resize.addEventListener(TweenEvent.TWEEN_END,onEnd);
			createVBox();
		}
		public function getListButton():Array /*BarraAgregazione*/
		{
			return listButtons;
		}
		
		private function createVBox():void
		{
			this.setStyle("horizontalAlign","left" );
			this.setStyle("verticalAlign","top" );
			this.setStyle("verticalGap",4 );
			this.setStyle("borderStyle","none" );
			this.setStyle("backgroundColor",0xADF0A6);
			this.setStyle("backgroundAlpha",0);
			this.percentHeight	= 100;
			this.percentWidth	= 100;	 
		} 
		public function setDataVista( dt:Array ):void
		{
		 	createAgregazione( dt );
		 	this.callLater( checkHeight );
		}
		private function createAgregazione(listAgregazioni:Array):void
		{
			if(listAgregazioni!=null && listAgregazioni.length>0)
			{
				for(var i:uint = 0;i<listAgregazioni.length;i++)
				{ 
					var barraAgregazione:BarraAgregazione	= new BarraAgregazione();
					barraAgregazione.dataAgregazione		= listAgregazioni[i];
					listButtons.push( barraAgregazione );
					this.addChild( barraAgregazione );
				}
			}
		}
		
		private function checkHeight():void
		{
			if(this.listButtons.length==0)
			{
				this.dispatchEvent(new TurboEvent(TurboEvent.COMPLETE_EVENT));
			}else if(this.listButtons.length>0 && this.height>0)
			{
				heightVista		= this.height;
	 			headHeight		= this.height + 10;
				this.height 	= 0;
				this.visible	= true;
				this.dispatchEvent(new TurboEvent(TurboEvent.COMPLETE_EVENT));
			}else
			{
				this.callLater( checkHeight );
			}
		}
		  
		private function onEnd(e:TweenEvent):void
		{
			this.dispatchEvent(new TurboEvent(TurboEvent.UPDATE));
		}
		private function onUpdate(e:TweenEvent):void
		{
			this.dispatchEvent(new TurboEvent(TurboEvent.UPDATE));
		} 
		public function open(select:Boolean):void
	 	{
	 		if(resize.isPlaying)
			{
				resize.stop();
			}
			resize.heightFrom 	= select ? 0 : headHeight;
			resize.heightTo   	= select ? headHeight: 0;
			resize.duration 	= 200;
			resize.play( [this] );
	 	}
	}
}