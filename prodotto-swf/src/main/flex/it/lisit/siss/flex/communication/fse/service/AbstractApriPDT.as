package it.lisit.siss.flex.communication.fse.service
{
	import it.lisit.siss.flex.communication.AbstractServiceSEB;
	import it.lisit.siss.flex.communication.exception.SebException;
	import it.lisit.siss.flex.communication.fse.voApriPDT.VoInputApriPDT;
	/**
	 * Il servizio registra nella base dati del Domino Centrale le informazioni relative ad una comunicazione 
	 * di apertura di un Percorso Diagnostico Terapeutico di una specifica patologia e relativo ad un cittadino 
	 * su cui si può aprire un Fascicolo Sanitario Elettronico
	 * L’apertura di un PDT è consentita ad un qualsiasi operatore sanitario che ha accesso al fascicolo sanitario elettronico. 
	 * L’invocazione del metodo causa la generazione e richiesta di firma del documento 
	 * che attesta l’apertura del PDT, da parte dell’operatore.
	 * 
	 * Controlli che generano eccezioni
	 * 
	 * Controlli di accesso al servizio:
	 * 		Operatore non autorizzato o non valido
	 * Messaggi previsti:
	 * 1.EA0001 – Operatore non abilitato al servizio;
	 * 2.EA0002 – Contesto operatore non valido;. 
	 * 
	 * 		Attributi obbligatori mancanti, valori obbligatori mancanti, formato dati non corretto
	 * Messaggi previsti:
	 * 		dati non presenti in anagrafica (nel caso di dati riferiti a tabelle anagrafiche)
	 * Messaggi previsti:
	 * 3. EA0004 – ED0002 - Dato input non valido – Codice non valido;
	 * 	
	 * Controlli relativi agli operatori e strutture:
	 * 		Informazioni in input formalmente non valide
	 * Messaggi previsti:
	 * 4.EA0004-ED0002 – Dato input non valido – – Dato input non valido – idCittadino, idComuneNascita, idPatologia
	 * 
	 * Controlli relativi all’evento
	 * 		Informazioni in input formalmente non valide
	 * 		Comunicazione  non effettuata correttamente
	 * 
	 * Messaggi previsti:
	 * 5.EA0012- Errore Interno
	 * 
	 * @author Marco Salonia
	 * 
	 */	
	public class AbstractApriPDT extends AbstractServiceSEB
	{
		public function AbstractApriPDT()
		{
			super();
		}
		/**
		 * @param vo l'input VoInputApriPDT con i dati di ricerca 
		 */ 		
		virtual public function execute(vo:VoInputApriPDT):void
		{
			throw new SebException("Virtual Method",SebException.IMPL_ERROR);
		}
	}
}