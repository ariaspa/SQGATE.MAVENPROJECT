package it.lisit.siss.flex.communication.fse.voConsultaFascicolo
{
	import it.lisit.siss.flex.communication.ClonableValueObject;
	/**
	 * Struttura relativa alla prestazione accettata 
	 * @author Marco Salonia
	 * 
	 */	
	public class VoPrestazione extends ClonableValueObject
	{
		/**
		 * Codifica SISS della prestazione specialistica associata 
		 * Valori ammessi: vedi allegato 1 (Dati codificati – tabella Prestazioni).
		 * Obbligatorietà - SI
		 */		
		public var idPrestazioneSISS:String;
		/**
		 * Descrizione relativa alla codifica SISS della prestazione specialistica associata 
		 * Stringa alfanumerica
		 * Obbligatorietà - SI	
		 */		
		public var descrizionePrestazioneSISS:String;
		/**
		 * Flag  che specifica se la prestazione risulta aggiuntiva o no rispetto alla prescrizione 
		 * Si tratta di una stringa alfanumerica di lunghezza 1. Valori ammessi: ‘S’, ‘N’.
		 * Obbligatorietà - SI	
		 */		
		public var flagAggiuntiva:String;
		 
		 
		public function VoPrestazione()
		{
			super();
		}
		
	}
}