package it.lisit.siss.flex.communication.fse.voConsultaStoricoDCE
{
	import it.lisit.siss.flex.communication.ValueObject;

	public class VoOutputConsultaStoricoDCE extends ValueObject
	{
		
		/**
		 * Indica se la ricerca è andata a buon fine o meno 
		 * Vincoli - “OK” 
		 * Obbligatorietà - SI
		 */		
		public var esito:String;
		/**
		 * Definizione:		Struttura dati contenente i dati dell’esito della consultazione del 
		 * 				Fascicolo Sanitario Elettronico relativo ad uno specifico cittadino.
		 * Obbligatorietà:	SI
		 */		
		public var consultaStoricoDCE:VoConsultaStoricoDCE;
		
		public function VoOutputConsultaStoricoDCE()
		{
			super();
		}
		
	}
}