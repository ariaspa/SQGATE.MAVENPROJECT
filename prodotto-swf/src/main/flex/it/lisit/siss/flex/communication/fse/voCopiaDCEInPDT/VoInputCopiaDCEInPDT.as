package it.lisit.siss.flex.communication.fse.voCopiaDCEInPDT
{
	import it.lisit.siss.flex.communication.ValueObject;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoAttributiFolder;

	public class VoInputCopiaDCEInPDT extends ValueObject
	{
		/**
		 * Codice cittadino cui il PDT è riferito. 
		 * Il tipo di codice è specificato nella proprerty “tipoIdCittadino”.  
		 * Il cittadino per essere valido deve essere presente in Anagrafe Regionale. 
		 * Stringa alfanumerica di lunghezza massima 20.
		 * I valori ammessi dipendono dal tipo di codice specificato in “tipoIdCittadino”.
		 * Nel caso di codice fiscale:
		 * Formato ammesso nel caso di codice fiscale: AAAAAANNANNANNNA 
		 * (tranne nel caso di omocodia).
		 * Ammesse solo maiuscole.
		 * Obbligatorietà - SI
		 */		
		public var idCittadino:String;
		/**
		 * Tipo di codice cittadino specificato. Nel caso di tipoIdCittadino='CF' allora il codice Cittadino  è quello fiscale
		 * Stringa alfanumerica di lunghezza massima di 10 caratteri.
		 * Valori ammessi: vedi allegato 1 Dati codificati –  tabella Tipi Codici Cittadino
		 * Valore di default: CF
		 * Obbligatorietà - SI 
		 */		
		public var tipoIdCittadino:String = "CF";
		/**
		 * Cognome del cittadino. 
		 * Stringa alfanumerica di lunghezza massima 50 caratteri.
		 * Obbligatorietà - SI
		 */		
		public var cognomeCittadino:String;
		/**
		 * Nome del cittadino. 
		 * Stringa alfanumerica di lunghezza massima 50 caratteri.
		 * Obbligatorietà - SI
		 */		
		public var nomeCittadino:String;
		/**
		 * Sesso del cittadino 
		 * Stringa alfanumerica di lunghezza 1. Valori ammessi: ‘F’,’ M’.
		 * Obbligatorietà - SI
		 */		
		public var sessoCittadino:String;
		/**
		 * Data di nascita del cittadino 
		 * Stringa alfanumerica di lunghezza 8. Formato YYYYMMDD.
		 * Obbligatorietà - SI
		 */		
		public var dataNascitaCittadino:String;
		/**
		 * Codice ISTAT del comune di nascita del cittadino
		 * Stringa alfanumerica di lunghezza 6 caratteri. Può corrispondere a:
		 * Codice ISTAT nel caso di comuni italiani 
		 * ‘999’ + codice ISTAT dello stato estero (lunghezza 3)
		 * Obbligatorietà - SI
		 */		
		public var idComuneNascitaCittadino:String;
		/**
		 * Identificativo del set documentale del DCE. In caso di documento registrato con il SEB CRM corrisponde all’URI.
		 * Stringa alfanumerica.
		 * Obbligatorietà - SI
		 */		
		public var idSetDocumenti:String;
		/**
		 * Codice identificativo della patologia a cui è associata il percorso Diagnostico Terapeutico
		 * Stringa alfanumerica di lunghezza massima 5 caratteri.
		 * Valori ammessi: vedi allegato 1 (Dati codificati – tabella Codici Patologie PDT).
		 * Obbligatorietà - SI
		 */		
		public var codicePDT:String;
		/**
		 * Definizione:		Codice identificativo del Folder (cartella)
		 * Vincoli:			Stringa alfanumerica restituita dal servizio consulta Fascicolo
		 * Obbligatorietà:	SI
		 */	
		public var idFolder:String;
		/**
		 * Definizione:		Codice identificativo della tipologia di  folder (cartella)
		 * Vincoli:			Stringa alfanumerica restituita dal servizio consulta Fascicolo
		 * Obbligatorietà:	SI
		 */		 	
		public var idTipoFolder:String;	
		
		public function VoInputCopiaDCEInPDT()
		{
			super();
		}
		
	}
}