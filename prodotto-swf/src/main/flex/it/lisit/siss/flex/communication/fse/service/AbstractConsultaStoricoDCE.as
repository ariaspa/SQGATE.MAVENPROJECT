package it.lisit.siss.flex.communication.fse.service
{
	import it.lisit.siss.flex.communication.AbstractServiceSEB;
	import it.lisit.siss.flex.communication.exception.SebException;
	import it.lisit.siss.flex.communication.fse.voConsultaStoricoDCE.VoInputConsultaStoricoDCE;

	public class AbstractConsultaStoricoDCE extends AbstractServiceSEB
	{
		public function AbstractConsultaStoricoDCE()
		{
			super();
		}
		
		/**
		 * @param vo l'input VoInputApriPDT con i dati di ricerca 
		 */ 		
		virtual public function execute(vo:VoInputConsultaStoricoDCE):void
		{
			throw new SebException("Virtual Method",SebException.IMPL_ERROR);
		}
		
	}
}