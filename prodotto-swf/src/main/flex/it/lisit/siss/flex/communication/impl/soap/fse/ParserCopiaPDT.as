package it.lisit.siss.flex.communication.impl.soap.fse
{
	import it.lisit.siss.flex.communication.fse.voCopiaDCEInPDT.VoOutputCopiaDCEInPDT;
	
	internal class ParserCopiaPDT
	{
		private var _body:XML
		public function ParserCopiaPDT(body:XML)
		{
			_body = body;
		}
		public function execute():VoOutputCopiaDCEInPDT
		{
			return new VoOutputCopiaDCEInPDTImpl(_body);
		}
	}
}
	import it.lisit.siss.flex.communication.fse.voCopiaDCEInPDT.VoOutputCopiaDCEInPDT;
	
class VoOutputCopiaDCEInPDTImpl extends VoOutputCopiaDCEInPDT
{
	public function VoOutputCopiaDCEInPDTImpl(body:XML)
	{
		super();
		var esit:XMLList = body.child( "esitoCopiaDCEInFolder" );
		if(esit!=null && esit.length()>0)
		{
			this.esitoCopiaDCEInFolder = esit[0].child( "esito" );
		}
	}
}