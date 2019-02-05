package it.lisit.siss.flex.communication.fse.voConsultaFascicolo
{	
	/**
	 * 
	 * @author Marco Salonia
	 * 
	 */	
	public class VoAFClassificazioneCittadino extends VoAttributiFolder
	{
		/**
		 * Data di erogazione della vaccinazione
		 * Formato YYYYMMDD
		 * Obbligatorietà - SI 
		 */		
		public var dataElaborazione:String;
		/**
		 * Struttura contenente l’elenco delle categorie in base alle quali viene calcolata la classificazione del cittadino
		 * Obbligatorietà - SI 
		 */		
		public var elencoCategorie:VoElencoCategorie;
		
		public function VoAFClassificazioneCittadino()
		{
			super();
		}
		override public function get type():int
		{
			return ConstTipiAttributiFolder.ATTRIBUTI_CLASSIFICAZIONE_CITT;
		}
	}
}