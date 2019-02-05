package it.lisit.siss.flex.communication.fse.voConsultaFascicolo
{
	import it.lisit.siss.flex.communication.ClonableValueObject;
	import it.lisit.siss.flex.utility.IIterator;
	/**
	 * Struttura contenente la lista delle caratterizzazione cliniche associate al DCE
	 * Mette a disposizione un iterator per scorrere le caratterizzazioni
	 * Il metodo di clonatura clona la struttura  e tutti i dati contenuti	
	 * @author Marco Salonia
	 * 
	 */	
	public class VoCaratterizzazioniCliniche extends ClonableValueObject
	{
		public function VoCaratterizzazioniCliniche()
		{
			super();
		}
		public function get iterator():IIterator
		{
			return null;
		} 
	}
}