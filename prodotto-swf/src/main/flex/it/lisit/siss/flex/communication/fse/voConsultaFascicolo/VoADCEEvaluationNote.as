package it.lisit.siss.flex.communication.fse.voConsultaFascicolo
{
	public class VoADCEEvaluationNote extends VoAttributiSpecificiDCE
	{
		/**
		 *Codice del presidio ospedaliero. 
		 * Stringa alfanumerica di lunghezza 8 caratteri.
		 * Obbligatorietà - SI
		 */		
		public var idPresidio:String;
		/**
		 * Numero accesso di prericovero a cui l’Evaluation Note fa riferimento.
		 * Stringa alfanumerica di lunghezza 10 caratteri nel formato AAAANNNNNN dove AAAA è l’anno e NNNNNN è un numero progressivo (tale numero deve essere sempre costituito
		 * da 6 cifre, utilizzare eventualmente un numero opportuno di zeri a sinistra per completarlo)
		 * Obbligatorietà - NO. Diventa obbligatorio se non è valorizzato la proprietà <numeroNosologico>
		 */		
		public var numeroPrericovero:String;
		/**
		 * Numero accesso di ricovero a cui l’Evaluation Note fa riferimento.
		 * Stringa alfanumerica di lunghezza 10 caratteri nel formato 
		 * AAAANNNNNN dove AAAA è l’anno e NNNNNN è un numero progressivo (tale numero deve essere sempre costituito
		 * da 6 cifre, utilizzare eventualmente un numero opportuno di zeri a sinistra per completarlo)
		 * Obbligatorietà - NO. Diventa obbligatorio se non è valorizzato la proprietà <numeroPrericovero>
 		 */		
		public var numeroNosologico:String;
		/**
		 * Data di nascita del neonato
		 * Stringa alfanumerica di lunghezza 8. Formato YYYYMMDD.
		 * Obbligatorietà - SI
		 */		
		public var dataNascitaNeonato:String;
		/**
		 * Data e ora in cui è stata effettuato l’accesso in Day Hospital.
		 * Data valida formalmente
		 * Lunghezza minima 12 e  massima 14 caratteri
		 * Formato data ammesso  'YYYYMMDDHH24MM[SS]'
		 * In caso di assenza di secondi è da interpretare come valore ‘00’
		 * Obbligatorietà - SI
		 */		
		public var dataOraIngresso:String;
		/**
		 * 
		 */		
		public var descrizionePresidio:String;
		public function VoADCEEvaluationNote()
		{
			super();
		}
		override public function get type():int
		{
			if (numeroPrericovero == null || numeroPrericovero.length == 0)
				return ConstTipiAttributiDCE.ATTRIBUTI_ENOTE;
			else
				return ConstTipiAttributiDCE.ATTRIBUTI_ENOTE_2009;
		}
	}
}