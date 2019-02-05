package it.lisit.siss.flex.communication.fse.voConsultaFascicolo
{
	import it.lisit.siss.flex.communication.ClonableValueObject;
	/**
	 * 
	 * @author Marco Salonia
	 * 
	 */	
	public class VoMedicoRichiedente extends ClonableValueObject
	{
		/**
		 * Cognome del medico richiedente
		 * Obbligatorietà - NO
		 * Quando non presente il valore è a null; 
		 */		
		public var cognome:String = null;
		/**
		 * Nome del medico richiedente
		 * Obbligatorietà - NO
		 * Quando non presente il valore è a null; 
		 */		
		public var nome:String = null;
		/**
		 * Codice fiscale del medico richiedente
		 * Obbligatorietà - NO
		 * Quando non presente il valore è a null; 
		 */		
		public var codiceFiscale:String = null;
		public function VoMedicoRichiedente()
		{
			super();
		}
	}
}