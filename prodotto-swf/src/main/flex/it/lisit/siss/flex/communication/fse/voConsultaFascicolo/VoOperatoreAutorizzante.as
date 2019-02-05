package it.lisit.siss.flex.communication.fse.voConsultaFascicolo
{
	import it.lisit.siss.flex.communication.ClonableValueObject;
	/**
	 * Struttura dati contenente i dati del medico 
	 * che ha autorizzato il cittadino alla consultazione del documento clinico elettronico. 
	 * @author Marco Salonia
	 * 
	 */	
	public class VoOperatoreAutorizzante extends ClonableValueObject
	{
		/**
		 *Codice fiscale del medico autorizzante il cittadino alla consultazione del DCE.
		 * Formato ammesso: AAAAAANNANNANNNA (tranne  nel caso di omocodia).
		 * Ammesse solo maiuscole.
		 * Obbligatorietà - SI
		 */		
		public var codiceFiscaleAutorizzante:String;
		/**
		 * Cognome del medico autorizzante il cittadino alla consultazione del DCE.
		 * Stringa alfanumerica di lunghezza massima 50 caratteri.
		 * Obbligatorietà - SI
		 */		
		public var cognomeAutorizzante:String;
		/**
		 * Nome del medico autorizzante il cittadino alla consultazione del DCE
		 * Stringa alfanumerica di lunghezza massima 50 caratteri.
		 * Obbligatorietà - SI
		 */		
		public var nomeAutorizzante:String;
		public function VoOperatoreAutorizzante()
		{
			super();
		}
		
	}
}