package it.lisit.siss.flex.communication.coop
{
	import it.lisit.siss.flex.communication.IFactorySEB;
	import it.lisit.siss.flex.communication.coop.service.AbstractServiceComuniDiNascita;
	import it.lisit.siss.flex.communication.coop.service.AbstractServiceLeggiCredenziali;
	import it.lisit.siss.flex.communication.coop.service.AbstractServiceProvincieDiNascita;
	
	/**
	 * 
	 */
	public interface IFactoryCOOP extends IFactorySEB
	{
		function getServiceLeggiCredenziali():AbstractServiceLeggiCredenziali;
		function getServiceProvincieDiNascita():AbstractServiceProvincieDiNascita;
		function getServiceComuniDiNascita():AbstractServiceComuniDiNascita;
	}
}