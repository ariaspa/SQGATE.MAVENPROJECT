package it.lisit.siss.flex.communication.fse.voConsultaFascicolo
{
	import it.lisit.siss.flex.communication.ClonableValueObject;
	/**
	 * Struttura contenente il documento allegato (formato e link)
	 * @author Marco Salonia
	 * 
	 */	
	public class VoAllegato extends ClonableValueObject
	{
		/**
		 * Link all’allegato associato al documento pubblicato. 
		 * Stringa alfanumerica.
		 * Obbligatorietà - SI
		 */		
		public var linkAllegato:String;
		/**
		 * Formato del documento associato al documento pubblicato.
		 * Stringa alfanumerica di lunghezza massima 10 caratteri.
		 * Valori ammessi: vedi allegato 1 (Dati codificati – Tipo FormatoAllegato)
		 * Obbligatorietà - SI
		 */		
		public var formatoAllegato:String;
		
		public function VoAllegato()
		{
			super();
		}
		
	}
}