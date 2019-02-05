package it.lisit.siss.flex.communication.fse.voConsultaFascicolo
{
	import it.lisit.siss.flex.communication.ClonableValueObject;
	/**
	 * 
	 * @author Marco Salonia
	 * 
	 */	
	public class VoTrasferimento extends ClonableValueObject
	{
		/**
		 * Data ed ora in cui il cittadino viene dimesso dal reparto presso cui era ricoverato.
		 * Data valida formalmente
		 * Lunghezza 8 caratteri
		 * Formato data  'YYYYMMDD’
		 * Obbligatorietà - SI 
		 */		
		public var dataTrasferimento:String;
		/**
		 * Indica il reparto origine del trasferimento
		 * Stringa alfanumerica di lunghezza massima 6 caratteri.
		 * Obbligatorietà - SI
		 */		
		public var idRepartoOrigine:String;
		/**
		 * Indica il reparto origine del trasferimento
		 * Stringa alfanumerica.
		 * Obbligatorietà - SI
		 */		
		public var descrizioneRepartoOrigine:String;
		/**
		 * Indica il reparto destinazione del trasferimento
		 * Stringa alfanumerica di lunghezza massima 6 caratteri.
		 * Obbligatorietà - SI
		 */		
		public var idRepartoDestinazione:String;
		/**
		 * Indica il reparto destinazione del trasferimento
		 * Stringa alfanumerica.
		 * Obbligatorietà - SI
		 */		
		public var descrizioneRepartoDestinazione:String;
		public function VoTrasferimento()
		{
			super();
		}
		
	}
}