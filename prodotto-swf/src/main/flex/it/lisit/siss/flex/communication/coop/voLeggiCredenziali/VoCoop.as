package it.lisit.siss.flex.communication.coop.voLeggiCredenziali
{
	import it.lisit.siss.flex.communication.ClonableValueObject;

	public class VoCoop extends ClonableValueObject
	{
		public var cit_auth:String;
		public var operator_logged:String;
		public var pdc_present:String;
		public var value:String;
		public function VoCoop()
		{
			super();
		}
		
	}
}