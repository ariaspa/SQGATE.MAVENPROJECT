package it.lisit.siss.flex.communication.fse.service
{
	import it.lisit.siss.flex.communication.AbstractServiceSEB;
	import it.lisit.siss.flex.communication.exception.SebException;
	import it.lisit.siss.flex.communication.fse.voCancellaDCEDaFolder.VoInputCancellaDCEDaFolder;

	public class AbstractCancellaDCEDaFolder extends AbstractServiceSEB
	{
		public function AbstractCancellaDCEDaFolder()
		{
			super();
		}
		
		/**
		 * @param vo l'input VoInputCancellaDCEDaFolder  
		 */ 		

		virtual public function execute(vo:VoInputCancellaDCEDaFolder):void
		{
			throw new SebException("Virtual Method",SebException.IMPL_ERROR);
		}
		
	}
}