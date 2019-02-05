package it.lisit.siss.flex.utility.debug
{
	public interface IConsole
	{
		function get consoleFilter():Boolean;
		function set consoleFilter(value:Boolean):void;
		function write(message:Object,level:uint,levelDebug:uint=0):void;
	}
}