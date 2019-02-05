package it.lisit.siss.flex.communication.impl.soap.icce
{
	import it.lisit.siss.flex.communication.exception.SebException;
	import it.lisit.siss.flex.communication.icce.service.AbstractServiceIdentificaCittadinoEsteso2008_01;
	import it.lisit.siss.flex.communication.icce.voIdentificaCittadinoEsteso.VoInputIdentificaCittadinoEsteso;
	import it.lisit.siss.flex.communication.impl.soap.ComposerSoap;
	import it.lisit.siss.flex.communication.impl.soap.ICommunicatorSoap;

	internal class SoapIdentificaCittadinoEsteso extends AbstractServiceIdentificaCittadinoEsteso2008_01
	{
		private var communicator:ICommunicatorSoap;
		public function SoapIdentificaCittadinoEsteso(comm:ICommunicatorSoap)
		{
			super();
			this.communicator = comm;
		}
		override public function execute(vo:VoInputIdentificaCittadinoEsteso):void
		{
			try
			{
				ComposerSoap.send(communicator,new InterpreterSoapIdentificaCittadinoEsteso(),this,vo);
			}catch(e:Error)
			{
				throw new SebException(e.message,SebException.ICCE_ERROR);
			}
		}
	}
}