package it.lisit.siss.flex.communication.fse.voOttieniIndiceFascicolo
{
	import it.lisit.siss.flex.communication.ValueObject;
	import it.lisit.siss.flex.communication.fse.voAutorizzaDce.VoCittadino;

	public class VoOttieniIndiceFascicolo extends ValueObject
	{
		/** Definizione:	Struttura dati contenente i dati del cittadino cui è riferito il Fascicolo Sanitario Elettronico
		*   Obbligatorietà:	SI
		**/
		public var cittadino:VoCittadino;
		
		/**
		 * Definizione:		Struttura dati contenente la struttura del fascicolo o parte di esso e relativo al cittadino specificato
		 * Obbligatorietà:	NO
		 */		
		 public var indiceFascicolo:VoIndiceFascicolo;
		
		public function VoOttieniIndiceFascicolo()
		{
			super();
		}
		
	}
}