package it.lisit.siss.flex.communication.coop.voLeggiCredenziali
{
	import it.lisit.siss.flex.communication.ClonableValueObject;

	public class VoService extends ClonableValueObject
	{
		public var code:String;
		public var utContext:String;
		public function VoService()
		{
			super();
		}
	}
}