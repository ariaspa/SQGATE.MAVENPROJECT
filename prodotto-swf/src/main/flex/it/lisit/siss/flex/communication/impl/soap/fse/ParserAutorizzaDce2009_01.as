package it.lisit.siss.flex.communication.impl.soap.fse
{
	import it.lisit.siss.flex.communication.fse.voAutorizzaDce.VoOutputAutorizzaDce;
	
	internal class ParserAutorizzaDce2009_01
	{
		public function ParserAutorizzaDce2009_01()
		{
		}
		public function execute(xml:XML):VoOutputAutorizzaDce
		{
			var output:VoOutputAutorizzaDce = new VoOutputAutorizzaDce();
			var esit:XMLList = xml.child( "esitoAutorizzaDCE" );
			if(esit!=null && esit.length()>0)
			{
				output.esito			= esit[0].child( "esito");
				output.idSetDocumenti	= esit[0].child( "idSetDocumenti");
			}
			return output;
		}
	}
}