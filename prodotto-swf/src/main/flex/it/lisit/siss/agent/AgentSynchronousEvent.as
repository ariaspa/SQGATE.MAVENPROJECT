package it.lisit.siss.agent
{
	public class AgentSynchronousEvent extends AgentStateEvent
	{
		public static const SYNCHRONOUS_EVENT:String	= "synchronousEvent";
		public var level:String;
		public var code:String;
		public function AgentSynchronousEvent(type:String, connection:String,level:String,code:String)
		{
			super(type, connection);
			this.level = level;
			this.code  = code;
		}
	}
}