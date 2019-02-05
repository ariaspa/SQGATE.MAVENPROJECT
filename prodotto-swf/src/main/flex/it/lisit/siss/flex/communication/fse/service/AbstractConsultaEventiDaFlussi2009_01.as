package it.lisit.siss.flex.communication.fse.service
{
	import it.lisit.siss.flex.communication.AbstractServiceSEB;
	import it.lisit.siss.flex.communication.exception.SebException;
	import it.lisit.siss.flex.communication.fse.voConsultaEventiDaFlussi.VoInputConsultaEventiDaFlussi;

	public class AbstractConsultaEventiDaFlussi2009_01 extends AbstractServiceSEB
	{
		public function AbstractConsultaEventiDaFlussi2009_01()
		{
			super();
		}
		virtual public function execute(input:VoInputConsultaEventiDaFlussi):void
		{
			throw new SebException("Virtual Method",SebException.IMPL_ERROR);
		}
	}
}