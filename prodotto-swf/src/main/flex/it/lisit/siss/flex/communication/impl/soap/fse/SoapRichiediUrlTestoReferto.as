package it.lisit.siss.flex.communication.impl.soap.fse
{
	import it.lisit.siss.flex.communication.exception.SebException;
	import it.lisit.siss.flex.communication.fse.service.AbstractRichiediUrlTestoReferto;
	import it.lisit.siss.flex.communication.fse.voRichiediUrlTestoReferto.VoInputRichiediUrlTestoReferto;
	import it.lisit.siss.flex.communication.impl.soap.ComposerSoap;
	import it.lisit.siss.flex.communication.impl.soap.ICommunicatorSoap;

	public class SoapRichiediUrlTestoReferto extends AbstractRichiediUrlTestoReferto
	{
		private var communicator:ICommunicatorSoap;

		public function SoapRichiediUrlTestoReferto(communicator:ICommunicatorSoap)
		{
			super();
			this.communicator = communicator;
		}
		override public function execute(vo:VoInputRichiediUrlTestoReferto):void
		{
			try
			{
				ComposerSoap.send(communicator, new InterpreterSoapRichiediUrlTestoReferto(), this, vo);
			}
			catch(e:Error)
			{
				throw new SebException(e.message, SebException.FSE_ERROR);
			}
		}
	}
}