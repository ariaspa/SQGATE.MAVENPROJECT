package it.lisit.siss.flex.communication.fse.voConsultaFascicolo
{
	import it.lisit.siss.flex.communication.ValueObject;
	/**
	 * Struttura dati contenente gli eventi provenienti dai flussi 
	 * e non riconducibile alla struttura tipica del fascicolo in quanto incompleti.
	 * @author Marco Salonia
	 * 
	 */	
	public class VoEventi extends ValueObject
	{
		/**
		 * Strutta contenente la lista degli eventi specialistici proveniente dai flussi
		 * Obbligatorietà - SI
		 */		
		public var listaEventi:VoListaEventi;
		
		public function VoEventi()
		{
			super();
		}
		
	}
}