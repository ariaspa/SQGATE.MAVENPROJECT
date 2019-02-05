package it.lisit.siss.flex.communication.coop.voLeggiCredenziali
{
	import it.lisit.siss.flex.communication.ClonableValueObject;

	public class VoCredential extends ClonableValueObject
	{
		public var coop:VoCoop;
		public var security:VoSecurity;
		public function VoCredential()
		{
			super();
		}
		
	}
}