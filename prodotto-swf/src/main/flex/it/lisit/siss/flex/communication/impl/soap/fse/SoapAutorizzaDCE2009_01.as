package it.lisit.siss.flex.communication.impl.soap.fse
{
	import it.lisit.siss.flex.communication.exception.SebException;
	import it.lisit.siss.flex.communication.fse.service.AbstractAutorizzaDCE2009_01;
	import it.lisit.siss.flex.communication.fse.voAutorizzaDce.VoInputAutorizzaDce;
	import it.lisit.siss.flex.communication.impl.soap.ComposerSoap;
	import it.lisit.siss.flex.communication.impl.soap.ICommunicatorSoap;

	public class SoapAutorizzaDCE2009_01 extends AbstractAutorizzaDCE2009_01
	{
		private var communicator:ICommunicatorSoap;
		public function SoapAutorizzaDCE2009_01(communicator:ICommunicatorSoap)
		{
			super();
			this.communicator = communicator;
		}
		override public function execute(vo:VoInputAutorizzaDce):void
		{
			try
			{
				ComposerSoap.send(communicator,new InterpreterSoapAutorizzaDce2009_01(),this,vo);
			}catch(e:Error)
			{
				throw new SebException(e.message,SebException.FSE_ERROR);
			}
		}
	}
}