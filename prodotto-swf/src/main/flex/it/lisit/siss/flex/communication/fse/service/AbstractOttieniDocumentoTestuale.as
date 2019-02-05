package it.lisit.siss.flex.communication.fse.service
{
	import it.lisit.siss.flex.communication.AbstractServiceSEB;
	import it.lisit.siss.flex.communication.exception.SebException;
	import it.lisit.siss.flex.communication.fse.voOttieniDocumentoTestuale.VoInputOttieniDocumentoTestuale;
	
	/**
	 * 
	 * Il servizio consente ad un aderente di registrare all’interno della sua cartella clinica il formato testuale 
	 * documento clinico elettronico (DCE) presente nel Fascicolo Sanitario Elettronico. 
	 * Il processo all’interno del quale si inserisce il corrente servizio è il seguente:
	 * - Un’ applicazione di consultazione Fascicolo (WEBSISS) presenta la visualizzazione di un DCE relativo 
	 * ad un cittadino selezionato
	 * - Websiss, su richiesta dell’operatore, invoca il servizio ottieniDocumentoTestuale 
	 * offerto dalla Cartella Clinica per registrare il documento in chiaro negli archivi della stessa Cartella Clinica.
	 * - I dati specificati per il servizio sono :
	 * 		- Il codice fiscale del cittadino
	 * 		- tutti i metadati che caratterizzano il documento
	 * 		- il contenuto del DCE testuale in chiaro (non firmato) in B64
	 * 
	 * L’exit routine in oggetto è sincrona con timeout uguale a 10 secondi, pertanto è prevista una risposta SOAP.
	 * 
	 * 
	 * @author Salvatore Civiletto
	 * 
	 */	

	public class AbstractOttieniDocumentoTestuale extends AbstractServiceSEB
	{
		public function AbstractOttieniDocumentoTestuale()
		{
			super();
		}
		
		/**
		 * @param vo l'input VoInputOttieniDocumentoTestuale con i dati di ricerca 
		 */ 	
		virtual public function execute(vo:VoInputOttieniDocumentoTestuale):void
		{
			throw new SebException("Virtual Method",SebException.IMPL_ERROR);	
		}
		
	}
}