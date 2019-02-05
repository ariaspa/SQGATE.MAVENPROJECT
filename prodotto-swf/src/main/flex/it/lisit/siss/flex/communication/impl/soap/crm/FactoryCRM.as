package it.lisit.siss.flex.communication.impl.soap.crm
{
	import it.lisit.siss.flex.communication.crm.IFactoryCRM;
	import it.lisit.siss.flex.communication.crm.service.AbstractRichiediURLImmagine;
	import it.lisit.siss.flex.communication.crm.service.AbstractVisualizzaTestoReferto;
	import it.lisit.siss.flex.communication.impl.soap.FactorySEBSoap;
	import it.lisit.siss.flex.communication.impl.soap.ICommunicatorSoap;

	public class FactoryCRM extends FactorySEBSoap implements IFactoryCRM
	{
		public function FactoryCRM(communicator:ICommunicatorSoap)
		{
			super(communicator);
		}
		
		override public function get version():String
		{
			return "1.0";
		}
		
		override public function get author():String
		{
			return "Marco Salonia";
		}
		
		public function getVisualizzaTestoReferto():AbstractVisualizzaTestoReferto
		{
			return new SoapVisualizzaTestoReferto( this.communicator );
		}
		public function richiediURLImmagine():AbstractRichiediURLImmagine
		{
			return new SoapRichiediURLImmagine( this.communicator );
		}
		
	}
}