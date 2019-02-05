package it.lisit.siss.flex.communication.event
{
	import it.lisit.siss.flex.communication.ValueObject;
	import it.lisit.siss.flex.communication.exception.SebException;
	import it.lisit.siss.flex.utility.IIterator;

	public class VoListaWarning extends ValueObject
	{
		public var iterator:IIterator;
		public function VoListaWarning()
		{
			super();
		}
		virtual public function lenght():uint
		{
			 throw new SebException("Virtual method",SebException.IMPL_ERROR); 
		}
		virtual public function getWarning(index:uint):VoWarning
		{
			throw new SebException("Virtual method",SebException.IMPL_ERROR); 
		}
	}
}