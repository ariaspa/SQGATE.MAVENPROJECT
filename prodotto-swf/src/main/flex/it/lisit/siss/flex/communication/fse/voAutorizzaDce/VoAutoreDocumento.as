package it.lisit.siss.flex.communication.fse.voAutorizzaDce
{
	import it.lisit.siss.flex.communication.ValueObject;

	public class VoAutoreDocumento extends ValueObject
	{
		public var  codiceFiscale:String;
		public var  nome:String;
		public var  cognome:String;
		public function VoAutoreDocumento()
		{
			super();
		}
		
	}
}