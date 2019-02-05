package it.lisit.siss.flex.communication.fse.voConsultaFascicolo
{
	import it.lisit.siss.flex.communication.ClonableValueObject;
	/**
	 * Struttura relativa alla singola diagnosi
	 * @author Marco Salonia
	 * 
	 */	
	public class VoDiagnosi extends ClonableValueObject
	{
		/**
		 *Data formulazione diagnosi
		 * Data valida formalmente
		 * Lunghezza 8 caratteri
		 * Formato data ammesso  'YYYYMMDD'
		 * Obbligatorietà - SI
		 */		
		public var dataFormulazioneDiagnosi:String;
		/**
		 * Codifica in ICD9-CM della diagnosi di dimissione. 
		 * Si tratta di una stringa alfanumerica di lunghezza massima 5. Corrisponde alla codifica ICD9-CM della diagnosi.
		 * Obbligatorietà - SI
		 */		
		public var idDiagnosi:String;
		/**
		 * Descrizione della codifica in ICD9-CM della diagnosi di dimissione. 
		 * Si tratta di una stringa alfanumerica. Corrisponde alla codifica ICD9-CM della diagnosi.
		 * Obbligatorietà - SI
		 */		
		public var descrizioneDiagnosi:String;
		/**
		 * Indica una annotazione associata al codice della diagnosi.
		 * Stringa alfanumerica di lunghezza massima 1000 caratteri.
		 * Obbligatorietà - NO
		 * Quando assente è valorizzato a null;
		 */		
		public var noteDiagnosi:String = null;
		
		
		public function VoDiagnosi()
		{
			super();
		}
		
	}
}