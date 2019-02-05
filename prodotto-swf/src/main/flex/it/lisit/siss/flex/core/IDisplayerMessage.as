package it.lisit.siss.flex.core
{
	public interface IDisplayerMessage
	{
		function afterCloseDisplayer(callbackFunction:Function):void;
		function showDisplayer( message:MessageObject ):void;
		function closeDisplayer():void;
	}
}