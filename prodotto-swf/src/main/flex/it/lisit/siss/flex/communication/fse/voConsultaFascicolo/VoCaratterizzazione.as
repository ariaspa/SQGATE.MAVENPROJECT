package it.lisit.siss.flex.communication.fse.voConsultaFascicolo
{
	import it.lisit.siss.flex.communication.ClonableValueObject;
	/**
	 * Struttura contenente la caratterizzazione clinica asociata al DCE
	 * @author Marco Salonia
	 * 
	 */	
	public class VoCaratterizzazione extends ClonableValueObject
	{
		/**
		 * Codice del dizionario a cui il codice di pratica clinica fa riferimento
		 * Stringa alfanumerica che specifica il dizionario (OID) a cui fa riferimento il codice. 
		 * Valori ammessi: vedi allegato 1 (Dati codificati – tabella DizionarioCodici).
		 * Obbligatorietà - SI
		 */		
		public var dizionario:String;
		/**
		 * Codice di pratica clinica associato 
		 * Stringa alfanumerica.
		 * Valori ammessi: codifica consentita per il dizionario di riferimento. 
		 * Es: caso dizionario  ICD9CM allora i valori ammessi saranno i possibili codici ICD9CM, ecc.
		 * Obbligatorietà - SI
		 */		
		public var codice:String;
		
		public function VoCaratterizzazione()
		{
			super();
		}
		
	}
}