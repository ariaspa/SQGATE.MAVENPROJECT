package it.lisit.siss.flex.communication.impl.soap.icce
{
	import it.lisit.siss.flex.communication.exception.SebException;
	import it.lisit.siss.flex.communication.icce.service.ASIdentificaCittadinoCarta2008_01;
	import it.lisit.siss.flex.communication.impl.soap.ComposerSoap;
	import it.lisit.siss.flex.communication.impl.soap.ICommunicatorSoap;

	internal class SoapIdentificaCittadinoFromSmartCard extends ASIdentificaCittadinoCarta2008_01
	{
		private var communicator:ICommunicatorSoap
		public function SoapIdentificaCittadinoFromSmartCard(comm:ICommunicatorSoap)
		{
			super();
			this.communicator = comm;
		}
		override public function execute():void
		{
			try
			{
				ComposerSoap.send(communicator,new ISIdentificaCittadinoCarta(),this);
			}catch(e:Error)
			{
				throw new SebException(e.message,SebException.ICCE_ERROR);
			}
		}
	}
}