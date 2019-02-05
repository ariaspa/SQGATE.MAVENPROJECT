package it.lisit.siss.flex.communication.fse.voConsultaFascicolo
{
	import it.lisit.siss.flex.communication.ClonableValueObject;
	/**
	 * 
	 * @author Marco Salonia
	 * 
	 */	
	public class VoCategoria extends ClonableValueObject
	{
		/**
		 * Codifica regionale identificativo della categoria relativa alle patologie croniche 
		 * Stringa alfanumerica.
		 * Valori ammessi: vedi allegato 1 (Dati codificati –  tabella Codici Categorie Sottocategorie Patologie).
		 * Obbligatorietà - SI
		 */		
		public var idCategoria:String;
		/**
		 * Descrizione associato al codice della categoria
		 * Stringa alfanumerica.
		 * Obbligatorietà - SI
		 */		
		public var descrizioneCategoria:String;
		/**
		 * Struttura contenente l’elenco delle eventuali sottocategorie associate alla categoria considerata
		 * Obbligatorietà - NO
		 * Quando assente è valorizzato a null
		 */		
		public var elencoSottoCategorie:VoElencoSottoCategorie = null;
		 
		public function VoCategoria()
		{
			super();
		}
		
	}
}