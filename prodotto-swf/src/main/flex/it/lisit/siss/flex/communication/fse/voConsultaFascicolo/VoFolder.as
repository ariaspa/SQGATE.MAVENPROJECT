package it.lisit.siss.flex.communication.fse.voConsultaFascicolo
{
	import it.lisit.siss.flex.communication.ClonableValueObject;

	public class VoFolder extends ClonableValueObject
	{
		/**
		 * Identificativo del  folder della struttura del fascicolo
		 * Obbligatorietà - NO. E’ obbligatorio solo per folder di tipo ‘foglia’
		 * Quando non presente ha valore null;
		 */		
		public var idFolder:String = null;
		/**
		 * Identificativo della tipologia di  folder della struttura del fascicolo
		 * Stringa alfanumerica di lunghezza 2.
		 * Valori ammessi: vedi allegato 1 (Dati codificati – tabella Tipo Folder).
		 * Obbligatorietà - SI
		 */		
		public var idTipoFolder:String;
		/**
		 * Descrizione del tipo di folder 
		 * Stringa alfanumerica. Valori ammessi: vedi allegato 1 (Dati codificati – tabella Tipo Folder).
		 * Obbligatorietà - SI
		 */		
		public var descrizioneFolder:String;
		/**
		 *	Etichetta relativa  al folder della struttura del fascicolo 
		 * Stringa alfanumerica.
		 * Valori ammessi: vedi allegato 1 (Dati codificati – tabella Tipo Folder).
		 * Obbligatorietà - SI 
		 */		
		public var etichettaFolder:String;
		/**
		 * Identificativo dello stato del folder. Indica se il folder è da validare o no
		 * Stringa alfanumerica che può assumere i seguenti valori: OK(validato), KO(non validato)
		 * Obbligatorietà - SI
		 */		
		public var idStatoFolder:String;
		/**
		 * Identificativo dell’eventuale folder padre del folder considerato 
		 * Stringa alfanumerica. Valori ammessi: vedi allegato 1 (Dati codificati – tabella Tipo Folder). 
		 * Obbligatorietà - NO
		 * Quando non presente assume il valore di null
		 * ed indica in un'eventuale identazione che questo folder è un dato di root 
		 */		
		public var idTipoFolderPadre:String = null;
		/**
		 * Numero di livello associato al folder considerato
		 * Stringa numerica. Valori ammessi: vedi allegato 1 (Dati codificati – tabella Tipo Folder).
		 * Obbligatorietà - SI
		 */		
		public var nLivelloFolder:String;
		
		/**
		 * Struttura contenente gli attributi specifici del folder. La descrizione è riportata 
		 * in paragrafi dedicati alle varie tipologie di eventi.
		 * Per la loro natura di dato che può contenere tipi diversi di informazione
		 * viene applicato il polimorfismo, quindi secondo il tipo di informazione bisogna fare un cast adeguato
		 * dell'oggetto VoAttributiFolder  
		 * Obbligatorietà - NO
		 * Quando non presente assume il valore di null
		 */		
		public var attributiFolder:VoAttributiFolder = null;
		/**
		 * Struttura contenente l’eventuale lista dei DCE (VoSetDocumentale) contenuti nel folder considerato
		 * Se presente conterrà almeno un VoSetDocumentale
		 * Obbligatorietà - NO
		 * Quando non presente assume il valore di null
		 */		
		public var listaDCE:VoListaDCE = null;
		
		public function VoFolder()
		{
			super();
		}
		
	}
}