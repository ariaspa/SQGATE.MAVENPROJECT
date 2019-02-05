package it.lisit.siss.flex.communication.sa.VoInterrogaAscoltatori
{
	import it.lisit.siss.flex.communication.ValueObject;

	public class VoInputInterrogaAscoltatori extends ValueObject
	{
		/**
		 * Definisce il nome del metodo di cui si richiede la registrazione. 
		 * Non deve contenere indicazioni relative al prefix del namespace 
		 * Esempio: nomeMetodoRegistrato e non m:nomeMetodoRegistrato 
		 * Formato ammesso alfanumerico.
		 * Obbligatorio - Si
		*/		
		public var nomeMetodo:String;
		
		/**
		 * Definisce il namespace del metodo di cui si richiede la registrazione. Non deve contenere
		 * indicazioni relative al prefix.
		 * Esempio: nameSpaceRegistrato e non xmlns:m="nameSpaceRegistrato" 
		 * Formato ammesso alfanumerico.
		 * Obbligatorio - Si
		 */		
		public var nameSpace:String;
		
		public function VoInputInterrogaAscoltatori()
		{
			super();
		}
		
	}
}