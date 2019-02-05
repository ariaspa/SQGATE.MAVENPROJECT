package it.lisit.siss.flex.communication.fse.voOttieniIndiceFascicolo
{
	import it.lisit.siss.flex.communication.ValueObject;

	public class VoDatiPrericovero extends ValueObject
	{
		/**
		 * Definizione:		Identificativo del numero di prericovero
		 * Vincoli:			Si tratta di una stringa alfanumerica di lunghezza uguale a 10 (formato YYYYNNNNNN).
		 * Obbligatorietà:	SI
		 */		
		public var numeroPrericovero:String;
		
		/**
		 * Definizione:	Data e ora di inizio  prericovero
		 * Vincoli:		Data valida formalmente
							Lunghezza di 14 caratteri
							Formato data ammesso  'YYYYMMDDHH24MMSS'
		 * Obbligatorietà:	SI
		 */		
		public var dataOraInizioPrericovero:String;
		 
		/**
		 * Definizione:		Data e ora di fine  prericovero
		 * Vincoli:			Data valida formalmente
								Lunghezza di 14 caratteri
								Formato data ammesso  'YYYYMMDDHH24MMSS'
		 * Obbligatorietà:	SI
		 */		 
		public var dataOraFinePrericovero:String;
		
		/**
		 * Definizione:		Indica il reparto di ingresso programmato per il ricovero
		 * Vincoli:			Stringa alfanumerica di lunghezza massima 6 caratteri.
		 * Obbligatorietà:	NO 
		 */		
		 public var idRepartoRicovero:String;
		 
		 /**
		 * Definizione:		Indica la descrizione del reparto in cui il paziente è fisicamente ricoverato
		 * Vincoli:			Stringa alfanumerica.
		 * Obbligatorietà:	NO
		 * Quando assente è valorizzato a null;
		 */		
		public var descrizioneRepartoRicovero:String; 
		
		/**
		 * Definizione:		Codifica in ICD9-CM della diagnosi di dimissione principale. 
		 * Vincoli:			Si tratta di una stringa alfanumerica di lunghezza 5. Corrisponde alla codifica ICD9-CM della diagnosi.
		 * Obbligatorietà:	NO
		 */		
		public var codiceDiagnosi:String;
		/**
		 * Definizione:		Descrizione della diagnosi di dimissione principale. 
		 * Vincoli:			Si tratta di una stringa alfanumerica.
		 * Obbligatorietà:  NO
		 */		
		public var descrizioneDiagnosi:String;
		/**
		 * Definizione:		Identificativo della prescrizione di ricovero eventualmente richiesta
		 * Vincoli:			Si tratta di una stringa alfanumerica. Corrisponde allo IUP (lunghezza uguale a 10)
		 * Obbligatorietà:	SI se presente
		 */		
		public var iup:String;
		
		public function VoDatiPrericovero()
		{
			super();
		}
		
	}
}