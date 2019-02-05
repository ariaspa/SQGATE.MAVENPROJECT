package it.lisit.siss.flex.communication.fse.voConsultaFascicolo
{
	/**
	 * 
	 * @author Marco Salonia
	 * 
	 */	
	public class VoAFVaccinazioni extends VoAttributiFolder
	{
		/**
		 * Struttura contenente i dati relativi alla struttura di erogazione dell’evento. 
		 */		
		public var strutturaErogazione:VoStrutturaErogazioneVaccinazioni;
		/**
		 * Struttura contenente l’elenco delle patologie relative alle vaccinazioni
		 * Obbligatorietà - SI
		 */		
		public var elencoPatologie:VoElencoPatologie;
		  
		public function VoAFVaccinazioni()
		{
			super();
		}
		override public function get type():int
		{
			return ConstTipiAttributiFolder.ATTRIBUTI_VACCINAZIONI;
		}
	}
}