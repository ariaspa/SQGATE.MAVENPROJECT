package it.lisit.siss.flex.communication.fse.service
{
	import it.lisit.siss.flex.communication.AbstractServiceSEB;
	import it.lisit.siss.flex.communication.exception.SebException;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoInputConsultaFascicolo;
	/**
	 * Il servizio consente di consultare il fascicolo sanitario elettronico di un cittadino identificato presente in Anagrafe Regionale e validato MEF.
	 * @author Marco Salonia
	 * 
	 */	
	public class AbstractConsultaFascicolo extends AbstractServiceSEB
	{
		public function AbstractConsultaFascicolo()
		{
			super();
		}
		/**
		 * @param vo l'input VoInputConsultaFascicolo con i dati di ricerca 
		 */ 		

		virtual public function execute(vo:VoInputConsultaFascicolo):void
		{
			throw new SebException("Virtual Method",SebException.IMPL_ERROR);
		}
	}
}
