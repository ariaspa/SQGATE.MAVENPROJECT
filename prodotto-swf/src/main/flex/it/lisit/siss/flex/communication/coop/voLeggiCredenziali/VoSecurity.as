package it.lisit.siss.flex.communication.coop.voLeggiCredenziali
{
	import it.lisit.siss.flex.communication.ClonableValueObject;

	public class VoSecurity extends ClonableValueObject
	{
		public var credential:VoCredentialSecurity
		public function VoSecurity()
		{
			super();
		}
		override public function clone():ClonableValueObject
		{
			var clone:VoSecurity = new VoSecurity();
			if(this.credential!=null)
			{
				clone.credential = this.credential.clone() as VoCredentialSecurity;
			}
			return clone;
		}
	}
}