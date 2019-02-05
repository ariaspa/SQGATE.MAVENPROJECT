package it.lisit.siss.flex.communication.fse.voAutorizzaDce
{
	import it.lisit.siss.flex.communication.ValueObject;
	import it.lisit.siss.flex.utility.IIterator;

	public class VoInputAutorizzaDce extends ValueObject
	{
		/**
		 * lista delle richieste di autorizzazione 
		 */		
		public var iteratorAutorizzazioni:IIterator
		public function VoInputAutorizzaDce()
		{
			super();
		}
		
	}
}