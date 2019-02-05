package it.lisit.siss.flex.communication.impl.soap.icce
{
	import it.lisit.siss.flex.communication.ValueObject;
	import it.lisit.siss.flex.communication.icce.voIdentificaCittadinoCarta.VoOutputIdentificaCittadinoCarta2008_01;
	import it.lisit.siss.flex.communication.impl.soap.IInterpreterSoap;
	import it.lisit.siss.flex.utility.xml.XPathUtility;

	public class ISIdentificaCittadinoCarta implements IInterpreterSoap
	{
		public function ISIdentificaCittadinoCarta()
		{
		}

		public function toXmlInput(vo:ValueObject=null):XML
		{
			return XML_REQUEST_ICCE_IDENTIFICA_CITTADINO_CARTA_2008_01.copy();
		}
		
		public function toVoOutput(body:XML=null):ValueObject
		{
			var output:VoOutputIdentificaCittadinoCarta2008_01 	= new VoOutputIdentificaCittadinoCarta2008_01();
			var rSingola:XMLList								= XPathUtility.getNodeList(body,"//rispostaCittadinoIdentificato" );
			var parserSingola:ParserSingola						= new ParserSingola( rSingola[0] );
			output.datiCittadino	= parserSingola.datiCittadino();
			output.datiMedico		= parserSingola.datiMedico();
			output.datiTesserino	= parserSingola.datiTesserino();
			output.esenzioniGodute	= parserSingola.esenzioniGodute();
			output.esitoServizio	= parserSingola.esitoServizio();
			return output;
		}
		public function getNameService():String
		{
			return "ICCE.identificaCittadinoCarta";
		}
		public function getQNameResponse():QName
		{
			return new QName("http://www.crs.lombardia.it/schemas/NAR/ICCE/2008-01/identificaCittadinoCarta/","ICCE.identificaCittadinoCartaResponse");
		}
		private const XML_REQUEST_ICCE_IDENTIFICA_CITTADINO_CARTA_2008_01:XML = 
	    <SOAP-ENV:Envelope SOAP-ENV:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/" 
	    xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/" 
	    xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" 
	    xmlns:xsd="http://www.w3.org/1999/XMLSchema" xmlns:xsi="http://www.w3.org/1999/XMLSchema-instance">
		  <SOAP-ENV:Body>
				<m:ICCE.identificaCittadinoCarta xmlns:m="http://www.crs.lombardia.it/schemas/NAR/ICCE/2008-01/identificaCittadinoCarta/" dataSetVersion="1.0">
					<param/>
				</m:ICCE.identificaCittadinoCarta>
		  </SOAP-ENV:Body>
		</SOAP-ENV:Envelope>;
	}
}