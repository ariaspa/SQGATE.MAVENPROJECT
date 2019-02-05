package it.lisit.siss.flex.communication.fse.voAutorizzaDce
{
	import it.lisit.siss.flex.communication.ValueObject;
	import it.lisit.siss.flex.utility.IIterator;

	public class VoAttributiSpecifici extends ValueObject
	{
		/**
		 * iteratore contenente VoPrestazione 
		 */		
		public var prestazioniAssociate:IIterator;
		//
		public var numeroPraticaPS:String;
		public var numeroNosologico:String;
		public var numeroPrericovero:String;
		
		public function VoAttributiSpecifici()
		{
			super();
		}
		
	}
}