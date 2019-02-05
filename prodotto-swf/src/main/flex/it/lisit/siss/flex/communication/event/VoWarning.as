package it.lisit.siss.flex.communication.event
{
	import it.lisit.siss.flex.communication.ValueObject;

	public class VoWarning extends ValueObject
	{
		public var codiceWarning:String;
		public var descWarning:String;
		public var nomeCampo:String;
		public var valoreCampo:String;
		public var descWarningCampo:String;
		public var codiceWarningCampo:String;
		public var ROI:String;
		public function VoWarning()
		{
			super();
		}
	}
}