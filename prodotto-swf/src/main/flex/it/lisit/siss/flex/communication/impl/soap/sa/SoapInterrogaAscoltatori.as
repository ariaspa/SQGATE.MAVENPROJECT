package it.lisit.siss.flex.communication.impl.soap.sa
{
	import it.lisit.siss.flex.communication.exception.SebException;
	import it.lisit.siss.flex.communication.impl.soap.ComposerSoap;
	import it.lisit.siss.flex.communication.impl.soap.ICommunicatorSoap;
	import it.lisit.siss.flex.communication.sa.VoInterrogaAscoltatori.VoInputInterrogaAscoltatori;
	import it.lisit.siss.flex.communication.sa.service.AbstractInterrogaAscoltatori;

	public class SoapInterrogaAscoltatori extends AbstractInterrogaAscoltatori
	{
		private var communicator:ICommunicatorSoap;
		public function SoapInterrogaAscoltatori(communicator:ICommunicatorSoap)
		{
			super();
			this.communicator = communicator;
		}
		override public function execute(vo:VoInputInterrogaAscoltatori):void
		{
			try
			{
				ComposerSoap.send(communicator,new InterpreterSoapInterrogaAscoltatori(),this,vo);
			}catch(e:Error)
			{
				throw new SebException(e.message,SebException.FSE_ERROR);
			}
		}
	}
}