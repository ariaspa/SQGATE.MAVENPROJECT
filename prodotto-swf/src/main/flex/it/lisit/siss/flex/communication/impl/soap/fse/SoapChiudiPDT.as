package it.lisit.siss.flex.communication.impl.soap.fse
{
	import it.lisit.siss.flex.communication.exception.SebException;
	import it.lisit.siss.flex.communication.fse.service.AbstractChiudiPDT;
	import it.lisit.siss.flex.communication.fse.voChiudiPDT.VoInputChiudiPDT;
	import it.lisit.siss.flex.communication.impl.soap.ComposerSoap;
	import it.lisit.siss.flex.communication.impl.soap.ICommunicatorSoap;

	internal class SoapChiudiPDT extends AbstractChiudiPDT
	{
		private var communicator:ICommunicatorSoap;
		public function SoapChiudiPDT(communicator:ICommunicatorSoap)
		{
			super();
			this.communicator = communicator;
		}
		override public function execute(vo:VoInputChiudiPDT):void
		{
			try
			{
				ComposerSoap.send(communicator,new InterpreterSoapChiudiPDT(),this,vo);
			}catch(e:Error)
			{
				throw new SebException(e.message,SebException.FSE_ERROR);
			}
		}
	}
}