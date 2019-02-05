package it.lisit.siss.flex.communication.util
{
	import it.lisit.siss.flex.communication.IFactorySEB;
	import it.lisit.siss.flex.communication.util.service.AbstractCreaStrutturato;
	import it.lisit.siss.flex.communication.util.service.AbstractVerificaPDCSecurityInfo;

	public interface IFactoryUtils extends IFactorySEB
	{
		function getContentVisualizerPlugin():AbstractCreaStrutturato;
		function getVerificaPDCSecurityInfo():AbstractVerificaPDCSecurityInfo;
		
	}
}