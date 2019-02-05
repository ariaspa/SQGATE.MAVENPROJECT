package it.lisit.siss.flex.communication.event
{
	import it.lisit.siss.flex.communication.ValueObject;

	public class VoResponse extends ValueObject
	{
		public var isEsitoNegativo:Boolean;
		public var esitoNegativo:VoEsitoNegativo;
		public var warnings:VoListaWarning;
		public var esitoPositivo:ValueObject;
		public function VoResponse()
		{
			super();
		}
	}
}