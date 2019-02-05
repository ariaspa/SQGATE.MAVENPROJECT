package it.lisit.siss.flex.communication.fse.voOttieniIndiceFascicolo
{
	import it.lisit.siss.flex.communication.ValueObject;
	import it.lisit.siss.flex.communication.fse.voAutorizzaDce.VoCittadino;

	public class VoInputOttieniIndiceFascicolo extends ValueObject
	{
		/**
		 *  Codice cittadino cui il Fascicolo è riferito. Il tipo di codice è specificato nella proprerty tipoIdCittadino.
		 *  Stringa alfanumerica di lunghezza massima 20.
		 *	I valori ammessi dipendono dal tipo di codice specificato in tipoIdCittadino.
		 *	Nel caso di codice fiscale:
		 *	Formato ammesso nel caso di codice fiscale: AAAAAANNANNANNNA (tranne nel caso di omocodia).
		 *	Ammesse solo maiuscole.
		 *  Obbligatorietà SI
		 */		
		public var idCittadino:String;
		
		/**  
		 * Tipo di codice cittadino specificato. Nel caso di tipo=’CF’ (valore di default) allora il codice Cittadino  è quello fiscale
		 * Stringa alfanumerica di lunghezza massima di 10 caratteri. 
		 * Valori ammessi: vedi allegato 1 Dati codificati –  tabella Tipi Codici Cittadino
		 * Obbligatorietà SI
		 */		
		public var tipoIdCittadino:String = "CF";
		
		/**
		* Definizione:		Numero massimo di record che il servizio deve restituire per ogni pagina 
		* Vincoli:			Se non specificato assume un valore di default definito all’interno del DC.
		* Obbligatorietà:	NO
		*/		
		public var nMaxRecord:int;
		
		/**
		 * Numero della pagina richiesta.
		 * Se non specificato (o valorizzato a zero) assume il valore di default uguale a 1.
		 * Obbligatorietà NO
		 */		
		public var nPagina:uint = 1;

		
		public function VoInputOttieniIndiceFascicolo()
		{
			super();
		}
		
	}
}