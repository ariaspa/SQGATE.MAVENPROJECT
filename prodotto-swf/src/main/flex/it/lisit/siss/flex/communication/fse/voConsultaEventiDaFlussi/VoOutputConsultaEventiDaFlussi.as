package it.lisit.siss.flex.communication.fse.voConsultaEventiDaFlussi
{
	import it.lisit.siss.flex.communication.ValueObject;

	public class VoOutputConsultaEventiDaFlussi extends ValueObject
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
		 *	Struttura dati contenente i dati dell’esito della consultazione degli eventi relativo ad uno specifico cittadino.
		 * Obbligatorietà - SI
		 */		
		public var consultaEventi:VoConsultaEventi;
		public function VoOutputConsultaEventiDaFlussi()
		{
			super();
		}
	}
}