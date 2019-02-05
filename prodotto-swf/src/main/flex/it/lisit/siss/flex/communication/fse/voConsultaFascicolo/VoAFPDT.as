package it.lisit.siss.flex.communication.fse.voConsultaFascicolo
{
	import it.lisit.siss.flex.communication.ClonableValueObject;
	
	public class VoAFPDT extends VoAttributiFolder
	{
		public var dataApertura:String;
		public var dataChiusura:String;
		public var codicePDT:String;
		public var descrizionePDT:String;
		public function VoAFPDT()
		{
			super();
		}
		override public function get type():int
		{
			return ConstTipiAttributiFolder.ATTRIBUTI_PDT;
		}
		override public function clone():ClonableValueObject
		{
			var clone:VoAFPDT 		= new VoAFPDT();
			clone.dataApertura 		= this.dataApertura;
			clone.dataChiusura 		= this.dataChiusura;
			clone.codicePDT 		= this.codicePDT;
			clone.descrizionePDT	= this.descrizionePDT;
			return clone;
		}
	}
}