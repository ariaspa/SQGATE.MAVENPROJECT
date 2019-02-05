package it.lisit.siss.flex.communication.icce.voIdentificaCittadinoEsteso
{
	import it.lisit.siss.flex.communication.ValueObject;
	
	public class VoOutputIdentificaCittadinoEsteso2008_01 extends ValueObject
	{
		public var isRispostaSingola:Boolean;
		
		public var rispostaSingola:VoRispostaSingola;

		public var rispostaMultipla:VoRispostaMultipla;
		
		public function VoOutputIdentificaCittadinoEsteso2008_01()
		{
			super();
		}
	}
}