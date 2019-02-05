package it.lisit.siss.flex.communication.event
{
	import it.lisit.siss.flex.communication.ValueObject;

	public class VoFaultDetail extends ValueObject
	{
		/**
		 * Stringa alfanumerica.
		 * Restituisce un codice di errore definito nel dominio dell’applicazione dell’Espositore.
		 * Poiché i Fault possono essere generati sia da componenti architetturali del CRS-SISS 
		 * sia dall’aderente espositore stesso, i codici di errore restituiti sono:
		 * Errori descritti nel documento CRS-ISAU-SIAU#56, 
		 * quando generati da componenti architetturali del CRS-SISS;		
		 * Obbligatorio Si.
		 */		
		public var errorCode:String;
		
		/**
		 * Quando si rileva una eccezione in uno strato SW generalmente, 
		 * man mano che si risale negli strati di ordine superiore, 
		 * si sostituiscono il codice di errore e la descrizione con informazioni 
		 * che sfruttano la consapevolezza del contesto applicativo in corso. 
		 * Un errore di apertura di una connessione di rete, ad esempio, 
		 * può essere contestualizzata precisando che si è verificata 
		 * nell’ambito della registrazione di una prescrizione.
		 * Per tale motivo, ogni volta che il CRS-SISS esegue una rimappatura dell’errore 
		 * ai fini di una contestualizzazione, viene inserito “in testa” (stack) 
		 * la concatenazione di errorCode e faultstring (separati dal carattere “:”) 
		 * che saranno sostituiti dai codice/descrizione ri-contestualizzati.
		 * La finalità di questi elementi è limitata alla “bug identification” 
		 * e non è richiesta un’elaborazione specifica da parte del Fruitore.
		 * 
		 * Stringhe alfanumeriche.
		 * La stringa, di tipo descrittivo e non strutturato, 
		 * deve essere generata concatenando gli errorCode e faultstring 
		 * sostituiti al valore di quelli “contestualizzati”.
		 * L’inserimento deve avvenire con logica “stack”, 
		 * cioè l’ultimo elemento inserito deve comparire come primo elemento 
		 * della sequenza di elementi errorStack.
		 *  
		 * Obbligatorio Si. deve essere presente almeno un index array 
		 */		
		public var errorStack:String;
		//
		public function VoFaultDetail()
		{
			super();
		}
		
	}
}