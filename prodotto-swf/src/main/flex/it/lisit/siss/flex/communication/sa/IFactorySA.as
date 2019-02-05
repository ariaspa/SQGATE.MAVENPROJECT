package it.lisit.siss.flex.communication.sa
{
	import it.lisit.siss.flex.communication.IFactorySEB;
	import it.lisit.siss.flex.communication.sa.service.AbstractInterrogaAscoltatori;
	
	public interface IFactorySA extends IFactorySEB
	{
		function getInterrogaAscoltatori():AbstractInterrogaAscoltatori;
		
	}
}