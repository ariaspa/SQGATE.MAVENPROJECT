package it.lisit.siss.flex.communication.impl.soap.fse
{
	import it.lisit.siss.flex.communication.exception.SebException;
	import it.lisit.siss.flex.communication.fse.service.AbstractCancellaDCEDaFolder;
	import it.lisit.siss.flex.communication.fse.voCancellaDCEDaFolder.VoInputCancellaDCEDaFolder;
	import it.lisit.siss.flex.communication.impl.soap.ComposerSoap;
	import it.lisit.siss.flex.communication.impl.soap.ICommunicatorSoap;

	public class SoapCancellaDCEDaFolder extends AbstractCancellaDCEDaFolder
	{
		private var communicator:ICommunicatorSoap;	 
		public function SoapCancellaDCEDaFolder(communicator:ICommunicatorSoap)
		{
			super();
			this.communicator = communicator;
		}
		override public function execute(vo:VoInputCancellaDCEDaFolder):void
		{
			try
			{
				ComposerSoap.send(communicator,new InterpreterCancellaDCEDaFolder(),this,vo);
			}catch(e:Error)
			{
				throw new SebException(e.message,SebException.FSE_ERROR);
			}
		}
		
	}
}