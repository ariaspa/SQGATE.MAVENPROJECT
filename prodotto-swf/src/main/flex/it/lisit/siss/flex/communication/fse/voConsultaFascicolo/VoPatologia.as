package it.lisit.siss.flex.communication.fse.voConsultaFascicolo
{
	import it.lisit.siss.flex.communication.ClonableValueObject;
	/**
	 * 
	 * @author Marco Salonia
	 * 
	 */	
	public class VoPatologia extends ClonableValueObject
	{
		/**
		 * Codice identificativo della patologia a cui è associata la vaccinazione. 
		 * Stringa alfanumerica di lunghezza massima 5 caratteri.
		 * Valori ammessi: vedi allegato 1 (Dati codificati –  tabella Codici Patologie Vaccinazioni).
		 * Obbligatorietà - SI
		 */		
		public var idPatologia:String;
		/**
		 * Descrizione della patologia associato al codice 
		 * Stringa alfanumerica.
		 * Obbligatorietà - SI
		 */		
		public var descrizionePatologia:String;
		/**
		 * Struttura contenente l’elenco delle patologie relative alle vaccinazioni
		 * Obbligatorietà - SI
		 */		
		public var elencoVaccinazioni:VoElencoVaccinazioni;
		public function VoPatologia()
		{
			super();
		}
		
	}
}