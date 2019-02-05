package it.lisit.siss.flex.communication.fse.voConsultaFascicolo
{
	import it.lisit.siss.flex.communication.ValueObject;
	
	 
	/**
	 * Struttura dati contenente la struttura del fascicolo o parte di esso e relativo al cittadino specificato 
	 * @author Marco  Salonia
	 * 
	 */	
	public class Vofascicolo extends ValueObject
	{
		/**
		 *	Struttura dati contenente la struttura dei folder che costituiscono il fascicolo o parte di esso e relativo al cittadino specificato
		 * 	Obbligatorietà - SI
		 */		
		public var listaFolder:VoListaFolder;
		
		public function Vofascicolo()
		{
			super();
			 
		}
	}
}