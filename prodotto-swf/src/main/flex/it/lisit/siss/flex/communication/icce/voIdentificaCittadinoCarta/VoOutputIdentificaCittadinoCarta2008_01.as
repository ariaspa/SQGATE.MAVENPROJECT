package it.lisit.siss.flex.communication.icce.voIdentificaCittadinoCarta
{
	import it.lisit.siss.flex.communication.ValueObject;
	import it.lisit.siss.flex.communication.icce.voIdentificaCittadinoEsteso.VoDatiCittadino;
	import it.lisit.siss.flex.communication.icce.voIdentificaCittadinoEsteso.VoDatiMedico;
	import it.lisit.siss.flex.communication.icce.voIdentificaCittadinoEsteso.VoDatiTesserino;
	import it.lisit.siss.flex.communication.icce.voIdentificaCittadinoEsteso.VoEsenzioniGodute;

	public class VoOutputIdentificaCittadinoCarta2008_01 extends ValueObject
	{
		public var datiCittadino:VoDatiCittadino;
		public var datiMedico:VoDatiMedico;
		public var datiTesserino:VoDatiTesserino;
		public var esenzioniGodute:VoEsenzioniGodute;
		public var esitoServizio:String
		public function VoOutputIdentificaCittadinoCarta2008_01()
		{
			super();
		}
	}
}