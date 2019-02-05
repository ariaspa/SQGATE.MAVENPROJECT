package it.lisit.siss.flex.communication.impl.soap.crm
{
	import it.lisit.siss.flex.communication.ValueObject;
	import it.lisit.siss.flex.communication.crm.voTestoReferto.VoInputTestoReferto;
	import it.lisit.siss.flex.communication.crm.voTestoReferto.VoOutputTestoreferto;
	import it.lisit.siss.flex.communication.impl.soap.IInterpreterSoap;
	import it.lisit.siss.flex.utility.xml.XPathUtility;

	internal class InterpreterTestoReferto implements IInterpreterSoap
	{
		public function InterpreterTestoReferto()
		{
		}

		public function toXmlInput(vo:ValueObject=null):XML
		{
			var copy:XML	= XML_CRM_VISUALIZZA_TESTO_REFERTO.copy();
			XPathUtility.setNodeValue(copy,"//codiceFiscale", VoInputTestoReferto(vo).codiceFiscale); 
	  		XPathUtility.setNodeValue(copy,"//linkReferto", VoInputTestoReferto(vo).linkReferto);
			return copy;
		}
		
		public function toVoOutput(body:XML=null):ValueObject
		{
			var output:VoOutputTestoreferto = new VoOutputTestoreferto();
			output.testoReferto 		= XPathUtility.getNodeValue(body ,"//testoReferto");
			output.descTipoTestoReferto = XPathUtility.getNodeValue(body, "//descTipoTestoReferto");
			return output;
		}
		
		public function getNameService():String
		{
			return "CRM.visualizzaTestoReferto";
		}
		
		public function getQNameResponse():QName
		{
			return new QName("http://www.crs.lombardia.it/schemas/CRS-SISS/CRM/2005-01/visualizzaTestoReferto/","CRM.visualizzaTestoRefertoResponse");
		}
		
		private const XML_CRM_VISUALIZZA_TESTO_REFERTO:XML =
		<SOAP-ENV:Envelope SOAP-ENV:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/" 
		xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" 
		xmlns:xsi="http://www.w3.org/1999/XMLSchema-instance" 
		xmlns:xsd="http://www.w3.org/1999/XMLSchema" 
		xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/">
			<SOAP-ENV:Header>
				<!--
				<a:AppContext xmlns:a="http://www.crs.lombardia.it/schemas/mw/2004-01/appcontext/">
					<Request clientProd="CRM" clientVer="1.0" recipient="" applicationType="" applicationIdentifier=""/>
				</a:AppContext>
				-->
			</SOAP-ENV:Header>
			<SOAP-ENV:Body>
				<m:CRM.visualizzaTestoReferto dataSetVersion="1.0" xmlns:m="http://www.crs.lombardia.it/schemas/CRS-SISS/CRM/2005-01/visualizzaTestoReferto/">
					<param>
						<dati>
							<codiceFiscale/>
							<linkReferto/>
						</dati>
					</param>
				</m:CRM.visualizzaTestoReferto>
			</SOAP-ENV:Body>
		</SOAP-ENV:Envelope>;
	}
}