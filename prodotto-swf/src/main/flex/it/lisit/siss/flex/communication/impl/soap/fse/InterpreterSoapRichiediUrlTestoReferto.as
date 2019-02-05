package it.lisit.siss.flex.communication.impl.soap.fse
{
	import it.lisit.siss.flex.communication.ValueObject;
	import it.lisit.siss.flex.communication.exception.SebException;
	import it.lisit.siss.flex.communication.fse.voRichiediUrlTestoReferto.VoInputRichiediUrlTestoReferto;
	import it.lisit.siss.flex.communication.impl.soap.IInterpreterSoap;
	import it.lisit.siss.flex.utility.xml.XPathUtility;

	public class InterpreterSoapRichiediUrlTestoReferto implements IInterpreterSoap
	{
		public function InterpreterSoapRichiediUrlTestoReferto()
		{
		}

		public function toXmlInput(vo:ValueObject=null):XML
		{
			var xml:XML = INPUT_RICHIEDIURLTESTOREFERTO.copy();
			var input:VoInputRichiediUrlTestoReferto;
			try
			{
				input = vo as VoInputRichiediUrlTestoReferto;
			}
			catch(e:Error)
			{
				throw new SebException("ValueObject non di tipo VoInputRichiediUrlTestoReferto", SebException.FSE_ERROR);
			}

			if (input.codiceFiscale.length == 0)
			{
				throw new SebException("VoInputRichiediUrlTestoReferto.codiceFiscale non valido", SebException.FSE_ERROR);
			}
			XPathUtility.setNodeValue(xml, "//codiceFiscale", input.codiceFiscale);

			if (input.uri.length == 0)
			{
				throw new SebException("VoInputRichiediUrlTestoReferto.uri non valido", SebException.FSE_ERROR);
			}
			XPathUtility.setAttributeValueIntoNode(xml, "//Request", "recipient", input.uri.substring(0, input.uri.indexOf(".")));
			XPathUtility.setAttributeValueIntoNode(xml, "//Request", "applicationIdentifier", input.uri.substring(input.uri.indexOf(".")+1, input.uri.lastIndexOf(".")));
			XPathUtility.setNodeValue(xml, "//URI", input.uri);

			if (input.flagDocumentoFirmato.length == 0)
			{
				throw new SebException("VoInputRichiediUrlTestoReferto.flagDocumentoFirmato non valido",SebException.FSE_ERROR);
			}
			XPathUtility.setNodeValue(xml, "//flagDocumentoFirmato", input.flagDocumentoFirmato);

			if (input.flagCDA2.length == 0)
			{
				throw new SebException("VoInputRichiediUrlTestoReferto.flagCDA2 non valido",SebException.FSE_ERROR);
			}
			XPathUtility.setNodeValue(xml, "//flagCDA2", input.flagCDA2);

			return xml;
		}

		public function toVoOutput(body:XML=null):ValueObject
		{
			return new ParseRichiediUrlTestoReferto(body).execute();
		}

		public function getNameService():String
		{
			return "FSE.visualizzaTestoReferto";
		}

		public function getQNameResponse():QName
		{
			return new QName("http://www.crs.lombardia.it/schemas/CRS-SISS/FSE/2014-01/visualizzaTestoReferto/", "FSE.visualizzaTestoReferto");
		}

		private const INPUT_RICHIEDIURLTESTOREFERTO:XML = <soap-env:Envelope xmlns:soap-env="http://schemas.xmlsoap.org/soap/envelope/"
			xmlns:xsi="http://www.w3.org/1999/XMLSchema-instance"
			xmlns:xsd="http://www.w3.org/1999/XMLSchema"
			xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/"
			soap-env:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">
				<soap-env:Header>
					<a:AppContext xmlns:a="http://www.crs.lombardia.it/schemas/mw/2004-01/appcontext/">
			   			<Request recipient="" applicationType="REPOSITORY" applicationIdentifier="" clientProd="" clientVer="" />
					</a:AppContext>
				</soap-env:Header>
				<soap-env:Body>
					<m:FSE.visualizzaTestoReferto
						xmlns:m="http://www.crs.lombardia.it/schemas/CRS-SISS/FSE/2014-01/visualizzaTestoReferto/"
						dataSetVersion="1.0">
						<param>
							<dati>
							    <codiceFiscaleOperatoreSAMWEB>NOCALLSSO</codiceFiscaleOperatoreSAMWEB>
								<codiceFiscale></codiceFiscale>
								<URI></URI>
								<flagDocumentoFirmato></flagDocumentoFirmato>
								<flagCDA2></flagCDA2>
							</dati>
						</param>
					</m:FSE.visualizzaTestoReferto>
				</soap-env:Body>
			</soap-env:Envelope>;
	}
}