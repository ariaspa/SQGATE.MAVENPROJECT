package it.lisit.siss.flex.communication.fse.voConsultaFascicolo
{
	import it.lisit.siss.flex.communication.ClonableValueObject;
	import it.lisit.siss.flex.utility.IIterator;
	/**
	 * VoListaDCE contiene la lista dei VoSetDocumentale
	 * E' un'oggetto clonabile, ogni oggetto di tipo VoSetDocumentale
	 * contenuto in questo oggetto VoListaDCE verrà clonato a sua volta
	 * creando quindi a tutti gli effetti una copia ma con riferimenti diversi
	 * Contiene una proprietà iterator per scorrere la lista dei VoSetDocumentale
	 * @author Marco Salonia 
	 */	
	public class VoListaDCE extends ClonableValueObject
	{
		public function VoListaDCE()
		{
			super();
		}
		public function get iterator():IIterator
		{
			return null;
		}
	}
}