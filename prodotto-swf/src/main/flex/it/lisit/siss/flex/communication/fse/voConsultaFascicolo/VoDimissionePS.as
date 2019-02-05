package it.lisit.siss.flex.communication.fse.voConsultaFascicolo
{
	import it.lisit.siss.flex.communication.ClonableValueObject;
	/**
	 * 
	 * @author Marco Salonia
	 * 
	 */	
	public class VoDimissionePS extends ClonableValueObject
	{
		/**
		 *Data ed ora di dimissione da pronto soccorso. 
		 * Data valida formalmente
		 * Lunghezza di 14 caratteri
		 * Formato data ammesso  'YYYYMMDDHH24MMSS'
		 * Obbligatorietà - SI
		 */		
		public var dataOraUscita:String;
		/**
		 * Modalità di Dimissione da Pronto Soccorso.
		 * Stringa numerica di lunghezza 1 carattere.
		 * Valori ammessi: vedi allegato 1 (Dati codificati – tabella Modalita Dimissione).
		 * Obbligatorietà - NO
		 * quando assente assume il valore di null
		 */		
		public var idModalitaDimissione:String = null;
		/**
		 * Modalità di Dimissione da Pronto Soccorso.
		 * Si tratta di una stringa alfanumerica.
		 * Obbligatorietà - NO
		 * quando assente assume il valore di null
		 */		
		public var descrizioneModalitaDimissione:String = null;
		/**
		 * Codifica in ICD9-CM della diagnosi di dimissione da PS.
		 * Si tratta di una stringa alfanumerica di lunghezza 5. Corrisponde alla codifica ICD9-CM della diagnosi.
		 * Obbligatorietà - NO
		 * quando assente assume il valore di null
		 */		
		public var codiceDiagnosiDimissione:String = null;
		/**
		 * Descrizione della diagnosi di dimissione da PS.
		 * Si tratta di una stringa alfanumerica.
		 * Obbligatorietà - NO
		 * quando assente assume il valore di null
		 */		
		public var descrizioneDiagnosiDimissione:String = null;
		/**
		 * Descrizione testuale relativa alla prognosi specificata.
		 * Si tratta di una stringa alfanumerica di lunghezza massima 1000 caratteri.
		 * Obbligatorietà - NO
		 * quando assente assume il valore di null
		 */		
		public var prognosi:String = null;
		/**
		 * Note associate alla dimissione da PS.
		 * Si tratta di una stringa alfanumerica di lunghezza massima 1000 caratteri.
		 * Obbligatorietà - NO
		 * quando assente assume il valore di null
		 */		
		public var noteDimissione:String = null;
		/**
		 * Struttura relativa all’elenco delle prestazioni associate all’accesso di pronto soccorso.
		 */		
		public var elencoPrestazioni:VoElencoPrestazioni = null;
		
		public function VoDimissionePS()
		{
			super();
		}
		
	}
}