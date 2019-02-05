package it.lisit.siss.flex.communication.event
{
	import flash.events.Event;

	public class ServiceSEBFaultEvent extends Event
	{
		public static const SERVICE_SEB_FAULT:String = "serviceSebFault";
		
		private var fault:VoFault;
		public function ServiceSEBFaultEvent(fault:VoFault, type:String = null)
		{
			super( (type==null) ? SERVICE_SEB_FAULT : type);
			this.fault = fault;
		}
		public function getFault():VoFault
		{
			return this.fault;
		}
	}
}