package it.lisit.siss.flex.communication.fse.voConsultaFascicolo
{
	import it.lisit.siss.flex.communication.ClonableValueObject;
	/**
	 * Tutti i tipi di attributi specifici dce ereditano da questa classe 
	 * @author Marco Salonia;
	 * 
	 */	
	public class VoAttributiSpecificiDCE extends ClonableValueObject
	{
		/**
		 * Indica il tipo di attributi specifici
		 * per permettere il cast adeguato
		 * Quando indica -1, il tipo è sconosciuto.
		 */		
		public function get type():int
		{
			return -1;
		}
		public function VoAttributiSpecificiDCE()
		{
			super();
		}
		
	}
}