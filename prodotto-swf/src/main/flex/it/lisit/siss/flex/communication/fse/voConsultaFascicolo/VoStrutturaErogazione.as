package it.lisit.siss.flex.communication.fse.voConsultaFascicolo
{
	import it.lisit.siss.flex.communication.ClonableValueObject;

	public class VoStrutturaErogazione extends ClonableValueObject
	{
		/**
		 * Codice identificativo dell’ente associato alla erogazione dell’evento. 
		 * Stringa alfanumerica di lunghezza massima 16 caratteri.
		 * Obbligatorietà - SI
		 */		
		public var idEnte:String;
		/**
		 * Descrizione associata all’identificativo dell’ente associato alla erogazione dell’evento. 
		 * Stringa alfanumerica.
		 * Obbligatorietà - SI
		 */		
		public var descrizioneEnte:String;
		/**
		 * Codice identificativo del presidio ospedaliero  associato alla erogazione dell’evento.
		 * Stringa alfanumerica di lunghezza di 8 caratteri.
		 * Obbligatorietà - SI
		 */		
		public var idPresidio:String;
		/**
		 * Descrizione associata all’identificativo del presidio ospedaliero  associato alla erogazione dell’evento.
		 * Stringa alfanumerica.
		 * Obbligatorietà - SI
		 */		
		public var descrizionePresidio:String;
	 
		public function VoStrutturaErogazione()
		{
			super();
		}
		
	}
}