package it.lisit.siss.flex.communication.fse.voCopiaDCEInPDT
{
	import it.lisit.siss.flex.communication.ValueObject;

	public class VoOutputCopiaDCEInPDT extends ValueObject
	{
		/**
		 * Indica se la registrazione della comunicazione è andata a buon fine o meno
		 * "OK" 
		 */		
		public var esitoCopiaDCEInFolder:String;
		public function VoOutputCopiaDCEInPDT()
		{
			super();
		}
		
	}
}