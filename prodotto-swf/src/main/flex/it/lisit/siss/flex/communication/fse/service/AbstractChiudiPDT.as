package it.lisit.siss.flex.communication.fse.service
{
	import it.lisit.siss.flex.communication.AbstractServiceSEB;
	import it.lisit.siss.flex.communication.exception.SebException;
	import it.lisit.siss.flex.communication.fse.voChiudiPDT.VoInputChiudiPDT;

	public class AbstractChiudiPDT extends AbstractServiceSEB
	{
		public function AbstractChiudiPDT()
		{
			super();
		}
		/**
		 * @param vo l'input VoInputChiudiPDT  
		 */ 		
		virtual public function execute(vo:VoInputChiudiPDT):void
		{
			throw new SebException("Virtual Method",SebException.IMPL_ERROR);
		}
	}
}