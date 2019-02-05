package it.lisit.siss.flex.communication.impl.soap.fse
{
	import it.lisit.siss.flex.communication.exception.SebException;
	import it.lisit.siss.flex.communication.fse.service.AbstractCopiaDCEInPDT;
	import it.lisit.siss.flex.communication.fse.voCopiaDCEInPDT.VoInputCopiaDCEInPDT;
	import it.lisit.siss.flex.communication.impl.soap.ComposerSoap;
	import it.lisit.siss.flex.communication.impl.soap.ICommunicatorSoap;

	internal class SoapCopiaDCEInPDT extends AbstractCopiaDCEInPDT
	{
		private var communicator:ICommunicatorSoap;	 
		public function SoapCopiaDCEInPDT(communicator:ICommunicatorSoap)
		{
			super();
			this.communicator = communicator;
		}
		override public function execute(vo:VoInputCopiaDCEInPDT):void
		{
			try
			{
				ComposerSoap.send(communicator,new InterpreterCopiaDCEInPDT(),this,vo);
			}catch(e:Error)
			{
				throw new SebException(e.message,SebException.FSE_ERROR);
			}
		}
	}
}