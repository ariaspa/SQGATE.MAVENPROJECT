package it.lisit.siss.flex.communication.fse.voConsultaFascicolo
{
	public class VoADCEPSoccorso extends VoAttributiSpecificiDCE
	{
		/**
		 * Codice del presidio ospedaliero. 
		 * Stringa alfanumerica di lunghezza 8 caratteri.
		 * Obbligatorietà - SI
		 */		
		public var idPresidio:String;
		/**
		 * 
		 */		
		public var descrizionePresidio:String;
		/**
		 * Numero della pratica nei casi di pronto soccorso
		 * Stringa alfanumerica di lunghezza massima di 20 caratteri.
		 * Obbligatorietà - SI
		 */		
		public var numeroPraticaPS:String;
		/**
		 * Data e ora in cui è stata effettuata l’accettazione dell’assistito in pronto soccorso
		 * Data valida formalmente
		 * Lunghezza minima 12 e  massima 14 caratteri
		 * Formato data ammesso  'YYYYMMDDHH24MM[SS]'
		 * In caso di assenza di secondi è da interpretare come valore ‘00’
		 * Obbligatorietà - SI
		 */		
		public var dataOraAccettazione:String;
		public function VoADCEPSoccorso()
		{
			super();
		}
		override public function get type():int
		{
			return ConstTipiAttributiDCE.ATTRIBUTI_PSOCCORSO;
		}
	}
}