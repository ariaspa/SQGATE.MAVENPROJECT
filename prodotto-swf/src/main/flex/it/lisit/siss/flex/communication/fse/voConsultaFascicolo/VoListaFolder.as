package it.lisit.siss.flex.communication.fse.voConsultaFascicolo
{
	import it.lisit.siss.flex.communication.ValueObject;
	import it.lisit.siss.flex.utility.IIterator;
	/**
	 * Struttura dati contenente la struttura dei folder che costituiscono il fascicolo o parte di esso e relativo al cittadino specificato
	 * @author Marco Salonia
	 * 
	 */	
	public class VoListaFolder extends ValueObject 
	{
		public function VoListaFolder()
		{
			super();
		}
		/**
		 * Fornisce un iteratore per scorrere la struttura dati
		 * A differenza del metodo toArray() 
		 * i dati non vengono clonati e si riferiscono sempre agli originali   
		 * proprietà di sola lettura
		 * 
		 */		
		public function get iterator():IIterator
		{
			return null;
		}
	}
}