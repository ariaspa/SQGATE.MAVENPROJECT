package it.lisit.siss.flex.communication.fse.voConsultaFascicolo
{
	import it.lisit.siss.flex.communication.ClonableValueObject;
	/**
	 * 
	 * @author Marco Salonia
	 * 
	 */	
	public class VoFarmaco extends ClonableValueObject
	{
		/**
		 * Codice ministeriale del farmaco
		 * Stringa alfanumerica di lunghezza massima 20 caratteri.
		 * Obbligatorietà - SI
		 */		
		public var idFarmaco:String;
		/**
		 * Denominazione commerciale del farmaco
		 * Stringa alfanumerica.
		 * Obbligatorietà - SI
		 */		
		public var denominazioneCommercialeFarmaco:String;
		/**
		 * Codice identificativo del principio attivo del farmaco, ovvero classificazione ATC di V livello (classificazione chimica) del farmaco.
		 * Stringa alfanumerica di lunghezza massima 20 caratteri.
		 * Obbligatorietà - SI
		 */		
		public var idPrincipioAttivoFarmaco:String;
		/**
		 * Descrizione del principio attivo del farmaco
		 * Stringa alfanumerica.
		 * Obbligatorietà - SI
		 */		
		public var descrizionePrincipioAttivoFarmaco:String;
		/**
		 * Codice identificativo della classe terapeutica del farmaco
		 * Stringa alfanumerica di lunghezza massima 20 caratteri.
		 * Obbligatorietà - SI
		 */		
		public var idClasseTerapeuticaFarmaco:String;
		/**
		 * Descrizione della classe terapeutica
		 * Stringa alfanumerica di lunghezza massima 20 caratteri.
		 * Obbligatorietà - SI
		 */		
		public var descrizioneClasseTerapeuticaFarmaco:String;
		/**
		 * Numero quantità confezioni per farmaco erogato
		 * Stringa numerica
		 * Obbligatorietà - SI
		 */		
		public var quantitaConfezioni:String;
		
		
		//////////////////////////////////////
		public var unitaMisura:String;
		
		public function VoFarmaco()
		{
			super();
		}
		
	}
}