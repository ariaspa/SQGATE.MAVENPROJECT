package it.lisit.siss.flex.communication.event
{
	import it.lisit.siss.flex.communication.ValueObject;
	/**
	 * Elemento distintivo di una risposta negativa
	 * Non deve mai essere presente nell’ambito una risposta positiva 
	 * È presente in caso di esito negativo
	 * @author marco
	 * 
	 */	
	public class VoEsitoNegativo extends ValueObject
	{
		/**
		 * Il codice dell’errore definito dall’Aderente Espositore del servizio
		 * Stringa alfanumerica
		 * Obbligatorio - Si.
		 */		
		public var codiceErrore:String;
		/**
		 * Il messaggio di errore 
		 * Stringa alfanumerica che descrive l’errore applicativo “contestualizzato”. 
		 * Il messaggio deve essere tale da poter essere presentato all’utilizzatore finale (operatore) 
		 * fornendo una chiara ed esaustiva descrizione del problema riscontrato e, 
		 * dove possibile, dell’azione da intraprendere.
		 * Il messaggio deve essere tale da non necessitare l’analisi/comprensione/visualizzazione dei dettagli 
		 * che, per loro natura, sono finalizzati alla bug identification.
		 * Obbligatorio - Si.
		 */		
		public var descErrore:String;
		/**
		 * La lista eccezioni associato a questo esito negativo 
		 */		
		public var listaEccezioni:VoListaEccezioni;
		/**
		 * Una struttura contenente dettagli relativi all’errore non rappresentabili 
		 * dalla struttura standard "eccezione". 
		 * Il contenuto è spiegato nella descrizione del singolo metodo.
		 * L’utilizzo di questo elemento “customizzabile” deve essere limitato al trasporto 
		 * di informazioni aggiuntive che non trovano una corretta collocazione 
		 * nei dettagli delle eccezioni.
		 * Essendo di natura variabile "dettaglio" viene valorizzato come un Object
		 * All'atto dell'implementazione sarà utile riportare il valore e la sua natura 
		 * restituita dal servizio integralmente e delegare all'utilizzatore il casting 
		 * e i metodi di lettura di "dettaglio"
		 * Obbligatorio - No.  
		 */		
		public var dettaglio:Object;
		public function VoEsitoNegativo()
		{
			super();
		}
		
	}
}