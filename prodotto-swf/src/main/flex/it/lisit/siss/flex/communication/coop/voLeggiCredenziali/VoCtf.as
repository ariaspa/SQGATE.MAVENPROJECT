package it.lisit.siss.flex.communication.coop.voLeggiCredenziali
{
	import it.lisit.siss.flex.communication.ClonableValueObject;
	public class VoCtf extends ClonableValueObject
	{
		public var reg:VoItem;
		public var app:VoItem;
		public var pro:VoItem;
		public var str:VoItem;
		public var ter:VoItem;
		public function VoCtf()
		{
			super();
		}
		override public function clone():ClonableValueObject
		{
			var cl:VoCtf = new VoCtf();
			if(this.app!=null)
				cl.app = this.app.clone() as VoItem;
			if(this.pro!=null)
				cl.pro = this.pro.clone() as VoItem;
			if(this.reg!=null)
				cl.reg = this.reg.clone() as VoItem;
			if(this.str!=null)
				cl.str	= this.str.clone() as VoItem;
			if(this.ter !=null)
				cl.ter = this.ter.clone() as VoItem;
			return cl;		
		}
	}
}



















