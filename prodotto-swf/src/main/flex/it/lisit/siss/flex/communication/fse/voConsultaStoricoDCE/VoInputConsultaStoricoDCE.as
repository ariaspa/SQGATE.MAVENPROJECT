package it.lisit.siss.flex.communication.fse.voConsultaStoricoDCE
{
	import it.lisit.siss.flex.communication.ValueObject;

	public class VoInputConsultaStoricoDCE extends ValueObject
	{
		/**
		 *  Definizione:	Codice cittadino cui il Fascicolo è riferito. 
		 * 				Il tipo di codice è specificato nella proprerty “tipo”. 
		 *	Vincoli:		Stringa alfanumerica di lunghezza massima 20.
						I valori ammessi dipendono dal tipo di codice specificato in “tipo”.
						Nel caso di codice fiscale:
						•	Formato ammesso nel caso di codice fiscale: AAAAAANNANNANNNA 
			       		(tranne nel caso di omocodia).
						Ammesse solo maiuscole.
		 *	Obbligatorietà:		SI
		 */	
		public var idCittadino:String;
		
		/**
		 * 	Definizione:	Tipo di codice cittadino specificato. Nel caso di tipo=’CF’ 
		 * 				allora il codice Cittadino  è quello fiscale
			Vincoli:		Stringa alfanumerica di lunghezza massima di 10 caratteri.
			Valori ammessi: 	CF (codice fiscale)
			Obbligatorietà:		SI
		 */	
		public var tipo:String = "CF";
		
		/**
		 * 	Definizione:	Identificativo del set documentale del DCE da consultare
			Vincoli:		Stringa alfanumerica
			Obbligatorietà:	SI
		 */			 	
		public var idSetDocumenti:String;
		
		public function VoInputConsultaStoricoDCE()
		{
			super();
		}
		
	}
}