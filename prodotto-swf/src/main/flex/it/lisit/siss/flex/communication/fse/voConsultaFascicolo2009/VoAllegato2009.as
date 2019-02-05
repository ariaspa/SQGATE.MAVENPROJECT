package it.lisit.siss.flex.communication.fse.voConsultaFascicolo2009
{
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoAllegato;
	/**
	 * Struttura contenente il documento allegato (formato, link ed etichetta)
	 * @author Salvatore Civiletto
	 * 
	 */	
	public class VoAllegato2009 extends VoAllegato
	{
		/**
		 * Definizione:		Etichetta relativa al documento associato al documento pubblicato.
		 * Vincoli:			Stringa alfanumerica di lunghezza massima 100 caratteri.
		 * Obbligatorietà:	NO
		 * 
		 */		
		public var etichettaAllegato:String;
		
		public function VoAllegato2009()
		{
			super();
		}
		
	}
}