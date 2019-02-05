package it.lisit.siss.flex.communication.impl.soap.util
{
	import it.lisit.siss.flex.communication.sa.VoInterrogaAscoltatori.VoOutputInterrogaAscoltatori;
	import it.lisit.siss.flex.communication.util.voCreaStrutturato.VoOutputCreaStrutturato;
	
	internal class ParserContentVisualizerPlugin
	{	
		private var _body:XML;
		public function ParserContentVisualizerPlugin(body:XML) {
			_body = body;
		}
		public function execute():VoOutputCreaStrutturato {
			return new VoOutputCreaStrutturatoImpl(_body);
		}
		
	}
}
	import mx.controls.Alert;
	import it.lisit.siss.flex.communication.util.voCreaStrutturato.VoOutputCreaStrutturato;
	
	

class VoOutputCreaStrutturatoImpl extends VoOutputCreaStrutturato {
	
	public function VoOutputCreaStrutturatoImpl(body:XML) {
		super();
		this.esito = body.child("esito");
		this.nomeFile = body.child("nomeFile");
	}
}