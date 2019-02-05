package it.lisit.siss.flex.communication.impl.soap.fse
{
	import it.lisit.siss.flex.communication.exception.SebException;
	import it.lisit.siss.flex.communication.fse.service.AbstractOttieniDocumentoCDA2;
	import it.lisit.siss.flex.communication.fse.voOttieniDocumentoCDA2.VoInputOttieniDocumentoCDA2;
	import it.lisit.siss.flex.communication.impl.soap.ComposerSoap;
	import it.lisit.siss.flex.communication.impl.soap.ICommunicatorSoap;

	public class SoapOttieniDocumentoCDA2 extends AbstractOttieniDocumentoCDA2
	{
		private var communicator:ICommunicatorSoap;
		
		public function SoapOttieniDocumentoCDA2(communicator:ICommunicatorSoap)
		{
			super();
			this.communicator = communicator;
		}
		
		override public function execute(vo:VoInputOttieniDocumentoCDA2):void
		{
			try
			{
				ComposerSoap.send(communicator,new InterpreterSoapOttieniDocumentoCDA2(),this,vo);
			}catch(e:Error)
			{
				throw new SebException(e.message,SebException.FSE_ERROR);
			}
		}
		
	}
}