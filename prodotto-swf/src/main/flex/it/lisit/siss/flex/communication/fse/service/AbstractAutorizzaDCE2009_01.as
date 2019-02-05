package it.lisit.siss.flex.communication.fse.service
{
	import it.lisit.siss.flex.communication.AbstractServiceSEB;
	import it.lisit.siss.flex.communication.exception.SebException;
	import it.lisit.siss.flex.communication.fse.voAutorizzaDce.VoInputAutorizzaDce;

	public class AbstractAutorizzaDCE2009_01 extends AbstractServiceSEB
	{
		public function AbstractAutorizzaDCE2009_01()
		{
			super();
		}
		/**
		 * @param vo l'input VoInputChiudiPDT  
		 */ 		
		virtual public function execute(vo:VoInputAutorizzaDce):void
		{
			throw new SebException("Virtual Method",SebException.IMPL_ERROR);
		}
	}
}