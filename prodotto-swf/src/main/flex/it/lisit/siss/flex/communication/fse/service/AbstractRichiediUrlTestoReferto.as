package it.lisit.siss.flex.communication.fse.service
{
	import it.lisit.siss.flex.communication.AbstractServiceSEB;
	import it.lisit.siss.flex.communication.exception.SebException;
	import it.lisit.siss.flex.communication.fse.voRichiediUrlTestoReferto.VoInputRichiediUrlTestoReferto;

	public class AbstractRichiediUrlTestoReferto extends AbstractServiceSEB
	{
		public function AbstractRichiediUrlTestoReferto()
		{
			super();
		}

		virtual public function execute(vo:VoInputRichiediUrlTestoReferto):void
		{
			throw new SebException("Virtual Method",SebException.IMPL_ERROR);
		}
	}
}