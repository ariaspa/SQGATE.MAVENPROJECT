package it.lisit.siss.flex.communication.icce.voIdentificaCittadinoEsteso
{
	import it.lisit.siss.flex.communication.ValueObject;

	public class VoInputIdentificaCittadinoEsteso extends ValueObject
	{
		public var idAssistito:String;
		public var cognome:String;
		public var nome:String;
		public var codiceFiscale:String;
		public var dataNascita:String;
		public var idLocalitaNascita:String;
		public var codiceSesso:String;
		public var ricercaAnagraficaEstesa:String;
		public var omettiEsenzioni:String;
		//
		public var pageNumber:String;
		public var useWildcard:String;
		public var maxRecords:String;
		//
		public function VoInputIdentificaCittadinoEsteso()
		{
			super();
		}
	}
}