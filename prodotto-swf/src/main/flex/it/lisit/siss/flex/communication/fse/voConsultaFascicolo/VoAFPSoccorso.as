package it.lisit.siss.flex.communication.fse.voConsultaFascicolo
{
	/**
	 * 
	 * @author Marco Salonia
	 * 
	 */	
	public class VoAFPSoccorso extends VoAttributiFolder
	{
		/**
		 * Struttura contenente i dati relativi alla struttura di erogazione dell’evento. 
		 * Obbligatorietà - SI
		 */		
		public var strutturaErogazione:VoStrutturaErogazione;
		/**
		 * Identificativo dell’accesso di Pronto Soccorso 
		 * Si tratta di una stringa alfanumerica di lunghezza massima uguale a 20 caratteri.
		 * Obbligatorietà - SI
		 */		
		public var numeroPraticaPS:String;
		/**
		 * Data ed ora di accettazione in pronto soccorso. 
		 * Data valida formalmente
		 * Lunghezza di 14 caratteri
		 * Formato data ammesso  'YYYYMMDDHH24MMSS'
		 * Obbligatorietà - SI
		 */		
		public var dataOraIngresso:String;
		/**
		 * Struttura relativaad i dati di accettazione in pronto soccorso
		 * Obbligatorietà - SI se il campo idTipoComunicazione 
		 * specifica il valore “A” (accettazione) oppure “X” (accettazione e Dimissione).
		 */		
		public var datiAccettazione:VoAccettazionePSoccorso;
		/**
		 * Struttura relativa ai dati di Dimissione/dimissione di un accesso di pronto soccorso.
		 * Obbligatorietà - SI
		 */		
		public var datiDimissione:VoDimissionePS;
		public function VoAFPSoccorso()
		{
			super();
		}
		override public function get type():int
		{
			return ConstTipiAttributiFolder.ATTRIBUTI_PS;
		}
	}
}