package it.lisit.siss.flex.communication.impl.soap.icce
{
	import it.lisit.siss.flex.communication.icce.IFactoryICCE;
	import it.lisit.siss.flex.communication.icce.service.AbstractServiceIdentificaCittadinoEsteso2008_01;
	import it.lisit.siss.flex.communication.icce.service.ASIdentificaCittadinoCarta2008_01;
	import it.lisit.siss.flex.communication.impl.soap.FactorySEBSoap;
	import it.lisit.siss.flex.communication.impl.soap.ICommunicatorSoap;

	public class FactoryIcce extends FactorySEBSoap implements IFactoryICCE
	{
		public override function get version():String
		{
			return "1.00";
		}
		public override function get author():String
		{
			return "Marco Salonia - Diego Fossati";
		}
		public function FactoryIcce(communicator:ICommunicatorSoap)
		{
			super(communicator);
		}
		
		public function getServiceIdentificaCittadino():AbstractServiceIdentificaCittadinoEsteso2008_01
		{
			return new SoapIdentificaCittadinoEsteso(this.communicator);
		}
		
		public function getServiceIdentificaCittadinoFromSmartCard():ASIdentificaCittadinoCarta2008_01
		{
			return new SoapIdentificaCittadinoFromSmartCard(this.communicator);
		}
		
	}
}