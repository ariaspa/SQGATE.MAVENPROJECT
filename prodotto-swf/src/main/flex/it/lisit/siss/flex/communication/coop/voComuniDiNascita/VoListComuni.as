package it.lisit.siss.flex.communication.coop.voComuniDiNascita
{
	import it.lisit.siss.flex.communication.ClonableValueObject;
	import it.lisit.siss.flex.utility.IIterator;

	public class VoListComuni extends ClonableValueObject
	{
		public var iterator:IIterator;
		public function VoListComuni()
		{
			super();
		}
		virtual public function toArray():Array
		{
			return new Array();
		}
	}
}