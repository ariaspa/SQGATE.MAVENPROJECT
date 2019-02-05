package it.lisit.siss.flex.communication.fse.voConsultaFascicolo
{
	import it.lisit.siss.flex.communication.ClonableValueObject;
	import it.lisit.siss.flex.utility.IIterator;
	/**
	 * Struttura contenente l’eventuale  lista di documenti allegati 
	 * al documento pubblicato, tipicamente trattasi di immagini
	 * fornisce un iteratore per scorrere la lista
	 * Il metodo di clone crea una nuova istanza
	 * con riferimento agli oggetti della lista clonati
	 * 
	 * @author Marco Salonia
	 */	
	public class VoListaAllegati extends ClonableValueObject
	{
		public function VoListaAllegati()
		{
			super();
		}
		public function get iterator():IIterator
		{
			return null;
		}
	}
}