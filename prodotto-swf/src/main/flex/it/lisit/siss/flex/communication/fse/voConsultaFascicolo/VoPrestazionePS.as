package it.lisit.siss.flex.communication.fse.voConsultaFascicolo
{
	import it.lisit.siss.flex.communication.ClonableValueObject;

	public class VoPrestazionePS extends ClonableValueObject
	{
		/**
		 * Codifica SISS della prestazione specialistica associata 
		 * Valori ammessi: vedi allegato 1 (Dati codificati – tabella Prestazioni).
		 * Obbligatorietà - SI
		 */		
		public var idPrestazioneSISS:String;
		/**
		 * Descrizione della prestazione specialistica associata 
		 * Valori ammessi: vedi allegato 1 (Dati codificati – tabella Prestazioni).
		 * Obbligatorietà - SI
		 */		
		public var descrizionePrestazioneSISS:String;
		/**
		 * Quantità erogata relativamente alla prestazione specificata 
		 * Valori ammessi:  stringa numerica.
		 * Obbligatorietà - SI 
		 */		
		public var quantitaErogata:String;
		 
		public function VoPrestazionePS()
		{
			super();
		}
		
	}
}