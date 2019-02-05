package it.lisit.siss.flex.communication.crm.service
{
	import it.lisit.siss.flex.communication.AbstractServiceSEB;
	import it.lisit.siss.flex.communication.crm.voTestoReferto.VoInputTestoReferto;
	import it.lisit.siss.flex.communication.exception.SebException;

	public class AbstractVisualizzaTestoReferto extends AbstractServiceSEB
	{
		public function AbstractVisualizzaTestoReferto()
		{
			super();
		}
		virtual public function execute(vo:VoInputTestoReferto):void
		{
			throw new SebException("Virtual Method",SebException.IMPL_ERROR);
		}
	}
}