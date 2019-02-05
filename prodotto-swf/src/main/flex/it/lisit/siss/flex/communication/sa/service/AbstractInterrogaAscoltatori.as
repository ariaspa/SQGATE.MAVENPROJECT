package it.lisit.siss.flex.communication.sa.service
{
	import it.lisit.siss.flex.communication.AbstractServiceSEB;
	import it.lisit.siss.flex.communication.exception.SebException;
	import it.lisit.siss.flex.communication.sa.VoInterrogaAscoltatori.VoInputInterrogaAscoltatori;
	
	/**
	 * Il servizio permette agli Aderenti al SISS di ottenere, nell’ambito della gestione del meccanismo di Exit Routines, lo
	 * stato di registrazione al uno specifico evento di notifica/richiesta; tale metodo è indirizzato al Produttore degli eventi in
	 * modo da poter agire in modo discrezionale prima dell’eventuale generazione di un evento.
	 * 
	 * Regole di accesso al servizio
	 * L’applicazione chiamante deve sottoporre la richiesta localmente al PdL per cui genera gli eventi ed interroga gli
	 * ascoltatori. 
	*/
	
	public class AbstractInterrogaAscoltatori extends AbstractServiceSEB
	{
		public function AbstractInterrogaAscoltatori()
		{
			super();
		}
		/**
		 * @param vo l'input VoInputInterrogaAscoltatori con i dati di ricerca 
		 */
		public virtual function execute(vo:VoInputInterrogaAscoltatori):void {
			
			throw new SebException("Virtual Method",SebException.IMPL_ERROR);
		}
		
	}
}