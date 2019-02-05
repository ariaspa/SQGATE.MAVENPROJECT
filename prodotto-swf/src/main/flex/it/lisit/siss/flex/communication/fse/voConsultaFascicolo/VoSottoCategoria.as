package it.lisit.siss.flex.communication.fse.voConsultaFascicolo
{
	import it.lisit.siss.flex.communication.ClonableValueObject;

	public class VoSottoCategoria extends ClonableValueObject
	{
		/**
		 * Codifica regionale della sottocategoria con cui viene calcolata la categoria. 
		 * Stringa alfanumerica.
		 * Valori ammessi: vedi allegato 1 (Dati codificati –  tabella Codici Categorie Sottocategorie Patologie).
		 * Obbligatorietà - SI
		 */		
		public var idSottoCategoria:String;
		/**
		 * Descrizione associata al codice della sottocategoria.
		 * Stringa alfanumerica.
		 * Obbligatorietà - SI
		 */		
		public var descrizioneSottoCategoria:String;
		public function VoSottoCategoria()
		{
			super();
		}
		
	}
}