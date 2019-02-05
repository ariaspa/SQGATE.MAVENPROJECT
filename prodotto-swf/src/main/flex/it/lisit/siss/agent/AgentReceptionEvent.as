package it.lisit.siss.agent
{
	import flash.events.Event;

	public class AgentReceptionEvent extends Event
	{
		public static const AGENT_RECEPTION_COMPLETE:String = "agentReceptionComplete";
		public static const AGENT_RECEPTION_DATA:String = "agentReceptionData";
		 
		private var list:Array;
		public function get data():Array{return list;}
		public var sender:String;
		public function AgentReceptionEvent(type:String, sender:String,listData:Array = null)
		{
			super(type);
			this.sender = sender;
			this.list 	= (listData == null) ? [] : listData;
		}
	}
}