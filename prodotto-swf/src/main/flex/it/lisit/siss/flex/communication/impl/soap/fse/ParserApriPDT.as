package it.lisit.siss.flex.communication.impl.soap.fse
{
	import it.lisit.siss.flex.communication.fse.voApriPDT.VoOutputApriPDT;
	
	internal class ParserApriPDT
	{
		private var _body:XML
		public function ParserApriPDT(body:XML)
		{
			_body = body;
		}
		public function execute():VoOutputApriPDT
		{
			return new VoOutputApriPDTImpl( _body );
		}
	}
}
	import it.lisit.siss.flex.communication.fse.voApriPDT.VoOutputApriPDT;
	
class VoOutputApriPDTImpl extends VoOutputApriPDT
{
	public function VoOutputApriPDTImpl(response:XML)
	{
		super();
		var esit:XMLList = response.child( "esitoApriPDT" );
		if(esit!=null && esit.length()>0)
		{
			this.esitoApriPDT = esit[0].child( "esito" );
		}
	}
}