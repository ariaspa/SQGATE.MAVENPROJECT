package it.lisit.siss.flex.communication.impl.soap.fse
{
	import it.lisit.siss.flex.communication.exception.SebException;
	import it.lisit.siss.flex.communication.fse.service.AbstractApriPDT;
	import it.lisit.siss.flex.communication.fse.voApriPDT.VoInputApriPDT;
	import it.lisit.siss.flex.communication.impl.soap.ComposerSoap;
	import it.lisit.siss.flex.communication.impl.soap.ICommunicatorSoap;

	internal class SoapApriPDT extends AbstractApriPDT
	{
		private var communicator:ICommunicatorSoap;
		public function SoapApriPDT(communicator:ICommunicatorSoap)
		{
			super();
			this.communicator = communicator;
		}
		override public function execute(vo:VoInputApriPDT):void
		{
			try
			{
				ComposerSoap.send(communicator,new InterpreterSoapApriPDT(),this,vo);
			}catch(e:Error)
			{
				throw new SebException(e.message,SebException.FSE_ERROR);
			}
		}
	}
}