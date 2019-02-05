package it.lisit.siss.flex.communication.fse.voConsultaFascicolo2009
{
	import it.lisit.siss.flex.communication.ValueObject;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoConsultaFascicolo;
	/**
	 * VoOutputConsultafascicolo contiene la risposta in formato ValueObject del servizio 
	 * ConsultaFascicolo
	 * 
	 * @author Salvatore Civiletto
	 * 
	 */	
	public class VoOutputConsultaFascicolo2009 extends ValueObject
	{
		/**
		 * Numero totale delle pagine da estrarre per acquisire tutti i record del servizio.
		 * Obbligatorietà - SI
		 */		
		public var nPagine:uint;
		/**
		 * Indica se la ricerca è andata a buon fine o meno 
		 * Vincoli - “OK” 
		 * Obbligatorietà - SI
		 */		
		public var esito:String;
		/**
		 *	Struttura dati contenente i dati dell’esito della consultazione del Fascicolo Sanitario Elettronico relativo ad uno specifico cittadino.
		 * Obbligatorietà - SI
		 */		
		public var consultaFascicolo:VoConsultaFascicolo;
		///////////////////////////////////////////////////////
		public function VoOutputConsultaFascicolo2009()
		{
			super(); 
		}
	}
}