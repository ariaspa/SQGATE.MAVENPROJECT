package it.lisit.siss.flex.communication.fse.voApriPDT
{
	import it.lisit.siss.flex.communication.ValueObject;
	/**
	 * 
	 * @author Marco Salonia
	 * 
	 */	
	public class VoOutputApriPDT extends ValueObject
	{
		/**
		 * Indica se la comunicazione della registrazione di un’apertura 
		 * di un PDT è andata a buon fine o meno
		 * 'OK' 
		 * Obbligatorietà -SI
		 */		
		public var esitoApriPDT:String;
		public function VoOutputApriPDT()
		{
			super();
		}
	}
}