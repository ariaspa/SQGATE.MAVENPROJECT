package it.lisit.siss.flex.communication.fse.service
{
	import it.lisit.siss.flex.communication.AbstractServiceSEB;
	import it.lisit.siss.flex.communication.exception.SebException;
	import it.lisit.siss.flex.communication.fse.voCopiaDCEInPDT.VoInputCopiaDCEInPDT;

	public class AbstractCopiaDCEInPDT extends AbstractServiceSEB
	{
		public function AbstractCopiaDCEInPDT()
		{
			super();
		}
		/**
		 * @param vo l'input VoInputCopiaDCEInPDT  
		 */ 		

		virtual public function execute(vo:VoInputCopiaDCEInPDT):void
		{
			throw new SebException("Virtual Method",SebException.IMPL_ERROR);
		}
	}
}