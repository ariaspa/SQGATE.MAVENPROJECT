package it.lisit.siss.flex.communication.fse.voCancellaDCEDaFolder
{
	import it.lisit.siss.flex.communication.ValueObject;

	public class VoOutputCancellaDCEDaFolder extends ValueObject
	{
		/**
		 * Indica se la cancellazione del DCE è andata a buon fine o meno
		 * "OK" 
		 */		
		public var esitoCancellaDCEDaFolder:String;
		public function VoOutputCancellaDCEDaFolder()
		{
			super();
		}
		
	}
}