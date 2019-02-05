package it.lisit.siss.flex.communication.coop.service
{
	import it.lisit.siss.flex.communication.AbstractServiceSEB;

	/**
	 * Recupera le credenziali dell'operatore.
	 */
	public class AbstractServiceLeggiCredenziali extends AbstractServiceSEB 
	{
		public function AbstractServiceLeggiCredenziali()
		{
			super();
		}
		
		virtual public function getOperatore():void{}
	}
}