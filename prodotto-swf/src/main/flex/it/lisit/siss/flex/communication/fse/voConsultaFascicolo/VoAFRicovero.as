package it.lisit.siss.flex.communication.fse.voConsultaFascicolo
{
	public class VoAFRicovero extends VoAttributiFolder
	{
		/**
		 * Struttura contenente i dati relativi alla struttura di erogazione dell’evento.
		 * Obbligatorietà - SI
		 */		
		public var strutturaErogazione:VoStrutturaErogazione;
		/**
		 * Identificativo dell’evento comunicato 
		 * Si tratta di una stringa alfanumericaCorrisponde al codice di ricovero (lunghezza uguale a 10 del formato YYYYNNNNNN).
		 * Obbligatorietà - SI
		 */		
		public var numeroNosologico:String;
		/**
		 * Data di nascita del neonato a cui è riferito l’evento
		 * Stringa alfanumerica di lunghezza 8. Formato YYYYMMDD.
		 * Obbligatorietà - NO
		 * Quando assente è valorizzato a null;
		 */		
		public var dataNascitaNeonato:String = null;
		/**
		 * Data ed ora di accettazione del ricovero. 
		 * Se si tratta di un ricovero in DH questa rappresenta la data del 1° contatto.
		 * Se si tratta di un neonato nato nella struttura tale data coincide con quella di nascita.
		 * Data valida formalmente
		 * Lunghezza di 14 caratteri
		 * Formato data ammesso  'YYYYMMDDHH24MMSS'
		 * Obbligatorietà - SI
		 */		
		public var dataOraRicovero:String;
		/**
		 * Indica il reparto in cui il paziente è fisicamente ricoverato
		 * Stringa alfanumerica di lunghezza massima 6 caratteri.
		 * Obbligatorietà - NO
		 * Quando assente è valorizzato a null;
		 */		
		public var idRepartoRicovero:String;
		/**
		 * Indica la descrizione del reparto in cui il paziente è fisicamente ricoverato
		 * Stringa alfanumerica.
		 * Obbligatorietà - NO
		 * Quando assente è valorizzato a null;
		 */		
		public var descrizioneRepartoRicovero:String;
		/**
		 * Struttura relativa ad i dati di accettazione
		 * Obbligatorietà - NO
		 */		
		public var datiAccettazione:VoAccettazione;
		/**
		 * Struttura relativa ad i dati di accettazione
		 * Obbligatorietà - NO
		 */		
		public var datiDimissione:VoDimissione;
		/**
		 * Struttura relativa ai trasferimenti effettuati nell’ambito del ricovero
		 * Obbligatorietà - NO
		 * Quando assente è valorizzato a null;
		 */		
		public var elencoTrasferimenti:VoElencoTrasferimenti = null;
		public function VoAFRicovero()
		{
			super();
		}
		override public function get type():int
		{
			return ConstTipiAttributiFolder.ATTRIBUTI_RICOVERO;
		}
	}
}