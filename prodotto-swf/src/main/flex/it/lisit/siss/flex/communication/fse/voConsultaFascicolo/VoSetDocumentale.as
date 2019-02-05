package it.lisit.siss.flex.communication.fse.voConsultaFascicolo
{
	import it.lisit.siss.flex.communication.ClonableValueObject;
	/**
	 * Struttura contenente i metadati specifici associati al singolo DCE considerato 
	 * 
	 * @author Marco Salonia
	 * 
	 */	
	public class VoSetDocumentale extends ClonableValueObject
	{
		/**
		 * Struttura contenente i dati relativi alla struttura che di creazione del documento clinico 
		 * Obbligatorietà - SI
		 */		
		public var strutturaCreazione:VoStrutturaCreazione;
		/**
		 * Codice del tipo di documenti clinici che si possono pubblicare nel fascicolo.
		 * Stringa alfanumerica di lunghezza 10 caratteri. 
		 * Valori ammessi: vedi allegato 1 (Dati codificati – tabella Tipo Documenti).
		 * Obbligatorietà - SI
		 */		
		public var idTipoDocumento:String;
		/**
		 * Codice del tipo di documenti clinici che si possono pubblicare nel fascicolo.
		 * Stringa alfanumerica.
		 * Valori ammessi: vedi allegato 1 (Dati codificati – tabella Tipo Documenti).
		 * Obbligatorietà - SI
		 */		
		public var descrizioneTipoDocumento:String;
		/**
		 * Codice della disciplina di erogazione
		 * Stringa alfanumerica di lunghezza 2 caratteri.
		 * Valori ammessi: vedi allegato 1 (Dati codificati – tabella Disciplina_SISS).
		 * Obbligatorietà - NO
		 * Quando assente prende il valore di null;
		 */		
		public var idDisciplinaErogazione:String = null;
		/**
		 * Descrizione della disciplina di erogazione
		 * Stringa alfanumerica.
		 * Valori ammessi: vedi allegato 1 (Dati codificati – tabella Disciplina_SISS).
		 * Obbligatorietà - NO
		 * Quando assente prende il valore di null;
		 */		
		public var descrizioneDisciplinaErogazione:String = null;
		/**
		 * Struttura contenente la lista delle caratterizzazioni cliniche relative al DCE pubblicato
		 * Obbligatorietà - NO
		 * Quando assente prende il valore di null;
		 * Se presente la struttura conterrà almeno un VoCaratterizzazione 
		 */		
		public var caratterizzazioniCliniche:VoCaratterizzazioniCliniche = null;
		/**
		 * Data di creazione del documento clinico elettronico
		 * Data valida formalmente
		 * Lunghezza 14 caratteri
		 * Formato data ammesso  'YYYYMMDDHH24MMSS'
		 * Obbligatorietà - SI
		 * 
		 */		
		public var dataOraCreazione:String;
		/**
		 * Identificativo del Set Documentale del DCE oggetto di prima pubblicazione. 
		 * E’ utilizzato per aggregare mediante un valore unico tutti gli aggiornamenti di un DCE pubblicato in FSE.
		 * Stringa alfanumerica
		 * Obbligatorietà - SI
		 */		
		public var idAggregazioneDocumento:String;
		/**
		 * Valore che identifica univocamente nel SISS l’identificativo del set documentale pubblicato, comune a tutti i formati associati
		 * Stringa alfanumerica
		 * Obbligatorietà - SI
		 */		
		public var idSetDocumenti:String;
		/**
		 * Numero di versione associato al DCE 
		 * Stringa numerica 
		 * Non è valorizzato nel caso di Patient Summary e di documenti pubblicati con il SEB CRM
		 */		
		public var nVersione:String;
		/**
		 * Identificativo del documento padre di riferimento. 
		 * E’ l’identificativo del set documentale del documento di riferimento per DCE pubblicati cono FSE oppure l’uri nel caso di referti pubblicati con CRM
		 * Stringa alfanumerica
		 * Obbligatorietà - NO
		 * quando assente prende il valore di null
		 */		
		public var idDocumentoRiferimento:String = null;
		/**
		 * Numero di versione del documento a cui il documento che si pubblica fa riferimento.  
		 * E’ obbligatorio nel caso di qualsiasi tipo di aggiornamento di documenti di tipi scheda tranne che per  Patient Summary.
		 * Tale valore è il valore di output “nVersione” che il metodo di pubblicazione del documento di riferimento ha restituito.
		 * Intero contenente il progressivo identificativo di versione. Il valore iniziale è 1.
		 * Obbligatorietà - NO
		 * quando assente prende il valore di null
		 */		
		public var nVersioneDocumentoRiferimento:String = null;
		/**
		 * Natura dell’aggiornamento del documento da pubblicare. 
		 * Viene valorizzato ogniqualvolta viene effettuata una registrazione di un aggiornamento di un documento.
		 * Stringa alfanumerica di lunghezza massima di 10 caratteri. 
		 * Valori ammessi: vedi allegato 1 (Dati codificati – tabella Natura Documenti)
		 * Obbligatorietà - NO
		 * quando assente prende il valore di null
		 */		
		public var naturaAggiornamento:String = null;
		/**
		 * Struttura che contiene le informazioni relative ai possibili formati 
		 * associati al documento da pubblicare.
		 * Obbligatorietà - SI
		 */		
		public var documento_1:VoDocumento;
		/**
		 * Struttura che contiene le informazioni relative ai possibili formati 
		 * associati al documento da pubblicare.
		 * Obbligatorietà - NO
		 * quando assente prende il valore di null
		 */		
		public var documento_2:VoDocumento = null;
		/**
		 * Struttura contenente l’eventuale  lista di documenti allegati 
		 * al documento pubblicato, tipicamente trattasi di immagini
		 * Obbligatorietà - NO
		 * quando assente prende il valore di null
		 * Se presente contiene almeno un VoAllegato
		 */		
		public var listaAllegati:VoListaAllegati = null;
		/**
		 * Codifica della rete di patologia dalla quale è stato prodotto il documento clinico
		 * Stringa alfanumerica di lunghezza massima di 10 caratteri.
		 * Obbligatorietà - NO
		 * quando assente prende il valore di null
		 */		
		public var reteDiPatologia:String;
		/**
		 * Descrizione della rete di patologia dalla quale è stato prodotto il documento clinico
		 * Stringa alfanumerica.
		 * Obbligatorietà - NO
		 * quando assente prende il valore di null
		 */		
		public var descrizioneReteDiPatologia:String = null;
		/**
		 * Indica l’eventuale codifica LOINC attribuita al tipo di DCE pubblicato
		 * Stringa alfanumerica di lunghezza massima di 10 caratteri.
		 * Valori ammessi: vedi allegato 1 Dati codificati –  tabella TipiDocumentiLOINC
		 * Obbligatorietà - NO
		 * quando assente prende il valore di null
		 */		
		public var idTipoDocumentoLOINC:String;
		/**
		 * Struttura dati contenente i dati del medico che ha compilato il documento
		 * Obbligatorietà - SI
		 */		
		public var autoreDocumento:VoAutoreDocumento;
		/**
		 * Indica se il cittadino è autorizzato alla consultazione in autonomia del documento clinico.
		 * Stringa alfanumerica di lunghezza massima di 10 caratteri.
		 * Valori ammessi: vedi allegato 1 Dati codificati – tabella Stati Autorizzazione
		 * Obbligatorietà - SI
		 */		
		public var statoAutorizzazioneDocumento:String;
		/**
		 * Fornisce al cittadino indicazioni su come avere informazioni e chiarimenti sul documento clinico
		 * Stringa alfanumerica di lunghezza 1 KByte.
		 * Obbligatorietà - NO
		 * quando assente prende il valore di null
		 */		
		public var noteReperibilita:String = null;
		/**
		 * Struttura contenente un set di proprietà che caratterizzano un DCE. 
		 * Per una descrizione dettagliata si rimanda ai capitoli specifici
		 * Obbligatorietà - NO
		 * Essendo attributi specifici si fa ricorso del polimorfismo
		 * per dettagliare il singolo attributo
		 */		
		public var attributiSpecificiDCE:VoAttributiSpecificiDCE = null;
		 
		public function VoSetDocumentale()
		{
			super();
		}
	}
}