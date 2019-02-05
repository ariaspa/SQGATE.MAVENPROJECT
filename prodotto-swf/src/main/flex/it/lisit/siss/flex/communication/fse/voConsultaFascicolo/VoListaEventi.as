package it.lisit.siss.flex.communication.fse.voConsultaFascicolo
{
	import it.lisit.siss.flex.communication.ValueObject;
	import it.lisit.siss.flex.utility.IIterator;
	/**
	 * Strutta contenente la lista degli eventi specialistici proveniente dai flussi
	 * un iteratore permette di accedere alla lista degli eventi
	 * @author Marco Salonia
	 * 
	 */	
	public class VoListaEventi extends ValueObject
	{
		public function get iterator():IIterator
		{
			return null;
		}
		public function VoListaEventi()
		{
			super();
		}
	}
}