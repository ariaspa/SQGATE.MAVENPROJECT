package it.lisit.siss.flex.communication.fse.voConsultaFascicolo
{
	public class VoAFFarmaci extends VoAttributiFolder
	{
		/**
		 * Struttura contenente i dati relativi alla struttura di erogazione dell’evento.
		 * Obbligatorietà - SI
		 */		
		public var strutturaErogazione:VoStrutturaErogazioneFarmaci;
		/**
		 * Identificativo della prescrizione SISS della prescrizione farmaceutica 
		 * Si tratta di una stringa alfanumerica di lunghezza uguale a 10 caratteri.
		 * Obbligatorietà - SI
		 */		
		public var IUP:String;
		/**
		 * Data di erogazione dei farmaci
		 * Formato YYYYMMDD
		 * Obbligatorietà - SI
		 */		
		public var dataErogazione:String;
		/**
		 * Struttura contenente l’elenco dei farmaci erogati
		 * Obbligatorietà - SI
		 */		
		public var elencoFarmaciErogati:VoElencoFarmaciErogati;
		
		public function VoAFFarmaci()
		{
			super();
		}
		override public function get type():int
		{
			return ConstTipiAttributiFolder.ATTRIBUTI_FARMACI;
		}
	}
}