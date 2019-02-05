package it.lisit.siss.flex.communication.coop.voProvinceDiNascita
{
	import it.lisit.siss.flex.communication.ClonableValueObject;

	public class VoProvincia extends ClonableValueObject
	{
		public var COD_PROV:String;
		public var DESC_DPROV:String;
		public function VoProvincia()
		{
			super();
		}
		override public function clone():ClonableValueObject
		{
			var cl:VoProvincia 	= new VoProvincia();
			cl.COD_PROV			= this.COD_PROV;
			cl.DESC_DPROV		= this.DESC_DPROV;
			return cl;
		}
	}
}