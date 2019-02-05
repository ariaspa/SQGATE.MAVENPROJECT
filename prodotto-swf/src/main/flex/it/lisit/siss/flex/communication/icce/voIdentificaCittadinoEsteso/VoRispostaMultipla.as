package it.lisit.siss.flex.communication.icce.voIdentificaCittadinoEsteso
{
	import it.lisit.siss.flex.communication.ValueObject;

	public class VoRispostaMultipla extends ValueObject
	{
		 
		
		public var esitoServizio:String;
		
		public var listaAssistiti:VoListaAssistiti;
		
		
		public function VoRispostaMultipla()
		{
			super();
		}
		
	}
}