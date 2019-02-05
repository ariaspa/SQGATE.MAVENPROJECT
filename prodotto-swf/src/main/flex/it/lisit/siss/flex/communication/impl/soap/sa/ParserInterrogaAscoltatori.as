package it.lisit.siss.flex.communication.impl.soap.sa
{
	import it.lisit.siss.flex.communication.sa.VoInterrogaAscoltatori.VoOutputInterrogaAscoltatori;
	
	internal class ParserInterrogaAscoltatori
	{	
		private var _body:XML;
		public function ParserInterrogaAscoltatori(body:XML) {
			_body = body;
		}
		public function execute():VoOutputInterrogaAscoltatori {
			return new VoOutputInterrogaAscoltatoriImpl(_body);
		}
		
	}
}
	import it.lisit.siss.flex.communication.sa.VoInterrogaAscoltatori.VoOutputInterrogaAscoltatori;
	

class VoOutputInterrogaAscoltatoriImpl extends VoOutputInterrogaAscoltatori {
	
	public function VoOutputInterrogaAscoltatoriImpl(body:XML) {
		super();
		var ris:String = body.child("risultato");
		this.risultato = ris;
		
	}
}