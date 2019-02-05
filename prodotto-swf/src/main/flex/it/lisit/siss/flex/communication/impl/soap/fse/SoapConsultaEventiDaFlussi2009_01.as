package it.lisit.siss.flex.communication.impl.soap.fse
{
	import it.lisit.siss.flex.communication.exception.SebException;
	import it.lisit.siss.flex.communication.fse.service.AbstractConsultaEventiDaFlussi2009_01;
	import it.lisit.siss.flex.communication.fse.voConsultaEventiDaFlussi.VoInputConsultaEventiDaFlussi;
	import it.lisit.siss.flex.communication.impl.soap.ComposerSoap;
	import it.lisit.siss.flex.communication.impl.soap.ICommunicatorSoap;

	internal class SoapConsultaEventiDaFlussi2009_01 extends AbstractConsultaEventiDaFlussi2009_01
	{
		private var communicator:ICommunicatorSoap;
		public function SoapConsultaEventiDaFlussi2009_01(communicator:ICommunicatorSoap)
		{
			super();
			this.communicator = communicator;
		}
		override public function execute(input:VoInputConsultaEventiDaFlussi):void
		{
			try
			{
				ComposerSoap.send(communicator,new InterpreterSoapConsultaEventi2009_01(),this,input);
			}catch(e:Error)
			{
				throw new SebException(e.message,SebException.FSE_ERROR);
			}
		}
	}
}