package it.lisit.siss.flex.communication.fse.voConsultaFascicolo
{
	import it.lisit.siss.flex.communication.ClonableValueObject;
	/**
	 * 
	 * @author Marco Salonia
	 *         
     */	
	public class VoAccettazionePSoccorso extends ClonableValueObject
	{
		/**
		 * Codice Modalità di ingresso del paziente.
		 * Stringa numerica. Lunghezza 1 carattere. 
		 * Valori ammessi: vedi allegato 1 (Dati codificati –  tabella Modalita Ingresso).
		 * Obbligatorietà - NO
		 * quando assente assume il valore di null
		 */		
		public var idModalitaIngresso:String = null;
		/**
		 * Descrizione Modalità di ingresso del paziente.
		 * Stringa alfanumerica di lunghezza massima 50 caratteri. 
		 * Valori ammessi: vedi allegato 1 (Dati codificati –  tabella Modalita Ingresso).
		 * Obbligatorietà - NO
		 * quando assente assume il valore di null
		 */		
		public var descrizioneModalitaIngresso:String = null;
		/**
		 * Modalità del trauma.
		 * Stringa numerica. Lunghezza 1 carattere. 
		 * Valori ammessi: vedi allegato 1 (Dati codificati –  tabella Modalita Trauma)
		 * Obbligatorietà - NO
		 * quando assente assume il valore di null
		 */		
		public var idModalitaTrauma:String = null;
		/**
		 * Modalità del trauma.
		 * Stringa alfanumerica.
		 * Obbligatorietà - NO
		 * quando assente assume il valore di null
		 */		
		public var descrizioneModalitaTrauma:String = null;
		/**
		 * Disciplina di erogazione
		 * Stringa numerica. Lunghezza 2 caratteri.
		 * Valori ammessi: vedi allegato 1 (Dati codificati –  tabella  Disciplina_SISS).
		 * Obbligatorietà - NO
		 * quando assente assume il valore di null
		 */		
		public var idDisciplina:String = null;
		/**
		 * Disciplina di erogazione
		 * Stringa alfanumerica.
		 * Obbligatorietà - NO
		 * quando assente assume il valore di null
		 */		
		public var descrizioneDisciplina:String = null;
		/**
		 * Codice della classe di priorità del triage
		 * Stringa numerica.Lunghezza 2 caratteri. 
		 * Valori ammessi: vedi allegato 1 (Dati codificati – tabella Classe Priorita).
		 * Obbligatorietà - NO
		 * quando assente assume il valore di null
		 */		
		public var idClassePrioritaTriage:String = null;
		/**
		 * Descrizione della classe di priorità del triage
		 * Stringa alfanumerica.
		 * Obbligatorietà - NO
		 * quando assente assume il valore di null
		 */		
		public var descrizioneClassePrioritaTriage:String = null;
		public function VoAccettazionePSoccorso()
		{
			super();
		}
		
	}
}