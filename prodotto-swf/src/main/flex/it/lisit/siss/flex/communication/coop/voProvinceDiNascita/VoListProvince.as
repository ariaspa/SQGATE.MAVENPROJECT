package it.lisit.siss.flex.communication.coop.voProvinceDiNascita
{
	import it.lisit.siss.flex.communication.ClonableValueObject;
	import it.lisit.siss.flex.utility.IIterator;

	public class VoListProvince extends ClonableValueObject
	{
		public var iterator:IIterator;
		public function VoListProvince()
		{
			super();
		}
		virtual public function toArray():Array
		{
			return new Array();
		}
	}
}