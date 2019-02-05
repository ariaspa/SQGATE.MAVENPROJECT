package it.lisit.siss.flex.communication.fse.voConsultaFascicolo
{
	import it.lisit.siss.flex.communication.ValueObject;
	/**
	 * Struttura dati contenente i dati dell’esito della consultazione del Fascicolo Sanitario Elettronico relativo ad uno specifico cittadino. 
	 * @author Marco Salonia
	 * 
	 */
	public class VoConsultaFascicolo extends ValueObject
	{
		/**
		 * Struttura dati contenente la struttura del fascicolo o parte di esso e relativo al cittadino specificato
		 * In caso di manacanza dei dati, fascicolo ha valore null;
		 * Obbligatorietà - NO
		 */		
		public var fascicolo:Vofascicolo = null;
		/**
		 * Struttura dati contenente gli eventi provenienti dai flussi e non riconducibile alla struttura tipica del fascicolo in quanto incompleti.
		 * In caso di manacanza dei dati, eventi ha valore null;
		 * Obbligatorietà - NO
		 */		
		public var eventi:VoEventi;
		/**
		 * Codice cittadino cui il fascicolo è riferito. Il tipo di codice è specificato nella property “tipoIdCittadino”.
		 * Stringa alfanumerica di lunghezza massima 20.
		 * I valori ammessi dipendono dal tipo di codice specificato in “tipoIdCittadino” (tipo).
		 * Nel caso di codice fiscale:
		 * Formato ammesso nel caso di codice fiscale: AAAAAANNANNANNNA 
		 * (AAAAAA[AN][AN]A[AN][AN]A[AN][AN][AN]A nel caso di omocodia).
		 * Ammesse solo maiuscole.
		 * Obbligatorietà - SI
		 */		
		public var idCittadino:String;
		/**
		 * Tipo di codice cittadino specificato. Nel caso di tipoIdCittadino=’CF’ allora il codice Cittadino  è quello fiscale
		 * Stringa alfanumerica di lunghezza massima di 10 caratteri.
		 * Valori ammessi: vedi allegato 1 Dati codificati –  tabella Tipi Codici Cittadino
		 * Obbligatorietà - SI
		 */		
		public var tipoIdCittadino:String;
		
		public function VoConsultaFascicolo()
		{
			super();
		}
		
	}
}