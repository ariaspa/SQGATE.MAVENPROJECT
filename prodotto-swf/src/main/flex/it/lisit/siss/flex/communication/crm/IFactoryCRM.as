package it.lisit.siss.flex.communication.crm
{
	import it.lisit.siss.flex.communication.IFactorySEB;
	import it.lisit.siss.flex.communication.crm.service.AbstractRichiediURLImmagine;
	import it.lisit.siss.flex.communication.crm.service.AbstractVisualizzaTestoReferto;

	public interface IFactoryCRM extends IFactorySEB
	{
		function getVisualizzaTestoReferto():AbstractVisualizzaTestoReferto;
		function richiediURLImmagine():AbstractRichiediURLImmagine;
	}
}