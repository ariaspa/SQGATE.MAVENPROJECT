package it.lisit.siss.flex.communication.fse.voChiudiPDT
{
	import it.lisit.siss.flex.communication.ValueObject;
	
	public class VoOutputChiudiPDT extends ValueObject
	{
		/**
		 * Indica se la registrazione della comunicazione è andata a buon fine o meno
		 * "OK" 
		 */		
		public var esitoChiudiPDT:String
		public function VoOutputChiudiPDT()
		{
			super();
		}
	}
}