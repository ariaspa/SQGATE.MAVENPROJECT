package it.lisit.siss.flex.communication.event
{
	import it.lisit.siss.flex.communication.ValueObject;

	public class VoEccezione extends ValueObject
	{
		/**
		 * Il codice dell’eccezione definito dall’Aderente Espositore del servizio
		 * Stringa alfanumerica
		 * Obbligatorio
		 * No, la codifica puntuale dei singoli dettagli di un’eccezione 
		 * è a discrezione dell’Espositore del servizio
		 */		
		public var codiceEccezione:String;
		/**
		 * Il messaggio che descrive l’eccezione
		 * Stringa alfanumerica
		 * Obbligatorio Si
		 */		
		public var descEccezione:String;
		/**
		 * Il nome del campo il quale contenuto ha causato l’eccezione
		 * Stringa alfanumerica 
		 * Obbligatorio No
		 */		
		public var nomeCampo:String;
		/**
		 * Il contenuto del campo il quale ha causato l’eccezione
		 * Stringa alfanumerica
		 * Obbligatorio No
		 */		
		public var valoreCampo:String;
		/**
		 * Messaggio di dettaglio riferito al campo
		 * Stringa alfanumerica
		 * Obbligatorio No
		 */		
		public var descEccezioneCampo:String;
		/**
		 * Codice di dettaglio riferito al campo 
		 * Stringa alfanumerica
		 * Obbligatorio No
		 */		
		public var codiceEccezioneCampo:String;
		/**
		 * Identificativo dell’oggetto a cui si riferisce il warning 
		 * Stringa alfanumerica 
		 * Obbligatorio No
		 */		
		public var ROI:String;
		 
		public function VoEccezione()
		{
			super();
		}
		
	}
}