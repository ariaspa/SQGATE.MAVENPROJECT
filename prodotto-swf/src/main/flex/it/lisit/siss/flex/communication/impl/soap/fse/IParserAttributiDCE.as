package it.lisit.siss.flex.communication.impl.soap.fse
{
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoAttributiSpecificiDCE;
	
	public interface IParserAttributiDCE
	{
		function getAttributi(attributi:XML,param:Object = null):VoAttributiSpecificiDCE;
	}
}