package it.lisit.siss.flex.communication.fse.voConsultaFascicolo
{
	import it.lisit.siss.flex.communication.ClonableValueObject;
	import it.lisit.siss.flex.utility.IIterator;
	/**
	 * Struttura relativa alla lista delle prestazioni accettate 
	 * Contiene le prestazione in forma di VoPrestazione 
	 * mette a disposizione un iterator per ciclare sulla lista
	 * @author Marco Salonia
	 */	
	public class VoPrestazioniAssociate extends ClonableValueObject
	{
		public function VoPrestazioniAssociate()
		{
			super();
		}
		public function get iterator():IIterator
		{
			return null;
		}
	}
}