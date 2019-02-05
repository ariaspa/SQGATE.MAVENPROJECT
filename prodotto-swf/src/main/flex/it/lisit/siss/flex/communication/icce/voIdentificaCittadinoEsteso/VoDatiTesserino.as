package it.lisit.siss.flex.communication.icce.voIdentificaCittadinoEsteso
{
	import it.lisit.siss.flex.communication.ClonableValueObject;

	public class VoDatiTesserino extends ClonableValueObject
	{
		public var codiceTesserino:String;
		public var dataAssegnazioneTesserino:String;
		public function VoDatiTesserino()
		{
			super();
		}
		override public function clone():ClonableValueObject
		{
			var cl:VoDatiTesserino 			= new VoDatiTesserino();
			cl.codiceTesserino				= this.codiceTesserino;
			cl.dataAssegnazioneTesserino	= this.dataAssegnazioneTesserino;
			return cl;
		}
	}
}