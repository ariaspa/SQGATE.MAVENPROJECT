package it.lisit.siss.flex.communication.impl.soap.fse
{
	import it.lisit.siss.flex.communication.exception.SebException;
	import it.lisit.siss.flex.communication.fse.service.AbstractOttieniIndiceFascicolo;
	import it.lisit.siss.flex.communication.fse.voOttieniIndiceFascicolo.VoInputOttieniIndiceFascicolo;
	import it.lisit.siss.flex.communication.impl.soap.ComposerSoap;
	import it.lisit.siss.flex.communication.impl.soap.ICommunicatorSoap;

	public class SoapOttieniIndiceFascicolo extends AbstractOttieniIndiceFascicolo
	{
		private var communicator:ICommunicatorSoap;
		public function SoapOttieniIndiceFascicolo(communicator:ICommunicatorSoap)
		{
			super();
			this.communicator = communicator;
		}
		
		override public function execute(vo:VoInputOttieniIndiceFascicolo):void
		{
			try
			{
				ComposerSoap.send(communicator,new InterpreterSoapOttieniIndiceFascicolo(),this,vo);
			}catch(e:Error)
			{
				throw new SebException(e.message,SebException.FSE_ERROR);
			}
		}
		
	}
}