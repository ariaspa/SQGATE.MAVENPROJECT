package it.lisit.siss.flex.communication.fse.voConsultaStoricoDCE
{
	import it.lisit.siss.flex.communication.ValueObject;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoListaDCE;

	public class VoConsultaStoricoDCE extends ValueObject
	{
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
		/**
		 * Struttura contenente l’eventuale lista dei DCE (VoSetDocumentale) contenuti nel folder considerato
		 * Se presente conterrà almeno un VoSetDocumentale
		 * Obbligatorietà - NO
		 * Quando non presente assume il valore di null
		 */		
		public var listaDCE:VoListaDCE = null;
		
		public function VoConsultaStoricoDCE()
		{
			super();
		}
		
	}
}