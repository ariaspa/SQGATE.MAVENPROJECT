package it.lisit.siss.flex.communication.impl.soap.crm
{
	import it.lisit.siss.flex.communication.crm.service.AbstractVisualizzaTestoReferto;
	import it.lisit.siss.flex.communication.crm.voTestoReferto.VoInputTestoReferto;
	import it.lisit.siss.flex.communication.exception.SebException;
	import it.lisit.siss.flex.communication.impl.soap.ComposerSoap;
	import it.lisit.siss.flex.communication.impl.soap.ICommunicatorSoap;

	internal class SoapVisualizzaTestoReferto extends AbstractVisualizzaTestoReferto
	{
		private var communicator:ICommunicatorSoap;	 
		public function SoapVisualizzaTestoReferto( communicator:ICommunicatorSoap )
		{
			super();
			this.communicator = communicator;
		}
		//
		override public function execute(vo:VoInputTestoReferto):void
		{
			try
			{
				ComposerSoap.send(communicator,new InterpreterTestoReferto(),this,vo);
			}catch(e:Error)
			{
				throw new SebException(e.message,3000);
			}
		}
	}
}