package it.lisit.siss.flex.communication.fse.voRichiediUrlTestoReferto
{
	import it.lisit.siss.flex.communication.ValueObject;

	public class VoInputRichiediUrlTestoReferto extends ValueObject
	{
		public var codiceFiscale:String;
		public var uri:String;
		public var flagDocumentoFirmato:String;
		public var flagCDA2:String;

		public function VoInputRichiediUrlTestoReferto()
		{
			super();
		}
	}
}