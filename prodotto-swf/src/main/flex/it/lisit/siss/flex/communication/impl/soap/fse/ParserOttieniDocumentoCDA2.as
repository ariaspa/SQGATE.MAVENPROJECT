package it.lisit.siss.flex.communication.impl.soap.fse
{
	import it.lisit.siss.flex.communication.fse.voOttieniDocumentoCDA2.VoOutputOttieniDocumentoCDA2;
	
	internal class ParserOttieniDocumentoCDA2
	{
		private var _body:XML;
		public function ParserOttieniDocumentoCDA2(body:XML)
		{
			this._body = body;
		}

		public function execute():VoOutputOttieniDocumentoCDA2 {
			return new VoOutputOttieniDocumentoCDA2Impl(_body);
		}
		
	}
}
	import it.lisit.siss.flex.communication.fse.voOttieniDocumentoCDA2.VoOutputOttieniDocumentoCDA2;
	
	
	
class VoOutputOttieniDocumentoCDA2Impl extends VoOutputOttieniDocumentoCDA2 {
	
	public function VoOutputOttieniDocumentoCDA2Impl(body:XML) {
		super();
		var listEsito:XMLList = body.child("esitoOttieniDocumento");
		if (listEsito != null && listEsito.length() > 0) {
			this.esito = listEsito[0].child( "esito" );
		}
		
	}
}