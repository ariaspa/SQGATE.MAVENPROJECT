package it.lisit.siss.flex.communication.crm.service
{
	import it.lisit.siss.flex.communication.AbstractServiceSEB;
	import it.lisit.siss.flex.communication.crm.voRichiediURLImagine.VoInputRichiediURLImmagine;
	import it.lisit.siss.flex.communication.exception.SebException;

	public class AbstractRichiediURLImmagine extends AbstractServiceSEB
	{
		public function AbstractRichiediURLImmagine()
		{
			super();
		}
		
		virtual public function execute(vo:VoInputRichiediURLImmagine):void
		{
			throw new SebException("Virtual Method",SebException.IMPL_ERROR);
		}
		
	}
}