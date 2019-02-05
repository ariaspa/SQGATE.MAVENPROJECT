package it.lisit.siss.flex.communication.fse.voOttieniIndiceFascicolo
{
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoAFPreRicovero;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoStrutturaErogazione;

	public class VoIFAFPreRicovero extends VoAFPreRicovero
	{
		/**
		 * Definizione:		Struttura contenente i dati dell’ente erogatore
		 * Obbligatorietà:	SI
		 */		
		public var strutturaErogazione:VoStrutturaErogazione
		
		/**
		 * Definizione:		Data di nascita del neonato 
		 * Vincoli:			Stringa alfanumerica di lunghezza 8. Formato YYYYMMDD.
		 * Obbligatorietà:	SI
		 */		
		public var dataNascitaNeonato:String;
		
		/**
		 * Definizione:		Struttura contenente i dati del prericovero
		 * Obbligatorietà:	SI
		 */		
		public var datiPrericovero:VoDatiPrericovero;
		 
		public function VoIFAFPreRicovero()
		{
			super();
		}
		
	}
}