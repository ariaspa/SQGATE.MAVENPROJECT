package it.lisit.siss.flex.communication.fse.service
{
	import it.lisit.siss.flex.communication.AbstractServiceSEB;
	import it.lisit.siss.flex.communication.exception.SebException;
	import it.lisit.siss.flex.communication.fse.voOttieniIndiceFascicolo.VoInputOttieniIndiceFascicolo;

	public class AbstractOttieniIndiceFascicolo extends AbstractServiceSEB
	{
		public function AbstractOttieniIndiceFascicolo()
		{
			super();
		}
		
		virtual public function execute(vo:VoInputOttieniIndiceFascicolo):void
		{
			throw new SebException("Virtual Method",SebException.IMPL_ERROR);
		}
		
	}
}