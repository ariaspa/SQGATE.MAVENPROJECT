package it.lisit.siss.flex.communication.event
{
	import it.lisit.siss.flex.communication.ValueObject;
	import it.lisit.siss.flex.utility.IIterator;
	/**
	 * Una lista di eccezioni da associare alla risposta positiva 
	 * o per definire i dettagli dell’errore di una risposta negativa
	 * Se utilizzato nell’ambito di una risposta positiva integra gli elementi 
	 * di risposta positiva del “documento applicativo”  , sempre presenti.
	 * Se utilizzato nell’ambito di una risposta negativa 
	 * definisce i dettagli dell’eccezione sollevata.
	 * Obbligatorio
	 * Può essere presente sia nel caso negativo, che nel caso positivo
	 * Almeno un eccezione sarà presente se getLenght() è maggiore di 0
	 */	
	public class VoListaEccezioni extends ValueObject
	{
		public var iterator:IIterator;
		public function VoListaEccezioni()
		{
			super();
		}
		/**
		 * il numero di eccezioni presenti 
		 * @return 
		 * 
		 */		
		public function getLength():uint
		{
			return 0;
		}
		/**
		 * l'eccezione presente al dato indice
		 * @param index
		 * @return 
		 * 
		 */				
		public function getEccezione(index:uint):VoEccezione
		{
			return null;
		}
	}
}