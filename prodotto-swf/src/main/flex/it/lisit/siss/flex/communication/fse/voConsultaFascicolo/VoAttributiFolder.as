package it.lisit.siss.flex.communication.fse.voConsultaFascicolo
{
	import it.lisit.siss.flex.communication.ClonableValueObject;
	/**
	 * 
	 * @author Marco Salonia
	 * @see ConstTipiAttributiFolder
	 */	
	public class VoAttributiFolder extends ClonableValueObject
	{
		/**
		 * Indica il tipo di attributi specifici folder  
		 * Se restituisce -1, allora non è un tipo non caratterizzato 
		 */	
		public function get type():int
		{
			return -1;
		}
		public function VoAttributiFolder()
		{
			super();
		}
		override public function clone():ClonableValueObject
		{
			return new VoAttributiFolder();
		}
	}
}