package it.lisit.siss.flex.communication.fse.voOttieniIndiceFascicolo
{
	import it.lisit.siss.flex.communication.ValueObject;

	public class VoOutputOttieniIndiceFascicolo extends ValueObject
	{
		
		/**
		 * Definizione:		Indica se la ricerca è andata a buon fine o meno
		 * Vincoli:			“OK” 
		 * Obbligatorietà:	SI
		*/		 
		public var esito:String	 
		
		/**
		 * Definizione:		Struttura dati contenente i dati dell’esito dell’acquisizione 
		 * dell’indice del Fascicolo Sanitario Elettronico relativo ad uno specifico cittadino.
		 * Obbligatorietà:	SI
		*/
		public var ottieniIndiceFascicolo:VoOttieniIndiceFascicolo;
		
		/**
		 * Definizione:		Numero totale delle pagine da estrarre per acquisire tutti i record del servizio.
		 * Vincoli:			Stringa numerica
		 * Obbligatorietà:	SI
		 */		
		 public var nPagine:uint;

		
		public function VoOutputOttieniIndiceFascicolo()
		{
			super();
		}
		
	}
}