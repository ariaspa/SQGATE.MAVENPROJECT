package it.lisit.siss.flex.communication.coop.voComuniDiNascita
{
	import it.lisit.siss.flex.communication.ClonableValueObject;

	public class VoComune extends ClonableValueObject
	{
		public var COD_CCOMU:String;
		public var DESC_DCOMU:String;
		public function VoComune()
		{
			super();
		}
		override public function clone():ClonableValueObject
		{
			var cl:VoComune = new VoComune();
			cl.COD_CCOMU	= this.COD_CCOMU;
			cl.DESC_DCOMU	= this.DESC_DCOMU;
			return cl;
		} 
	}
}