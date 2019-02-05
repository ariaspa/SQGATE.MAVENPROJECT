package it.lisit.siss.flex.communication.fse.service
{
	import it.lisit.siss.flex.communication.AbstractServiceSEB;
	import it.lisit.siss.flex.communication.exception.SebException;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo2009.VoInputConsultaFascicolo2009;

	public class AbstractConsultaFascicolo2009 extends AbstractServiceSEB
	{
		public function AbstractConsultaFascicolo2009()
		{
			super();
		}
		/**
		 * @param vo l'input VoInputConsultaFascicolo con i dati di ricerca 
		 */ 		

		virtual public function execute(vo:VoInputConsultaFascicolo2009):void
		{
			throw new SebException("Virtual Method",SebException.IMPL_ERROR);
		}
	}
}