package com.li.dc.sebc.turboFSE.view.component
{
	import it.lispa.siss.sebc.flex.help.IHelp;
	import com.li.dc.sebc.turboFSE.view.skin.SkinTitleBarView;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.controls.Button;
	import mx.controls.Label;
	import mx.core.Container;
	import mx.core.mx_internal;
	import mx.events.PropertyChangeEvent;
	use namespace mx_internal;
	
	[Style(name="checkUpSkin", type="Class", inherit="no")]
	[Style(name="checkSelectUpSkin", type="Class", inherit="no")]
	[Style(name="checkOverSkin", type="Class", inherit="no")]
	[Style(name="checkSelectOverSkin", type="Class", inherit="no")]
	[Style(name="checkDownSkin", type="Class", inherit="no")]
	[Style(name="checkSelectDownSkin", type="Class", inherit="no")]
	[Style(name="backgroundColor", type="Class", inherit="no")]
	[Event(name="changeSelect", type="flash.events.Event")]
	
	public class TitleBarView extends Container implements IHelp
	{
		private var lab:Label;
		private var btn:Button;
		public var selectButton:Boolean;
		public var nameId:String = "";
		[Bindable]
	    public var colorBackGround: int;
	    
	    
	    public function getIDHelp(): String{return nameId;}
	    public function feedback(play:Boolean):void{}
		public override function set label(value:String):void
		{
			super.label = value;
			lab.text = value;
			this.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE,onChangeproperty);
		}
		//
		public function TitleBarView()
		{
			super();
			selectButton = false;
			this.setStyle("borderSkin",SkinTitleBarView);
			lab = new Label();
			lab.setStyle("selectable",false);
			this.addChild( lab );
			btn = new Button();
			btn.toggle = true;
			btn.measuredMinWidth  = btn.measuredMinHeight = 22;
			btn.width = 22;
			btn.height = 22;
			btn.addEventListener(MouseEvent.CLICK,onClickBTN);
			this.addChild( btn );
			//
			verticalScrollPolicy = "off";
			horizontalScrollPolicy="off";
		}
		private function onChangeproperty(e:PropertyChangeEvent):void
		{
			this.setStyle("backgroundColor",e.newValue);	
		}
		public override function initialize():void
		 {
		 	super.initialize();
		 	
		 	var skin:* ;
		 	if((skin =  this.getStyle("checkUpSkin")) != null)
		 	{
		 		btn.setStyle("upSkin",skin);
		 	}
		 	if((skin =  this.getStyle("checkSelectUpSkin")) != null)
		 	{
		 		btn.setStyle("selectedUpSkin", skin);
		 	}
		 	if((skin =  this.getStyle("checkOverSkin")) != null)
		 	{
		 		btn.setStyle("overSkin", skin);
		 	}
		 	 if((skin =  this.getStyle("checkSelectOverSkin")) != null)
		 	{
		 		btn.setStyle("selectedOverSkin", skin);
		 	}
		 	if((skin =  this.getStyle("checkDownSkin")) != null)
		 	{
		 		btn.setStyle("downSkin", skin);
		 	}
		 	if((skin =  this.getStyle("checkSelectDownSkin")) != null)
		 	{
		 		btn.setStyle("selectedDownSkin", skin);
		 	}
		 }
		private function onClickBTN(e:MouseEvent):void
		{
			selectButton = btn.selected;
			dispatchEvent(new Event("changeSelect"))
		}
	 
		override public function styleChanged(styleProp:String):void 
		{
            super.styleChanged(styleProp);
            var propSkin:String;
			switch(styleProp)
			{
				case "checkUpSkin":
					propSkin = "upSkin";
					break;
				case "checkSelectUpSkin":
					propSkin = "selectedUpSkin";
					break;
				case "checkOverSkin":
					propSkin = "overSkin";
					break;
				case "checkSelectOverSkin":
					propSkin = "selectedOverSkin";
					break;
				case "checkDownSkin":
					propSkin = "downSkin";
					break;
				case "checkSelectDownSkin":
					propSkin = "selectedDownSkin";
					break;
			}
			//------------------------------------------------
			if(propSkin!=null)
			{
				var style:* = this.getStyle(styleProp);
				btn.setStyle(propSkin,style);
				invalidateDisplayList();
                return;
			}
			//------------------------------------------------
        }
		protected override function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			
			var padR:Number = this.getStyle("paddingRight") as Number;
			var padL:Number = this.getStyle("paddingLeft") as Number;
			var corner:Number = this.getStyle("cornerRadius") as Number;
			
			var max:Number = Math.max(corner,padR);
			
			btn.x = unscaledWidth - max - btn.width;
			btn.y = (unscaledHeight-btn.height)/2;
			
			lab.width = unscaledWidth - padL - max - btn.width;
			lab.height = unscaledHeight;
			var htext:Number = this.measureText(lab.text).height
			lab.y = (unscaledHeight - htext)/2;
			lab.x = padL; 
					
		}
	}
}