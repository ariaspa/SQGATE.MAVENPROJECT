package it.lisit.siss.flex.communication.fse.voConsultaFascicolo
{
	public class VoADCELDimissione extends VoAttributiSpecificiDCE
	{
		/**
		 *Codice del presidio ospedaliero. 
		 * Stringa alfanumerica di lunghezza 8 caratteri.
		 * Obbligatorietà - SI 
		 */		
		public var idPresidio:String;
		/**
		 * 
		 */		
		public var descrizionePresidio:String;
		/**
		 * Numero nosologico del ricovero a cui la lettera di dimissione fa riferimento.
		 * Stringa alfanumerica di lunghezza 10 caratteri nel formato AAAANNNNNN dove AAAA è l’anno e NNNNNN è un numero progressivo (tale numero deve essere sempre costituito
		 * da 6 cifre, utilizzare eventualmente un numero opportuno di zeri a sinistra per completarlo)
		 * Obbligatorietà - SI 
		 */		
		public var numeroNosologico:String;
		/**
		 * Codice identificativo univoco della prescrizione (IUP) di ricovero.
		 * Stringa alfanumerica di lunghezza 10 caratteri.
		 * Obbligatorietà - NO
		 * Quando non presente il valore è a null;
		 */		
		public var IUP:String = null;
		/**
		 * Data di nascita del neonato 
		 * Stringa alfanumerica di lunghezza 8. Formato YYYYMMDD.
		 * Obbligatorietà - NO
		 * Quando non presente il valore è a null;
		 */		
		public var dataNascitaNeonato:String = null;
		/**
		 * Data in cui è stata effettuata l’accettazione di ricovero dell’assistito.
		 * Data valida formalmente
		 * Lunghezza minima 12 e  massima 14 caratteri
		 * Formato data ammesso  'YYYYMMDDHH24MM[SS]'
		 * In caso di assenza di secondi è da interpretare come valore ‘00’
		 * Obbligatorietà - SI 
		 */		
		public var dataOraAccettazione:String;
		public function VoADCELDimissione()
		{
			super();
		}
		override public function get type():int
		{
			return ConstTipiAttributiDCE.ATTRIBUTI_LDIMISSIONE;
		}
	}
}