package it.lisit.siss.flex.gui.assistito
{
	import flash.events.Event;
	
	import it.lisit.siss.flex.communication.event.VoListaWarning;

	public class WarnigEvent extends Event
	{
		public var warning:VoListaWarning;
		public function WarnigEvent(type:String, warning:VoListaWarning)
		{
			super(type);
			this.warning = warning;
		}
	}
}