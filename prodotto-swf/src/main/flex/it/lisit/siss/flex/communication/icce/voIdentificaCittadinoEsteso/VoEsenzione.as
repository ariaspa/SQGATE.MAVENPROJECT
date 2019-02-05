package it.lisit.siss.flex.communication.icce.voIdentificaCittadinoEsteso
{
	import it.lisit.siss.flex.communication.ClonableValueObject;

	public class VoEsenzione extends ClonableValueObject
	{
		public var codiceEsenzione:String;
		public var decorrenzaEsenzione:String;
		public var scadenzaEsenzione:String;
		public function VoEsenzione()
		{
			super();
		}
		override public function clone():ClonableValueObject
		{
			var cl:VoEsenzione 		= new VoEsenzione();
			cl.codiceEsenzione		= this.codiceEsenzione;
			cl.decorrenzaEsenzione	= this.decorrenzaEsenzione;
			cl.scadenzaEsenzione	= this.scadenzaEsenzione;
			return cl;
		}
	}
}