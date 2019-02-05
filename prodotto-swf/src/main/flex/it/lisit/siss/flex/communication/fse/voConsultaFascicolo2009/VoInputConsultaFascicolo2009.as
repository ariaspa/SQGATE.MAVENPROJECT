package it.lisit.siss.flex.communication.fse.voConsultaFascicolo2009
{
	import it.lisit.siss.flex.communication.ClonableValueObject;
	import it.lisit.siss.flex.communication.ValueObject;
	

	public class VoInputConsultaFascicolo2009 extends ValueObject
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
		 * Identificativo del Folder contenente i DCE da consultare
		 * Stringa alfanumerica
		 * Obbligatorietà NO
		 * Quando non presente ha valore null
		 */		
		public var idFolder:String;
		/**
		 * Identificativo della tipologia dei folder
		 * Stringa alfanumerica di lunghezza 2 
		 * Valori ammessi: vedi allegato 1 Dati codificati –  tabella Tipi Folder 
		 * Obbligatorietà NO
		 */		
		public var idTipoFolder:String;
		/**
		 *  Struttura contenente la lista dei codici delle reti di patologia a cui sono associati i DCE da consultare 
		 *  E' un array che contiene ad ogni indice una stringa 
		 *  che rappresenta la codifica della rete di patologia dalla quale sono stati prodotti i DCE da consultare
		 *  Stringa alfanumerica di lunghezza massima di 10 caratteri.
		 *  Obbligatorietà NO
		 */		
		public var listaRetiPatologia:Array;
		/**
		 * Numero massimo di record che il servizio deve restituire per ogni pagina  
		 * Di default è a -1, se non specificato assume un valore di default definito all’interno del DC (servizio).
		 * Obbligatorietà NO
		 */		
		public var nMaxRecord:int = -1;
		/**
		 * Numero della pagina richiesta.
		 * Se non specificato (o valorizzato a zero) assume il valore di default uguale a 1.
		 * Obbligatorietà NO
		 */		
		public var nPagina:uint = 1;
		public function VoInputConsultaFascicolo2009()
		{
		}
	}
}