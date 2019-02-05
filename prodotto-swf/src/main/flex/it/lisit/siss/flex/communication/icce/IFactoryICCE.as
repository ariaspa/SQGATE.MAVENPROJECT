package it.lisit.siss.flex.communication.icce
{
	import it.lisit.siss.flex.communication.icce.service.AbstractServiceIdentificaCittadinoEsteso2008_01;
	import it.lisit.siss.flex.communication.icce.service.ASIdentificaCittadinoCarta2008_01;
	
	public interface IFactoryICCE
	{
		function getServiceIdentificaCittadino():AbstractServiceIdentificaCittadinoEsteso2008_01;
		function getServiceIdentificaCittadinoFromSmartCard():ASIdentificaCittadinoCarta2008_01;
	}
}