package it.lisit.siss.flex.communication.impl.soap.fse
{
	import it.lisit.siss.flex.communication.fse.voChiudiPDT.VoOutputChiudiPDT;
	
	internal class ParserChiudiPDT
	{
		private var _body:XML
		public function ParserChiudiPDT(body:XML)
		{
			_body = body;
		}
		public function execute():VoOutputChiudiPDT
		{
			return new VoOutputChiudiPDTImpl(_body);
		}
	}
}
	import it.lisit.siss.flex.communication.fse.voChiudiPDT.VoOutputChiudiPDT;
	
class VoOutputChiudiPDTImpl extends VoOutputChiudiPDT
{
	public function VoOutputChiudiPDTImpl(body:XML)
	{
		super();
		var esit:XMLList = body.child( "esitoChiudiPDT" );
		if(esit!=null && esit.length()>0)
		{
			this.esitoChiudiPDT = esit[0].child( "esito" );
		}
	}
}