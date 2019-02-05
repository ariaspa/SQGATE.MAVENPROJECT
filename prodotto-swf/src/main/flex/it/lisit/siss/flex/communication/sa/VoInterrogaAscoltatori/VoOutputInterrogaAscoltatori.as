package it.lisit.siss.flex.communication.sa.VoInterrogaAscoltatori
{
	import it.lisit.siss.flex.communication.ValueObject;

	public class VoOutputInterrogaAscoltatori extends ValueObject
	{
		/**
		 * Contiene true se è presente un ascoltatore per la coppia nomeMetodo / nameSpace
		 * indicati nella richiesta o false per il caso contrario. 
		 */		
		public var risultato:String;
		
		public function VoOutputInterrogaAscoltatori()
		{
			super();
		}
		
	}
}