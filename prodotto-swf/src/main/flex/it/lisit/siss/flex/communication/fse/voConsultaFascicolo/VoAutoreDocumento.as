package it.lisit.siss.flex.communication.fse.voConsultaFascicolo
{
	import it.lisit.siss.flex.communication.ClonableValueObject;
	/**
	 * Struttura dati contenente i dati del medico che ha compilato il documento
	 * @author Marco Salonia
	 * 
	 */	
	public class VoAutoreDocumento extends ClonableValueObject
	{
		/**
		 * Codice fiscale del medico che ha redatto il documento clinico elettronico
		 * Formato ammesso: AAAAAANNANNANNNA 
		 * (tranne nel caso di omocodia).
		 * Ammesse solo maiuscole.
		 * Obbligatorietà - SI
		 */		
		public var codiceFiscale:String;
		/**
		 * Cognome del medico che ha redatto il DCE
		 * Stringa alfanumerica di lunghezza massima 50 caratteri.
		 * Obbligatorietà - SI
		 */		
		public var cognome:String;
		/**
		 * Nome del medico che ha redatto il DCE.
		 * Stringa alfanumerica di lunghezza massima 50 caratteri.
 		 * Obbligatorietà - SI
		 */		
		public var nome:String;
		/**
		 * Descrizione del ruolo del medico che ha firmato il documento clinico.
		 * Stringa alfanumerica di lunghezza massima 50 caratteri.
		 * Obbligatorietà - NO
		 * Quando assente è valorizzato a null;
		 */		
		public var ruolo:String = null;
		/**
		 * Struttura dati contenente i dati del medico che ha autorizzato 
		 * il cittadino alla consultazione del documento clinico elettronico.
		 * Obbligatorietà - NO
		 * Quando assente è valorizzato a null;
		 */		
		public var operatoreAutorizzante:VoOperatoreAutorizzante = null;
		
		
		public function VoAutoreDocumento()
		{
			super();
		}
		
	}
}