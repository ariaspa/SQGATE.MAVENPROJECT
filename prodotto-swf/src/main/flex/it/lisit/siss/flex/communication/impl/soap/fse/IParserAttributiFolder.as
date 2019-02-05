package it.lisit.siss.flex.communication.impl.soap.fse
{
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoAttributiFolder;
	
	public interface IParserAttributiFolder
	{
		function getAttributi(attributi:XML,param:Object=null):VoAttributiFolder;
	}
}