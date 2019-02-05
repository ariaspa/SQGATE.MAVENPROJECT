package it.lisit.siss.flex.communication.impl.soap.fse
{
	import it.lisit.siss.flex.communication.exception.SebException;
	import it.lisit.siss.flex.communication.fse.service.AbstractConsultaStoricoDCE;
	import it.lisit.siss.flex.communication.fse.voConsultaStoricoDCE.VoInputConsultaStoricoDCE;
	import it.lisit.siss.flex.communication.impl.soap.ComposerSoap;
	import it.lisit.siss.flex.communication.impl.soap.ICommunicatorSoap;

	internal class SoapConsultaStoricoDCE extends AbstractConsultaStoricoDCE
	{
		private var communicator:ICommunicatorSoap;
		public function SoapConsultaStoricoDCE(communicator:ICommunicatorSoap)
		{
			super();
			this.communicator = communicator;
		}
		override public function execute(vo:VoInputConsultaStoricoDCE):void
		{
			try
			{
				ComposerSoap.send(communicator,new InterpreterSoapConsultaStoricoDCE(),this,vo);
			}catch(e:Error)
			{
				throw new SebException(e.message,SebException.FSE_ERROR);
			}
		}
		
	}
}