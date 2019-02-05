package it.lisit.siss.flex.communication.impl.soap.coop
{
	import it.lisit.siss.flex.communication.coop.service.AbstractServiceLeggiCredenziali;
	import it.lisit.siss.flex.communication.exception.SebException;
	import it.lisit.siss.flex.communication.impl.soap.ComposerSoap;
	import it.lisit.siss.flex.communication.impl.soap.ICommunicatorSoap;

	internal class SoapLeggiCredenziali extends AbstractServiceLeggiCredenziali
	{
		private var communicator:ICommunicatorSoap
		public function SoapLeggiCredenziali(comm:ICommunicatorSoap)
		{
			super();
			communicator = comm;
		}
		override public function getOperatore():void
		{
			try
			{
				ComposerSoap.send(communicator,new InterpreterSoapLeggiCredenziali(),this);
			}catch(e:Error)
			{
				throw new SebException(e.message,SebException.COOP_ERROR);
			}
		}
	}
}