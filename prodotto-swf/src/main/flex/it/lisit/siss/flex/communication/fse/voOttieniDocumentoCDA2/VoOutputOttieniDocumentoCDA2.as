package it.lisit.siss.flex.communication.fse.voOttieniDocumentoCDA2
{
	import it.lisit.siss.flex.communication.ValueObject;

	public class VoOutputOttieniDocumentoCDA2 extends ValueObject
	{
		public function VoOutputOttieniDocumentoCDA2()
		{
			super();
		}
		/**
		 * Indica se la pubblicazione è andata a buon fine o meno 
		 */		
		public var esito:String;
		
	}
}