package it.lisit.siss.flex.communication.fse.voConsultaFascicolo
{
	import it.lisit.siss.flex.communication.ClonableValueObject;
	/**
	 * Struttura che contiene le informazioni relative ai possibili formati associati al documento da pubblicare. 
	 * Il numero delle occorrenze va da 1 a 2 
	 * (documento testuale/ documento strutturato/documento testuale e strutturato).
	 * @author Marco Salonia
	 * 
	 */	
	public class VoDocumento extends ClonableValueObject
	{
		/**
		 * Codice del linguaggio in cui è redatto il documento
		 * Stringa alfanumerica di lunghezza 10 caratteri. 
		 * Valori ammessi: vedi allegato 1 (Dati codificati – tabella Linguaggi Documenti)
		 * Obbligatorietà - NO
		 * Quando assente assume il valore di null
		 */		
		public var linguaggioDocumento:String = null;
		/**
		 * Informazione che indica se il documento è firmato o no. 
		 * Stringa. Valori ammessi: S (firmato), N(non firmato)
		 * Obbligatorietà - SI
		 */		
		public var firmato:String ;
		/**
		 * Formato del documento (Strutturato piuttosto che testuale)
		 * Stringa alfanumerica di lunghezza massima di 10 caratteri.
		 * Valori ammessi: vedi allegato 1 (Dati codificati – tabella Tipo FormatoDocumento)
		 * Obbligatorietà - SI
		 */		
		public var formato:String ;
		/**
		 * URI del DCE
		 * Stringa alfanumerica composta da ‘<idEnte>.<idRepository>.<linkDCE>’.
		 * Obbligatorietà - SI
		 */		
		public var uri:String;
		/**
		 * Versione dello schema CDA2 associato al DCE strutturato pubblicato. 
		 * Nel caso in cui non è disponibile lo schema specifico del DCE 
		 * allora può essere valorizzato con il codice dello schema generico, ovvero il codice CDA2.
		 * Stringa alfanumerica di lunghezza massima 20 caratteri.
		 * Valori ammessi: vedi allegato 1 (Dati codificati – tabella ValidazioneSchema)
		 * Obbligatorietà - NO. Presenti solo nel caso di pubblicazione di DCE di tipo strutturato
		 * Quando assente assume il valore di null
		 */		
		public var validazioneSchema:String= null;
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
		
		
		public function VoDocumento()
		{
			super();
		}
		
	}
}