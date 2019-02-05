package it.lisit.siss.flex.communication.fse.voConsultaFascicolo
{
	import it.lisit.siss.flex.communication.ClonableValueObject;
	/**
	 * 
	 * @author Marco Salonia
	 * 
	 */	
	public class VoDimissione extends ClonableValueObject
	{
		/**
		 * Data ed ora in cui il cittadino viene dimesso dal reparto presso cui era ricoverato.
		 * Data valida formalmente
		 * Lunghezza minima 12 e  massima 14 caratteri
		 * Formato data ammesso  'YYYYMMDDHH24MM[SS]'
		 * Obbligatorietà - SI
		 */		
		public var dataOraDimissione:String;
		/**
		 * Indica il reparto in cui il paziente è fisicamente ricoverato al momento della dimissione
		 * Stringa alfanumerica di lunghezza massima 6 caratteri.
		 * Obbligatorietà - SI
		 */		
		public var idRepartoDimissione:String;
		/**
		 * Descrizione del reparto di dimissione
		 * Stringa alfanumerica.
		 * Obbligatorietà - SI
		 */		
		public var descrizioneRepartoDimissione:String;
		/**
		 * Indica la modalità di dimissione
		 * Stringa alfanumerica di lunghezza 1 carattere.
		 * Valori ammessi: vedi allegato 1 (Dati codificati – tabella Modalita Dimissione).
		 * Obbligatorietà - SI
		 */		
		public var idModalitaDimissione:String;
		/**
		 * Indica la descrizione della modalità di dimissione
		 * Stringa alfanumerica.
		 * Obbligatorietà - SI
		 */		
		public var descrizioneModalitaDimissione:String;
		/**
		 * Codifica in ICD9-CM della diagnosi di dimissione principale. 
		 * Si tratta di una stringa alfanumerica di lunghezza 5. Corrisponde alla codifica ICD9-CM della diagnosi.
		 * Obbligatorietà - SI
		 */		
		public var codiceDiagnosiPrincipaleDimissione:String;
		/**
		 * Descrizione della diagnosi di dimissione principale. 
		 * Si tratta di una stringa alfanumerica.
		 * Obbligatorietà - SI
		 */		
		public var descrizioneDiagnosiPrincipaleDimissione:String;
		/**
		 * Indica il peso alla nascita del neonato
		 * Stringa numerica relativa al peso in grammi
		 * Obbligatorietà - NO
		 * Quando assente è valorizzato a null;
		 */		
		public var pesoNascita:String = null;
		/**
		 * Indica se è stato effettuato un riscontro autoptico.
		 * Valori possibili: ‘S’ (SI’), ‘N’ (NO).
		 * Obbligatorietà - NO
		 * Quando assente è valorizzato a null;
		 */		
		public var flagAutoptico:String = null;
		/**
		 * Indica il numero di giorni nel caso di degenza ordinaria
		 * Stringa Numerica
		 * Obbligatorietà - NO
		 * Quando assente è valorizzato a null;
		 */		
		public var giorniDegenzaOrdinaria:String = null; 
		/**
		 * Indica il numero di giorni nel caso di Day Hospital
		 * Stringa Numerica
		 * Obbligatorietà - NO
		 * Quando assente è valorizzato a null;
		 */		
		public var giorniPresenzaDH:String = null;
		/**
		 * Indica il codice dello stato civile del cittadino
		 * Stringa alfanumerica di lunghezza 1.
		 * Valori ammessi: vedi allegato 1 (Dati codificati – tabella Stati Civili).
		 * Obbligatorietà - NO
		 * Quando assente è valorizzato a null;
		 */		
		public var dataEventoIndice:String = null;
		/**
		 * Descrizione relativa allo stato civile del cittadino
		 * Stringa alfanumerica.
		 * Valori ammessi: vedi allegato 1 (Dati codificati – tabella Stati Civili).
		 * Obbligatorietà - NO
		 * Quando assente è valorizzato a null;
		 */		
		public var descrizioneStatoCivile:String = null;
		/**
		 * Codice che indica la cittadinanza del cittadino
		 * Stringa alfanumerica di lunghezza 3.
		 * Valori ammessi: vedi allegato 1 (Dati codificati – tabella Cittadinanze).
		 * Obbligatorietà - NO
		 * Quando assente è valorizzato a null;
		 */		
		public var idCittadinanza:String = null;
		/**
		 * Descrizione relativa alla cittadinanza del cittadino
		 * Stringa alfanumerica
		 * Valori ammessi: vedi allegato 1 (Dati codificati – tabella Cittadinanze).
		 * Obbligatorietà - NO
		 * Quando assente è valorizzato a null;
		 */		
		public var descrizioneCittadinanza:String = null;
		/**
		 * Codice ISTAT del comune di residenza del cittadino
		 * Stringa alfanumerica di lunghezza 6 caratteri. Può corrispondere a:
		 * 1.Codice ISTAT nel caso di comuni italiani ‘999’ + codice ISTAT dello stato estero (lunghezza 3)
		 * Obbligatorietà - NO
		 * Quando assente è valorizzato a null;
		 */		
		public var idComuneResidenza:String = null;
		/**
		 * Descrizione relativa al Codice ISTAT del comune di residenza del cittadino
		 * Stringa alfanumerica.
		 * Obbligatorietà - NO
		 * Quando assente è valorizzato a null;
		 */		
		public var descrizioneComuneResidenza:String = null;
		/**
		 * Indica la posizione professionale del cittadino
		 * Stringa alfanumerica di lunghezza 2.
		 * Valori ammessi: vedi allegato 1 (Dati codificati – tabella Posizioni Professionali).
		 * Obbligatorietà - NO
		 * Quando assente è valorizzato a null;
		 */		
		public var idPosizioneProfessionale:String = null;
		/**
		 * Descrizione relativa alla posizione professionale del cittadino
		 * Stringa alfanumerica.
		 * Valori ammessi: vedi allegato 1 (Dati codificati – tabella Posizioni Professionali).
		 * Obbligatorietà - NO
		 * Quando assente è valorizzato a null;
		 */		
		public var descrizionePosizioneProfessionale:String = null;
		/**
		 * Struttura relativa all’elenco delle diagnosi
		 * Obbligatorietà - NO
		 * Quando assente è valorizzato a null;
		 */		
		public var elencoDiagnosi:VoElencoDiagnosi = null;
		/**
		 * Struttura relativa all’elenco degli interventi
		 * Obbligatorietà - NO
		 * Quando assente è valorizzato a null;
		 */		
		public var elencoInterventi:VoElencoInterventi = null;
		
		public function VoDimissione()
		{
			super();
		}
		
	}
}