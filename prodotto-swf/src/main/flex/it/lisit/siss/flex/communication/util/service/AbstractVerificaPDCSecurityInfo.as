package it.lisit.siss.flex.communication.util.service
{
	import it.lisit.siss.flex.communication.AbstractServiceSEB;
	import it.lisit.siss.flex.communication.exception.SebException;
	import it.lisit.siss.flex.communication.util.voVerificaPDC.VoInputVerificaPDC;

	public class AbstractVerificaPDCSecurityInfo extends AbstractServiceSEB
	{
		public function AbstractVerificaPDCSecurityInfo()
		{
			super();
		}
		/**
		 * @param vo l'input VoInputVerificaPDC con i dati di ricerca 
		 */ 		
		virtual public function execute():void
		{
			throw new SebException("Virtual Method",SebException.IMPL_ERROR);
		}
	}
}