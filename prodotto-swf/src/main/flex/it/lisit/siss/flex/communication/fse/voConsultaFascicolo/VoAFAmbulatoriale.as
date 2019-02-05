package it.lisit.siss.flex.communication.fse.voConsultaFascicolo
{
	public class VoAFAmbulatoriale extends VoAttributiFolder
	{
		/**
		 * Codice identificativo dell’ente associato alla erogazione dell’evento. 
		 * Stringa alfanumerica di lunghezza massima 16 caratteri.
		 * Obbligatorietà - SI
		 */		
		public var idEnte:String;
		/**
		 * Descrizione dell’ente associato alla erogazione dell’evento. 
		 * Stringa alfanumerica.
		 * Obbligatorietà - SI
		 */		
		public var descrizioneEnte:String;
		/**
		 * Codice identificativo del presidio o della struttura associata alla erogazione dell’evento.
		 * Stringa alfanumerica di lunghezza massima 9 caratteri 
		 * Obbligatorietà - SI
		 */		
		public var idPresidio:String;
		/**
		 *Descrizione del presidio o della struttura associata alla erogazione dell’evento.
		 * Stringa alfanumerica
		 * Obbligatorietà - SI
		 */		
		public var descrizionePresidio:String;
		/**
		 * Identificativo dell’evento comunicato (IUP della prescrizione SISS o IUP fittizio)
		 * Si tratta di una stringa alfanumerica. Corrisponde allo IUP (lunghezza uguale a 10)
		 * Obbligatorietà - SI se non proviene dai flussi
		 */		
		public var IUP:String;
		/**
		 * Numero di cartella ambulatoriale 
		 * Si tratta di una stringa alfanumerica. Corrisponde all’eventuale numero di cartella ambulatoriale associato ad una o più prescrizioni.
		 * Obbligatorietà - NO
		 * quando assente assume il valore di null
		 */		
		public var numeroCartellaAmbulatoriale:String = null;
		/**
		 * Identificativo della ricetta.
		 * Si tratta di una stringa alfanumerica di lunghezza massima di 20 caratteri. Corrisponde all’eventuale numero di ricetta (modulo RUR)
		 * Obbligatorietà - NO
		 * quando assente assume il valore di null
		 */		
		public var idPrescrizioneRUR:String = null;
		/**
		 *  Data della prescrizione 
		 * Data valida formalmente
		 * Lunghezza 8 caratteri
		 * Formato data ammesso  'YYYYMMDD'
		 * Obbligatorietà - NO
		 * quando assente assume il valore di null
		 */		
		public var dataPrescrizione:String = null;
		/**
		 * Codice della diagnosi associata alle prestazioni accettate. 
		 * Si tratta di una stringa alfanumerica di lunghezza 5. Corrisponde alla codifica ICD9-CM della diagnosi.
		 * Obbligatorietà - NO
		 * quando assente assume il valore di null
		 */		
		public var codiceDiagnosi:String = null;
		/**
		 * Descrizione della diagnosi associata alle prestazioni accettate. 
		 * Si tratta di una stringa alfanumerica.
		 * Obbligatorietà - NO
		 * quando assente assume il valore di null
		 */		
		public var descrizioneDiagnosi:String = null;
		/**
		 * Testo rappresentante il quesito diagnostico.
		 * Si tratta di una stringa alfanumerica di lunghezza massima uguale a 1000.
		 * Obbligatorietà - NO
		 * quando assente assume il valore di null
		 */		
		public var quesitoDiagnostico:String = null;
		/**
		 * Provenienza del paziente (del tracciato AMB/2)
		 * Si tratta di una stringa alfanumerica di lunghezza 1.
		 * Valori ammessi: vedi allegato 1 (Dati codificati – tabella Provenienza Specialistica )
		 * Obbligatorietà - NO
		 * quando assente assume il valore di null
		 */		
		public var idProvenienzaPaziente:String = null;
		/**
		 * Descrizione dells provenienza del paziente (del tracciato AMB/2)
		 * Si tratta di una stringa alfanumerica
		 * Obbligatorietà - NO
		 * quando assente assume il valore di null
		 */		
		public var descrizioneProvenienzaPaziente:String = null;
		/**
		 * Codice classe di priorità corrispondente al campo CLASSE DI PRIORITA' del tracciato AMB/2 (esclusi i codici di PS)
		 * Si tratta di una stringa alfanumerica di lunghezza massima 2.
		 * Valori ammessi: vedi allegato 1 (Dati codificati – tabella Classe Priorita).
		 * Obbligatorietà - NO
		 * quando assente assume il valore di null
		 */		
		public var idClassePriorita:String = null;
		/**
		 * Descrizione della classe di priorità
		 * Si tratta di una stringa alfanumerica
		 * Obbligatorietà - NO
		 * quando assente assume il valore di null
		 */		
		public var descrizioneClassePriorita:String = null;
		/**
		 * Codice del regime di erogazione 
		 * Si tratta di una stringa alfanumerica di lunghezza 1.
		 * Valori ammessi: vedi allegato 1 (Dati codificati – tabella Regime Erogazione).
		 * Obbligatorietà - NO
		 * quando assente assume il valore di null
		 */		
		public var idRegimeErogazione:String = null;
		/**
		 * Descrizione del regime di erogazione 
		 * Si tratta di una stringa alfanumerica.
		 * Obbligatorietà - NO
		 * quando assente assume il valore di null
		 */		
		public var descrizioneRegimeErogazione:String = null;
		/**
		 * Codice di esenzione, corrispondente al CODICE DI ESENZIONE del tracciato AMB/2
		 * Si tratta di una stringa alfanumerica di lunghezza minima 3 e massima 10.
		 * Valori ammessi: vedi allegato 1 (Dati codificati – tabella Esenzioni).
		 * Obbligatorietà - NO
		 * quando assente assume il valore di null
		 */		
		public var idEsenzione:String = null;
		/**
		 * Descrizione associata all’esenzione
		 * Si tratta di una stringa alfanumerica.
		 * Obbligatorietà - NO
		 * quando assente assume il valore di null
		 */		
		public var descrizioneEsenzione:String = null;
		/**
		 * Dati relativi del medico richiedente
		 * è da intendersi alternativo ad medicoRichiedente_codiceRegionale
		 * se medicoRichiedente_codiceRegionale è valorizzato a null allora medicoRichiedente_codiceFiscale sarà valorizzato
		 * Codice fiscale del medico richiedente
		 * Stringa alfanumerica di lunghezza 16.
		 * I valori ammessi:
		 * Formato ammesso nel caso di codice fiscale: AAAAAANNANNANNNA 
		 * (AAAAAA[AN][AN]A[AN][AN]A[AN][AN][AN]A nel caso di omocodia).
		 * Ammesse solo maiuscole.
		 * Obbligatorietà - NO
		 * quando assente assume il valore di null
		 */		
		public var medicoRichiedente_codiceFiscale:String = null;
		/**
		 * Dati relativi del medico richiedente
		 * è da intendersi alternativo ad medicoRichiedente_codiceFiscale
		 * se medicoRichiedente_codiceFiscale è valorizzato a null allora medicoRichiedente_codiceRegionale sarà valorizzato
		 * Stringa alfanumerica di lunghezza 5.
		 * Obbligatorietà - NO
		 * quando assente assume il valore di null
		 */		
		public var medicoRichiedente_codiceRegionale:String = null;
		/**
		 * Codice della tipologia di prestazione 
		 * Si tratta di una stringa alfanumerica di lunghezza 1.
		 * Valori ammessi: vedi allegato 1 (Dati codificati – tabella Tipo Prestazione).
		 * Obbligatorietà - NO
		 * quando assente assume il valore di null
		 */		
		public var idTipoPrestazione:String = null;
		/**
		 * Descrizione della tipologia di prestazione 
		 * Si tratta di una stringa alfanumerica.
		 * Obbligatorietà - NO
		 * quando assente assume il valore di null
		 */		
		public var descrizioneTipoPrestazione:String = null;
		/**
		 * Struttura relativa alla lista delle prestazioni accettate 
		 * Obbligatorietà - SI
		 */		
		public var prestazioniAssociate:VoPrestazioniAssociate;
		/**
		 * Data di accettazione delle prestazioni 
		 * Data valida formalmente
		 * Lunghezza 8 caratteri
		 * Formato data ammesso  'YYYYMMDD'.
		 * Obbligatorietà - SI
		 */		
		public var dataAccettazione:String;
		/**
		 * Data della prenotazione delle prestazioni 
		 * Data valida formalmente
		 * Lunghezza 8 caratteri
		 * Formato data ammesso  'YYYYMMDD'.
		 * Obbligatorietà - SI
		 */		
		public var dataPrenotazione:String;
		public function VoAFAmbulatoriale()
		{
			super();
		}
		override public function get type():int
		{
			return ConstTipiAttributiFolder.ATTRIBUTI_AMBULATORIALE;
		}
	}
}