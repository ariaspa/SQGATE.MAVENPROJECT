package it.lisit.siss.flex.communication.coop.voLeggiCredenziali
{
	import it.lisit.siss.flex.communication.ClonableValueObject;

	public class VoValidity extends ClonableValueObject
	{
		public var emittedDate:String; 
		public var elapsedTime:String; 
		public var sessionMaxTime:String; 
		public function VoValidity()
		{
			super();
		}
	}
}