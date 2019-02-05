package it.lisit.siss.flex.communication.fse.voConsultaEventiDaFlussi
{
	import it.lisit.siss.flex.communication.ValueObject;

	public class VoInputConsultaEventiDaFlussi extends ValueObject
	{
		/**
		 *Codice cittadino cui il Fascicolo è riferito. Il tipo di codice è specificato nella proprerty “tipoIdCittadino”
		 * Stringa alfanumerica di lunghezza massima 20.
		 * I valori ammessi dipendono dal tipo di codice specificato in “tipoIdCittadino”.
		 * Nel caso di codice fiscale:
		 * Formato ammesso nel caso di codice fiscale: AAAAAANNANNANNNA 
		 * (tranne nel caso di omocodia).
		 * Ammesse solo maiuscole. 
		 */		
		public var idCittadino:String;
		/**
		 * 
		 */		
		public var tipoIdCittadino:String = "CF";
		public var idTipoEvento:String;
		/**
		 * E' la data di erogazione minima (limite inferiore) da considerare nell’estrazione degli eventi.
		 * Formato: YYYYMMDD
		 * Quando non specificata viene valorizzata con un valore di default.
		 */		
		public var dataInizio:String;
		/**
		 * E' la data di erogazione massima (limite superiore) da considerare nell’estrazione degli eventi. 
		 * Formato: YYYYMMDD
		 * Quando non specificata viene assunta coincidente con la data odierna
		 */		
		public var dataFine:String;
		public var nMaxRecord:String;
		public var nPagina:uint = 0;
		public function VoInputConsultaEventiDaFlussi()
		{
			super();
		}
		
	}
}

 