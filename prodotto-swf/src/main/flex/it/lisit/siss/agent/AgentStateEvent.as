package it.lisit.siss.agent
{
	import flash.events.Event;

	public class AgentStateEvent extends Event
	{
		public static const SEND:String	= "send";
		public static const BUSY:String	= "busy";
		public static const FREE:String	= "free";
		
		
		public var connection:String;
		public function AgentStateEvent(type:String, connection:String)
		{
			super(type);
			this.connection = connection;
		}
	}
}