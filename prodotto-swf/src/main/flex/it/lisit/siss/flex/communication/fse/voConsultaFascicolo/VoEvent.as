package it.lisit.siss.flex.communication.fse.voConsultaFascicolo
{
	import it.lisit.siss.flex.communication.ClonableValueObject;
	/**
	 * Indica la struttura del singolo evento proveniente dai flussi
	 * @author Marco Salonia
	 * 
	 */	
	public class VoEvent extends ClonableValueObject
	{
		/**
		 * Codifica della tipologia dell’evento considerato 
		 * Obbligatorietà - SI
		 */		
		public var idTipoEvento:String;
		/**
		 * Descrizione della tipologia dell’evento considerato
		 * Obbligatorietà - SI
		 */		
		public var descrizioneTipoEvento:String;
		/**
		 * Identificativo dell’evento considerato (IUP)
		 * Obbligatorietà - SI
		 */		
		public var idEvento:String;
		/**
		 * Data di erogazione dell’evento considerato
		 * Data valida formalmente
		 * Stringa di lunghezza 8
		 * Formato data ammesso  'YYYYMMDD'
		 * Obbligatorietà - SI
		 */		
		public var dataErogazioneEvento:String;
		/**
		 * Struttura contenente gli attributi specifici del folder. La descrizione è riportata 
		 * in paragrafi dedicati alle varie tipologie di eventi.
		 * Per la loro natura di dato che può contenere tipi diversi di informazione
		 * viene applicato il polimorfismo, quindi secondo il tipo di informazione bisogna fare un cast adeguato
		 * dell'oggetto VoAttributiFolder  
		 */			
		public var attributiFolder:VoAttributiFolder;
		public function VoEvent()
		{
			super();
		}
		
	}
}