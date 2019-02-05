package it.lisit.siss.flex.communication.impl.soap.fse
{
	import it.lisit.siss.flex.communication.fse.voOttieniDocumentoTestuale.VoOutputOttieniDocumentoTestuale;
	
	internal class ParserOttieniDocumentoTestuale
	{
		private var _body:XML;
		public function ParserOttieniDocumentoTestuale(body:XML)
		{
			this._body = body;
		}

		public function execute():VoOutputOttieniDocumentoTestuale {
			return new VoOutputOttieniDocumentoTestualeImpl(_body);
		}
		
	}
}
	import it.lisit.siss.flex.communication.fse.voOttieniDocumentoTestuale.VoOutputOttieniDocumentoTestuale;
	
	
class VoOutputOttieniDocumentoTestualeImpl extends VoOutputOttieniDocumentoTestuale {
	
	public function VoOutputOttieniDocumentoTestualeImpl(body:XML) {
		super();
		var listEsito:XMLList = body.child("esitoOttieniDocumento");
		if (listEsito != null && listEsito.length() > 0) {
			this.esito = listEsito[0].child( "esito" );
		}
		
	}
}