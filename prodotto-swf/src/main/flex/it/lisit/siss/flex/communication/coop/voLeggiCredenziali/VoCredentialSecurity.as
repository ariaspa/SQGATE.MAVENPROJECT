package it.lisit.siss.flex.communication.coop.voLeggiCredenziali
{
	import it.lisit.siss.flex.communication.ClonableValueObject;
	import it.lisit.siss.flex.utility.IIterator;

	public class VoCredentialSecurity extends ClonableValueObject
	{
		public var vrs:VoVrs; 
		public var validity:VoValidity; 
		public var role:VoRole; 
		public var userId:String; 
		public var funContext:String; 
		public var numericFunContext:String; 
		public var ctf:VoCtf; 
		public var attributi:VoIteratorAttributo; 
		public var prv:VoPrv; 
		public var sServices:VoIteratorServices; 
		/////////////////////////////////////
		public function VoCredentialSecurity()
		{
			super();
		}
	}
}