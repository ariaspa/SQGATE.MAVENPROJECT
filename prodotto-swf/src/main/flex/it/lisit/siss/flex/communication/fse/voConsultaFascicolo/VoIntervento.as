package it.lisit.siss.flex.communication.fse.voConsultaFascicolo
{
	import it.lisit.siss.flex.communication.ClonableValueObject;
	/**
	 * 
	 * @author Marco Salonia
	 * 
	 */	
	public class VoIntervento extends ClonableValueObject
	{
		/**
		 *Data intervento
		 * Data valida formalmente
		 * Lunghezza 8 caratteri
		 * Formato data ammesso  'YYYYMMDD'
		 * Obbligatorietà - SI
		 */		
		public var dataIntervento:String;
		/**
		 * Codifica intervento 
		 * Si tratta di una stringa alfanumerica di lunghezza 4.
		 * Valori ammessi: vedi allegato 1 (Dati codificati – tabella Interventi).
		 * Obbligatorietà - SI
		 */		
		public var idIntervento:String;
		/**
		 * Descrizione della codifica intervento 
		 * Si tratta di una stringa alfanumerica.
		 * Valori ammessi: vedi allegato 1 (Dati codificati – tabella Interventi).
		 * Obbligatorietà - SI
		 */		
		public var descrizioneIntervento:String;
		/**
		 * Indica una annotazione associata al codice degli interventi.
		 * Stringa alfanumerica di lunghezza massima 1000 caratteri.
		 * Obbligatorietà - NO
		 * Quando assente è valorizzato a null;
		 */		
		public var noteIntervento:String = null;
		 
		public function VoIntervento()
		{
			super();
		}
		
	}
}