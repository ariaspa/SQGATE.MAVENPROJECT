package com.li.dc.sebc.turboFSE.view.viste
{
	import com.li.dc.sebc.turboFSE.events.TurboEvent;
	import com.li.dc.sebc.turboFSE.util.CreateComp;
	import com.li.dc.sebc.turboFSE.view.component.ButtonFolder;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import it.lispa.siss.sebc.flex.debug.Debug;
	
	import mx.containers.VBox;
	import mx.controls.Button;
	import mx.effects.Resize;
	import mx.events.FlexEvent;
	import mx.events.TweenEvent;
	 
	[Event(name="completeEvent", type="com.li.dc.sebc.turboFSE.events.TurboEvent")] 
	public class OpenableVista extends Vista
	{
		private var headClass:Class; 
		private var bodyClass:Class; 

		public var headVista:Vista; 
		public var bodyVista:Vista; 
		
		private var btnHead:Button;
		private var headHeight:Number = -1;
		private var heightVista:Number = 0;
		private var resize:Resize;
		public var vbox:VBox;
		
		public function OpenableVista(hClass:Class=null,bClass:Class=null)
		{
			super();
			headClass 	= hClass;
			bodyClass 	= bClass;
		}
		override protected function createChildren():void 
	 	{
	 		super.createChildren();
	 		resize	= new Resize();
	 		createVBox();
	 		createHeader();
   		}	
		
		override protected function updateData():void
	 	{
	 		//{dataHeader:getDataHeader(obj),dataBody:getDataBody(obj),label:getDataLabel(obj),tooltip:getDataTooltip(obj)};
	 		Debug.logInfo(" OpenableVista.updateData ");
	 	}
	 	private function createVBox():void
		{
			if(vbox==null)
			{
				vbox = CreateComp.getBoxWithScroll(); 
				//vbox.setStyle("verticalScrollPolic","auto" );
				vbox.percentWidth	= 100;
				this.addChild( vbox );
			}
		} 
		protected function createHeader():void
	 	{
	 		// 
	 		if(headVista == null && dataVista.dataHeader!=null && headClass!=null)
	 		{
	 			var dataHeader:Object 		= dataVista.dataHeader;
	 			var head:* 					= new headClass();
	 			if(head is Vista)
	 			{
		 			headVista 				= head as Vista;
	 				btnHead				 	= CreateComp.getButtonRect(dataVista.label, dataVista.tooltip);
	 				btnHead.addEventListener(MouseEvent.CLICK,onClickBTN);
	 				headVista.dataVista 	= dataHeader;
	 				headVista.addEventListener(FlexEvent.UPDATE_COMPLETE,onListenerCreation);
	 			 	vbox.addChild(  btnHead );
	 				vbox.addChild(  headVista );
	 			}else
	 			{
	 				completeCreation();
	 			}
	 		}else
	 		{
	 			completeCreation();
	 		}
	 	}
	 	private function onListenerCreation(e:Event):void
	 	{
	 		headVista.removeEventListener(FlexEvent.UPDATE_COMPLETE,onListenerCreation);
	 		Debug.logDebug("OpenableVista.onListenerCreation :type: "+e.type);
	 		this.callLater( checkHeight );
	 		//checkHeight();
	 	}
	 	private function checkHeight():void
		{
			if(headVista!=null && headHeight<0)
	 		{  
	 			Debug.logDebug("OpenableVista addheader height :::: "+headVista.height);
	 			headHeight			= headVista.height + 10;
				headVista.height 	= 0;
				completeCreation();
	 		}
		}
		private function completeCreation():void
		{
			createBody();
			this.dispatchEvent(new TurboEvent(TurboEvent.COMPLETE_EVENT));
		}
		protected function createBody():void
	 	{
	 		if(bodyVista == null && dataVista!=null && dataVista.dataBody!=null && bodyClass!=null)
	 		{
	 			var body:* = new bodyClass();
	 			if(body is Vista)
	 			{
	 				bodyVista =  body as Vista;
	 				( body as Vista ).dataVista = dataVista.dataBody;
	 				vbox.addChild( bodyVista );
	 			}
	 		}
	 	}
	 	private function onClickBTN(e:MouseEvent):void 
	 	{
	 		var select:Boolean = (e.target as ButtonFolder).selected;
	 		openHead(select);
	 	}  
	 	private function openHead(select:Boolean):void
	 	{
	 		if(headVista!=null)
	 		{
		 		if(resize.isPlaying)
				{
					resize.stop();
				}
				resize.heightFrom 	= select ? 0 : headHeight;
				resize.heightTo   	= select ? headHeight: 0;
				if(heightVista==0)
				{
					heightVista 		= this.height;
				}
				Debug.logDebug("OpenableVista.openHead resize.heightFrom :::: "+resize.heightFrom+", resize.heightTo :: "+resize.heightTo);
				resize.duration 	= 200;
				 
				resize.play( [headVista] );
	 		}
	 	}
	}
}











