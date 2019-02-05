package it.lisit.siss.flex.communication.impl.soap.sa
{
	import it.lisit.siss.flex.communication.impl.soap.FactorySEBSoap;
	import it.lisit.siss.flex.communication.impl.soap.ICommunicatorSoap;
	import it.lisit.siss.flex.communication.sa.IFactorySA;
	import it.lisit.siss.flex.communication.sa.service.AbstractInterrogaAscoltatori;

	public class FactorySoapSA extends FactorySEBSoap implements IFactorySA
	{
		/**
		 * communicator indica il comunicatore da utilizzare per le chiamate al servizio 
		 * @param communicator:ICommunicatorSoap
		 * 
		 */	
		public function FactorySoapSA(communicator:ICommunicatorSoap)
		{
			super(communicator);
		}
		
		public override function get version():String
		{
			return "1.00 - 01";
		}
		public override function get author():String
		{
			return "Salvatore Civiletto";
		}
		
		public function getInterrogaAscoltatori():AbstractInterrogaAscoltatori {
			return new SoapInterrogaAscoltatori(this.communicator);
		}
		
	}
}