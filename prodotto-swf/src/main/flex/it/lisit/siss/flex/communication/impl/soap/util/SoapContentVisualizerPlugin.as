package it.lisit.siss.flex.communication.impl.soap.util
{
	import it.lisit.siss.flex.communication.exception.SebException;
	import it.lisit.siss.flex.communication.impl.soap.ComposerSoap;
	import it.lisit.siss.flex.communication.impl.soap.ICommunicatorSoap;
	import it.lisit.siss.flex.communication.util.service.AbstractCreaStrutturato;
	import it.lisit.siss.flex.communication.util.voCreaStrutturato.VoInputCreaStrutturato;

	public class SoapContentVisualizerPlugin extends AbstractCreaStrutturato
	{
		private var communicator:ICommunicatorSoap;
		public function SoapContentVisualizerPlugin(communicator:ICommunicatorSoap)
		{
			super();
			this.communicator = communicator;
		}
		override public function execute(vo:VoInputCreaStrutturato):void
		{
			try
			{
				ComposerSoap.send(communicator,new InterpreterSoapContentVisualizerPlugin(),this,vo);
			}catch(e:Error)
			{
				throw new SebException(e.message,SebException.FSE_ERROR);
			}
		}
	}
}