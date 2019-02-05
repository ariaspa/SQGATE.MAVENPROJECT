package it.lisit.siss.flex.communication.fse.voConsultaFascicolo2009
{
	import it.lisit.siss.flex.communication.ClonableValueObject;
	/**
	 * 
	 * @author Salvatore Civiletto
	 * 
	 */	
	public class VoStrutturaArchiviazione extends ClonableValueObject
	{
		/**
		 * Codice identificativo dell’ente associato alla erogazione dell’evento. 
		 * Stringa alfanumerica di lunghezza massima 16 caratteri.
		 * Obbligatorietà - SI
		 */		
		public var idEnte:String;
		/**
		 * Descrizione dell’ente associato alla erogazione dell’evento. 
		 * Stringa alfanumerica.
		 * Obbligatorietà - SI
		 */		
		public var descrizioneEnte:String;
		
		 
		public function VoStrutturaArchiviazione()
		{
			super();
		}
		
	}
}