package it.lisit.siss.flex.communication.fse.voOttieniDocumentoTestuale
{
	import it.lisit.siss.flex.communication.ValueObject;
	
	/**
	 * Struttura che contiene le informazioni relative al documento  
	 * @author Salvatore Civiletto
	 * 
	 */	
	public class VoDocumentoB64 extends ValueObject
	{
		/**
		 * Identificativo univoco del DCE all’interno del Fascicolo Sanitario Elettronico.
		 * Stringa alfanumerica.
		 * Obbligatorietà - NO. E’ sempre restituitto nel caso di DCE pubblicati mediante FSE
		 */		
		public var idSetDocumenti:String = null;
		
		/**
		 * Indica l’eventuale numero di versione associato al DCE.
		 * Stringa numerica.
		 * Obbligatorietà - NO
		 */		
		public var nVersione:uint;
		
		/**
		 * Codice del linguaggio in cui è redatto il documento
		 * Stringa alfanumerica di lunghezza 10 caratteri. 
		 * Valori ammessi: vedi allegato 1 (Dati codificati – tabella Linguaggi Documenti)
		 * Obbligatorietà - NO
		 * Quando assente assume il valore di null
		 */		
		public var linguaggioDocumento:String = null;
		
		/**
		 * Formato del documento (Strutturato piuttosto che testuale)
		 * Stringa alfanumerica di lunghezza massima di 10 caratteri.
		 * Valori ammessi: vedi allegato 1 (Dati codificati – tabella Tipo FormatoDocumento)
		 * Obbligatorietà - SI
		 */		
		public var formato:String ;
		
		/**
		 * Contenuto del DCE pubblicato non firmato ed in formato B64
		 * Obbligatorietà - SI
		 */		
		public var contenuto:String;
		
		/**
		 * URI del DCE
		 * Stringa numerica composta da ‘<idEnte>.<idRepository>.<idDocumento>’.
		 * Obbligatorietà - SI
		 */		
		public var uri:String;
		
		/**
		 * Rappresenta l’output ottenuto applicando la funzione hash al documento non firmato 
		 * e permette di identificare attraverso una stringa il documento. 
		 * E’ un dato in base64 ed è  restituito dal servizio di generazione del DAO.
		 * Stringa di lunghezza fissa.
		 * Obbligatorietà - SI
		 */		
		public var hashDocumento:String;
		
		/**
		 * Specifica l’algoritmo di hashing del documento. E’ un dato restituito dal servizio di generazione del DAO.
		 * Stringa di lunghezza lunghezza massima 10 caratteri.
		 * Valori ammessi: vedi allegato 1 (Dati codificati – tabella AlgoritmoHash)
 		 * Obbligatorietà - NO. 
		 * Quando assente assume il valore di null
		 */		
		public var algoritmoHash:String = null;
		
		/**
		 * Rappresenta la lunghezza in byte del documento originale (non firmato).
		 * Stringa
		 * Obbligatorietà - NO. 
		 * Quando assente assume il valore di null
		 */		
		public var sizeDocumento:String = null;
		
		
		public function VoDocumentoB64()
		{
			super();
		}
		
	}
}