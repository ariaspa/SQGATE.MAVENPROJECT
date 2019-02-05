package it.lisit.siss.flex.communication.coop.voLeggiCredenziali
{
	import it.lisit.siss.flex.communication.ClonableValueObject;

	public class VoVrs extends ClonableValueObject
	{
		public var mjr:String;
		public var min:String;
		public function VoVrs()
		{
			super();
		}
		override public function clone():ClonableValueObject
		{
			var clone:VoVrs = new VoVrs();
			clone.min		= this.min;
			clone.mjr		= this.mjr;
			return clone;
		}
	}
}