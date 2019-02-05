package it.lisit.siss.flex.core
{
	import mx.core.IFlexDisplayObject;
	
	public interface IWait extends IFlexDisplayObject
	{
		function get title():String;
		function set title(value:String):void;
	}
}