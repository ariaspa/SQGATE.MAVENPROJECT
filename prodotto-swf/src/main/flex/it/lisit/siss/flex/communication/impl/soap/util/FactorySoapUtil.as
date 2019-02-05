package it.lisit.siss.flex.communication.impl.soap.util
{
	import it.lisit.siss.flex.communication.impl.soap.FactorySEBSoap;
	import it.lisit.siss.flex.communication.impl.soap.ICommunicatorSoap;
	import it.lisit.siss.flex.communication.util.IFactoryUtils;
	import it.lisit.siss.flex.communication.util.service.AbstractCreaStrutturato;
	import it.lisit.siss.flex.communication.util.service.AbstractVerificaPDCSecurityInfo;

	public class FactorySoapUtil extends FactorySEBSoap implements IFactoryUtils
	{
		/**
		 * communicator indica il comunicatore da utilizzare per le chiamate al servizio 
		 * @param communicator:ICommunicatorSoap
		 * 
		 */	
		public function FactorySoapUtil(communicator:ICommunicatorSoap)
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
		public function getContentVisualizerPlugin():AbstractCreaStrutturato 
		{
			return new SoapContentVisualizerPlugin(this.communicator);
		}
		public function getVerificaPDCSecurityInfo():AbstractVerificaPDCSecurityInfo
		{
			return new SoapVerificaPDCSecurityInfo(this.communicator);
		}
	}
}