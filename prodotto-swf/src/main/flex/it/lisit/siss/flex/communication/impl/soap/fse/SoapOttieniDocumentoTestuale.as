package it.lisit.siss.flex.communication.impl.soap.fse
{
	import it.lisit.siss.flex.communication.exception.SebException;
	import it.lisit.siss.flex.communication.fse.service.AbstractOttieniDocumentoTestuale;
	import it.lisit.siss.flex.communication.fse.voOttieniDocumentoTestuale.VoInputOttieniDocumentoTestuale;
	import it.lisit.siss.flex.communication.impl.soap.ComposerSoap;
	import it.lisit.siss.flex.communication.impl.soap.ICommunicatorSoap;

	public class SoapOttieniDocumentoTestuale extends AbstractOttieniDocumentoTestuale
	{
		private var communicator:ICommunicatorSoap;
		public function SoapOttieniDocumentoTestuale(communicator:ICommunicatorSoap)
		{
			super();
			this.communicator = communicator;
		}
		
		override public function execute(vo:VoInputOttieniDocumentoTestuale):void
		{
			try
			{
				ComposerSoap.send(communicator,new InterpreterSoapOttieniDocumentoTestuale(),this,vo);
			}catch(e:Error)
			{
				throw new SebException(e.message,SebException.FSE_ERROR);
			}
		}
		
	}
}