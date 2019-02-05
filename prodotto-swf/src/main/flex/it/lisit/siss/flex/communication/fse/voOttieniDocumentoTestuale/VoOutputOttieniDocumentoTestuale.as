package it.lisit.siss.flex.communication.fse.voOttieniDocumentoTestuale
{
	import it.lisit.siss.flex.communication.ValueObject;

	public class VoOutputOttieniDocumentoTestuale extends ValueObject
	{
		/**
		 * Indica se la pubblicazione è andata a buon fine o meno 
		 */		
		public var esito:String;
		public function VoOutputOttieniDocumentoTestuale()
		{
			super();
		}
		
	}
}