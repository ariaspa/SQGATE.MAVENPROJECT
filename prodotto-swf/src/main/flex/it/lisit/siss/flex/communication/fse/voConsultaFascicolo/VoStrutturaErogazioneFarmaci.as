package it.lisit.siss.flex.communication.fse.voConsultaFascicolo
{
	import it.lisit.siss.flex.communication.ClonableValueObject;

	public class VoStrutturaErogazioneFarmaci extends ClonableValueObject
	{
		/**
		 *Codice identificativo regionale della farmacia composto da sigla provincia e progressivo numerico. 
		 * Stringa alfanumerica di lunghezza massima 6 caratteri.
		 * Obbligatorietà - SI
		 */		
		public var idFarmacia:String;
		/**
		 * Descrizione dell’ente associato alla erogazione dell’evento. 
		 * Stringa alfanumerica.
		 * Obbligatorietà - SI
		 */		
		public var descrizioneFarmacia:String;
		/**
		 * Codice identificativo dell’ASL a cui la farmacia appartiene
		 * Stringa alfanumerica di lunghezza 6 caratteri.
		 * Obbligatorietà - SI
		 */		
		public var idASLAppartenenza:String;
		/**
		 * Descrizione associata all’ASL 
		 * Stringa alfanumerica.
		 * Obbligatorietà - SI
		 */		
		public var descrizioneASLAppartenenza:String;
		 
		public function VoStrutturaErogazioneFarmaci()
		{
			super();
		}
		
	}
}