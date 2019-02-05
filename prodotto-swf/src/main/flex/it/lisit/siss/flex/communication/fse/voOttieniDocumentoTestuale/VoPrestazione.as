package it.lisit.siss.flex.communication.fse.voOttieniDocumentoTestuale
{
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoPrestazione;

	public class VoPrestazione extends it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoPrestazione
	{
		/**
		 * Codice identificativo univoco della prescrizione (IUP) a cui appartiene la prestazione associata al referto specialistico.
		 * Stringa alfanumerica di lunghezza 10 caratteri.
		 * Obbligatorietà - NO. Diventa obbligatorio in alternativa al numero Nosologico e  numeroPraticaPS.
		 */		
		public var IUP:String = null;
		
		/**
		 * Numero di erogazioni per la prestazione associata al referto specialistico
		 * Stringa alfanumerica di lunghezza massima 3 caratteri
		 * Se non specificato, il valore viene automaticamente impostato a 1.
		 * Obbligatorietà - NO
		 */		
		public var quantitaErogata:String = "1";
		
		public function VoPrestazione()
		{
			super();
		}
		
	}
}