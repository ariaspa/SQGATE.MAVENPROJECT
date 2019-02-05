package it.lisit.siss.flex.communication.coop.voLeggiCredenziali
{
	import it.lisit.siss.flex.communication.ClonableValueObject;

	public class VoItem extends ClonableValueObject
	{
		public var codice:String;
		public var descrizione:String;
		public function VoItem()
		{
			super();
		}
		override public function clone():ClonableValueObject
		{
			var cl:VoItem = new VoItem();
			cl.codice		= this.codice;
			cl.descrizione	= this.descrizione;
			return cl;
		}
	}
}