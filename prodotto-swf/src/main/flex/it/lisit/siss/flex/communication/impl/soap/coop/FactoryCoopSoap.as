package it.lisit.siss.flex.communication.impl.soap.coop
{
	import it.lisit.siss.flex.communication.impl.soap.ICommunicatorSoap;
	import it.lisit.siss.flex.communication.coop.service.AbstractServiceLeggiCredenziali;
	import it.lisit.siss.flex.communication.coop.service.AbstractServiceProvincieDiNascita;
	import it.lisit.siss.flex.communication.impl.soap.FactorySEBSoap;
	import it.lisit.siss.flex.communication.coop.service.AbstractServiceComuniDiNascita;
	import it.lisit.siss.flex.communication.coop.IFactoryCOOP;

	public class FactoryCoopSoap extends FactorySEBSoap implements IFactoryCOOP
	{
		public function FactoryCoopSoap(communicator:ICommunicatorSoap)
		{
			super(communicator);
		}
		
		override public function get version():String
		{
			return "1.00";
		}
		
		override public function get author():String
		{
			return "Daniele Fossati";
		}
		
		public function getServiceLeggiCredenziali():AbstractServiceLeggiCredenziali
		{
			return new SoapLeggiCredenziali(this.communicator);
		}
		
		public function getServiceProvincieDiNascita():AbstractServiceProvincieDiNascita
		{
			return new SoapProvincieDiNascita(this.communicator);;
		}
		
		public function getServiceComuniDiNascita():AbstractServiceComuniDiNascita
		{
			return new SoapServiceComuniDiNascita(this.communicator);;
		}
		
	}
}