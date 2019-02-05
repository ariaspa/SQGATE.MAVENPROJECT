package it.lisit.siss.flex.communication
{
	import it.lisit.siss.flex.communication.exception.SebException;
	
	/**
	 * Assicura la clonabilità del ValueObject
	 * @author Marco Salonia
	 * 
	 */	
	public class ClonableValueObject extends ValueObject
	{
		public function ClonableValueObject()
		{
			super();
		}
		virtual public function clone():ClonableValueObject
		{
			throw new SebException("Virtual method",SebException.IMPL_ERROR);
		}
	}
}