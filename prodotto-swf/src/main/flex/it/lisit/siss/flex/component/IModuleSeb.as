package it.lisit.siss.flex.component
{
	import it.lisit.siss.agent.Agent;
	
	public interface IModuleSeb
	{
		function init(params:Array):void;
		function isReady():Boolean;		
		function receiveData(sender:String,data:Array):void;
		function sendData(target:String,data:Array):void;
		function broadcastData(data:Array):void;
	}
}