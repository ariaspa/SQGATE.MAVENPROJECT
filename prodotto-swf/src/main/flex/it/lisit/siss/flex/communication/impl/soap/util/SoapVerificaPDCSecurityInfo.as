package it.lisit.siss.flex.communication.impl.soap.util
{
	import it.lisit.siss.flex.communication.exception.SebException;
	import it.lisit.siss.flex.communication.impl.soap.Communicator;
	import it.lisit.siss.flex.communication.impl.soap.ComposerSoap;
	import it.lisit.siss.flex.communication.impl.soap.ICommunicatorSoap;
	import it.lisit.siss.flex.communication.util.service.AbstractVerificaPDCSecurityInfo;
	import it.lisit.siss.flex.communication.util.voVerificaPDC.VoInputVerificaPDC;

	public class SoapVerificaPDCSecurityInfo extends AbstractVerificaPDCSecurityInfo
	{
		private var communicator:ICommunicatorSoap;
		public function SoapVerificaPDCSecurityInfo(communicator:ICommunicatorSoap)
		{
			super();
			this.communicator = communicator;
		}
		override public function execute():void
		{
			try
			{
				ComposerSoap.send(communicator,new InterpreterSoapVerificaPDCSecurityInfo(),this);
			}catch(e:Error)
			{
				throw new SebException(e.message,SebException.FSE_ERROR);
			}
		} 
	}
}