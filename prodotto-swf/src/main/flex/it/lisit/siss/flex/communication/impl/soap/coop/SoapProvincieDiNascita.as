package it.lisit.siss.flex.communication.impl.soap.coop
{
	import it.lisit.siss.flex.communication.coop.service.AbstractServiceProvincieDiNascita;
	import it.lisit.siss.flex.communication.exception.SebException;
	import it.lisit.siss.flex.communication.impl.soap.ComposerSoap;
	import it.lisit.siss.flex.communication.impl.soap.ICommunicatorSoap;

	internal class SoapProvincieDiNascita extends AbstractServiceProvincieDiNascita
	{
		private var communicator:ICommunicatorSoap;
		public function SoapProvincieDiNascita(comm:ICommunicatorSoap)
		{
			super();
			communicator = comm;
		}
		/**
		 * la richiesta in realtà passa per una query fatta ai servizi locali pdl
		 * LDB.executeStatement 
		 * 
		 */		 	
		override public function getElenco():void
		{
			try
			{
				ComposerSoap.send(communicator,new InterpreterSoapProvinceDiNascita(),this);
			}catch(e:Error)
			{
				throw new SebException(e.message,SebException.COOP_ERROR);
			}
		}
	}
}