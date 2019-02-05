package it.lisit.siss.flex.communication.event
{
	import it.lisit.siss.flex.communication.ValueObject;
	import it.lisit.siss.flex.utility.IIterator;

	public class VoFault extends ValueObject
	{
		/**
		 * Restituisce uno dei codici previsti dallo standard . 
		 * Stringa alfanumerica.
		 * Valori ammessi:
		 * VersionMismatch 
		 * MustUnderstand 
		 * Client - per errori non recuperabili
		 * Server - per errori recuperabili
		 * Obbligatorio Si.
		 */		
		public var faultcode:String;
		/**
		 * Descrizione a testo libero dell’errore. 
		 * Stringa alfanumerica, senza interlinee.
		 * Poiché la descrizione dell’errore è direttamente visualizzata 
		 * all’operatore che ha generato la richiesta.
		 * Obbligatorio Si.
		 */		
		public var faultstring:String;
		/**
		 * iteratore contenente dei VoFaultDetail 
		 */		
		public var faultDetail:IIterator;
		public function VoFault()
		{
			super();
		}
	}
}