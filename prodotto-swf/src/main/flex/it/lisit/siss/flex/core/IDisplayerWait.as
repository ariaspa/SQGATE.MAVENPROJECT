package it.lisit.siss.flex.core
{
	import flash.display.DisplayObject;
	
	public interface IDisplayerWait
	{
		function hide():void;
		function show(info:Object=null):void;
		function update(info:Object=null):void;
		function hideImmediate():void;
		function callbackAfterHide(callback:Function):void;
		function callbackAfterShow(callback:Function):void;
	}
}