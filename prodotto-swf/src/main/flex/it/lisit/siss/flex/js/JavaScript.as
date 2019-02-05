package it.lisit.siss.flex.js
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.external.ExternalInterface;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.utils.setTimeout;
	
	import mx.core.Application;
	import mx.core.IMXMLObject;
	import mx.events.PropertyChangeEvent;
	
	[Event(name="writeScript", type="flash.events.Event")]
	public class JavaScript extends EventDispatcher implements IMXMLObject
	{
		[Bindable]
		public var script:*;
		[Inspectable(defaultValue=false)]
		public var evalMode:Boolean = false;
		private var _document:Object;
		private var _initialized:Boolean;
		private var _source:String;
		private var fr:int;
		public function get document():Object{return _document;}
		public function get jsSource():String
		{
			return source;
		}
		private function get source():String{return _source;}
		private function set source(value:String):void
		{
			 if(value!=null)
			 {
			 	_source += value;
			 	//(/(\/\*([^*]|[\r\n]|(\*+([^*\/]|[\r\n])))*\*+\/)|(((?<!:)\/\/.*)/);
				var commentPattern:RegExp = /(\/\*([^*]|[\r\n]|(\*+([^*\/]|[\r\n])))*\*+\/)|((^|[^:\/])(\/\/.*))/g;
				value = value.replace (commentPattern, "");
				if(!evalMode)
				{
					var finalValue:String	= "document.insertScript = function (){ "+ value +"}";
					if(ExternalInterface.available)
					{
						ExternalInterface.call (finalValue);
					}	
				}else
				{
					var u:URLRequest = new URLRequest ("javascript:eval('" + value + "');");
					navigateToURL(u,"_self");
				}
				setTimeout(dispatchComplete,fr);
			 }
		}  
		private function dispatchComplete():void
		{
			this.dispatchEvent(new Event("writeScript"));
		}
		//////////////////////////////////////////////////////////////////
		public function JavaScript( )
		{
			super(this);
			fr = 30;
			if(Application.application!=null)
			{
				DisplayObject(Application.application).addEventListener(Event.ADDED_TO_STAGE,onStage);
			}
			_source 		= "";
			_initialized 	= false;
			this.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE,onPropertyChange);
		}
		private function onStage(e:Event):void
		{
			fr = 1000/DisplayObject(Application.application).stage.frameRate;
		}
		private function onPropertyChange(e:PropertyChangeEvent):void
		{
			if(e.property =="script")
			{
				if(script is String)
					source = script;
			}
		}
		public function initialized(document:Object, id:String):void
		{
			_document		= document;
			_initialized 	= true;
		}
	}
}