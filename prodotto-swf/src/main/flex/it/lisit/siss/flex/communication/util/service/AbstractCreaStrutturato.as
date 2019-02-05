package it.lisit.siss.flex.communication.util.service
{
	import it.lisit.siss.flex.communication.AbstractServiceSEB
	import it.lisit.siss.flex.communication.exception.SebException;
	import it.lisit.siss.flex.communication.util.voCreaStrutturato.VoInputCreaStrutturato;
	
	public class AbstractCreaStrutturato extends AbstractServiceSEB
	{
		public function AbstractCreaStrutturato()
		{
			super();
		}
		public virtual function execute(vo:VoInputCreaStrutturato):void 
		{
			
			throw new SebException("Virtual Method",SebException.IMPL_ERROR);
		}
	}
}