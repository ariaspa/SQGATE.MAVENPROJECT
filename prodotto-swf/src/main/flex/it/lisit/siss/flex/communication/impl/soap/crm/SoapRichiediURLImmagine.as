package it.lisit.siss.flex.communication.impl.soap.crm
{
	import it.lisit.siss.flex.communication.crm.service.AbstractRichiediURLImmagine;
	import it.lisit.siss.flex.communication.crm.voRichiediURLImagine.VoInputRichiediURLImmagine;
	import it.lisit.siss.flex.communication.exception.SebException;
	import it.lisit.siss.flex.communication.impl.soap.ComposerSoap;
	import it.lisit.siss.flex.communication.impl.soap.ICommunicatorSoap;

	internal class SoapRichiediURLImmagine extends AbstractRichiediURLImmagine
	{
		private var communicator:ICommunicatorSoap;	 
		
		public function SoapRichiediURLImmagine(communicator:ICommunicatorSoap)
		{
			super();
			this.communicator = communicator;
		}
		
		override public function execute(vo:VoInputRichiediURLImmagine):void
		{
			try
			{
				ComposerSoap.send(communicator,new InterpreterRichiediURLImmagine(),this,vo);
			}catch(e:Error)
			{
				throw new SebException(e.message,3000);
			}
		}
		
	}
}