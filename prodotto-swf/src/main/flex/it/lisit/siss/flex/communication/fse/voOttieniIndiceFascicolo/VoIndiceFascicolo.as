package it.lisit.siss.flex.communication.fse.voOttieniIndiceFascicolo
{
	import it.lisit.siss.flex.communication.ValueObject;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoListaFolder;

	public class VoIndiceFascicolo extends ValueObject
	{
		/**
		 * Definizione:		Struttura dati contenente la struttura dei folder che costituiscono il fascicolo o parte di esso e relativo al cittadino specificato
		 * Obbligatorietà:	SI
		 */		
		public var listaFolder:VoListaFolder;
		
		public function VoIndiceFascicolo()
		{
			super();
		}
		
	}
}