package it.lisit.siss.flex.communication.fse.voConsultaFascicolo
{
	import it.lisit.siss.flex.communication.ClonableValueObject;
	/**
	 * Struttura contenente la patologia relative alle vaccinazioni
	 * @author Marco Salonia
	 * 
	 */	
	public class VoVaccinazione extends ClonableValueObject
	{
		/**
		 * Data di erogazione della vaccinazione
		 * Formato YYYYMMDD
		 * Obbligatorietà - SI
		 */		
		public var dataErogazione:String;
		/**
		 * Codice identificativo della vaccinazione. 
		 * Stringa alfanumerica di lunghezza massima 16 caratteri.
		 * Obbligatorietà - SI
		 */		
		public var idVaccinazione:String;
		/**
		 * Descrizione associata al codice della vaccinazione
		 * Stringa alfanumerica.
		 * Obbligatorietà - SI
		 */		
		public var descrizioneVaccinazione:String;
		 
		public function VoVaccinazione()
		{
			super();
		}
		
	}
}