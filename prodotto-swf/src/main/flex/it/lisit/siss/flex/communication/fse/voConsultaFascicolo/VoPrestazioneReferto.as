package it.lisit.siss.flex.communication.fse.voConsultaFascicolo
{
	import it.lisit.siss.flex.communication.ClonableValueObject;

	public class VoPrestazioneReferto extends ClonableValueObject
	{
		/**
		 * Codifica SISS della prestazione erogata
		 * Stringa alfanumerica di lunghezza 10 caratteri.
		 * Valori ammessi: vedi allegato 1 (Dati codificati – tabella Prestazioni SISS)
		 *  Obbligatorietà - SI	
		 */		
		public var idPrestazioneSISS:String = null;
		/**
		 * 
		 */		
		public var descrizionePrestazioneSISS:String = null;
		/**
		 * Codice identificativo univoco della prescrizione (IUP) a cui appartiene la prestazione associata al referto specialistico.
		 * Stringa alfanumerica di lunghezza 10 caratteri.
		 * Obbligatorietà - NO. Diventa obbligatorio in alternativa al numero Nosologico, numeroPrericovero e  numeroPraticaPS.
		 */		
		public var IUP:String;
		/**
		 * Numero di erogazioni per la prestazione associata al referto specialistico
		 * Stringa alfanumerica di lunghezza massima 3 caratteri
		 * Se non specificato, il valore viene automaticamente impostato a 1.
		 * Obbligatorietà - NO
		 */		
		public var quantitaErogata:String = "1";
		/**
		 * Flag che specifica se trattasi di prestazione aggiunta o no. E’ rilevante nel caso di presenza di IUP
		 * Valori ammessi: “S”=si, “N”=no. Il valore di default è “N”
		 * Obbligatorietà - NO
		 */		
		public var flagAggiuntiva:String = "N";
		
		
		public function VoPrestazioneReferto()
		{
			super();
		}
		
	}
}