package it.lisit.siss.flex.communication.impl.soap.crm
{
	import it.lisit.siss.flex.communication.ValueObject;
	import it.lisit.siss.flex.communication.crm.voRichiediURLImagine.VoInputRichiediURLImmagine;
	import it.lisit.siss.flex.communication.crm.voRichiediURLImagine.VoOutputRichiediURLImmagine;
	import it.lisit.siss.flex.communication.exception.SebException;
	import it.lisit.siss.flex.communication.impl.soap.IInterpreterSoap;
	import it.lisit.siss.flex.utility.xml.XPathUtility;

	public class InterpreterRichiediURLImmagine implements IInterpreterSoap
	{
		public function InterpreterRichiediURLImmagine()
		{
		}

		public function toXmlInput(vo:ValueObject=null):XML
		{
			var copy:XML	= XML_CRM_RICHIEDI_URL_IMMAGINE.copy();
			var input:VoInputRichiediURLImmagine;
			try{
				input = vo as VoInputRichiediURLImmagine;
			}catch(e:Error)
			{
				throw new SebException("ValueObject non di tipo VoInputRichiediURLImmagine",SebException.FSE_ERROR);
			}
			if(input.linkReferto == null || input.linkReferto.length == 0)
			{
				throw new SebException("VoInputRichiediURLImmagine.linkReferto non valido",SebException.FSE_ERROR);
			}
			XPathUtility.setAttributeValueIntoNode(copy, "//Request", "recipient", input.linkReferto.substring(0, input.linkReferto.indexOf(".")));
			XPathUtility.setAttributeValueIntoNode(copy, "//Request", "applicationIdentifier", input.linkReferto.substring(input.linkReferto.indexOf(".")+1, input.linkReferto.lastIndexOf(".")));
			XPathUtility.setNodeValue(copy, "//linkReferto", input.linkReferto);
			if (input.codiceFiscale == null || input.codiceFiscale.length == 0)
			{
				throw new SebException("VoInputRichiediURLImmagine.codiceFiscale non valido",SebException.FSE_ERROR);
			}
			XPathUtility.setNodeValue(copy, "//codiceFiscale", input.codiceFiscale);
			if (input.linkImmagine == null || input.linkImmagine.length == 0)
			{
				throw new SebException("VoInputRichiediURLImmagine.linkImmagine non valido",SebException.FSE_ERROR);
			}
			XPathUtility.setNodeValue(copy, "//linkImmagine", input.linkImmagine);
			if (input.tipoImmagine == null || input.tipoImmagine.length == 0)
			{
				throw new SebException("VoInputRichiediURLImmagine.tipoImmagine non valido",SebException.FSE_ERROR);
			}
			XPathUtility.setNodeValue(copy, "//tipoImmagine", input.tipoImmagine);
			
			return copy;
		}
		
		public function toVoOutput(body:XML=null):ValueObject
		{
			var output:VoOutputRichiediURLImmagine = new VoOutputRichiediURLImmagine();
			output.codiceFiscale = XPathUtility.getNodeValue(body, "//codiceFiscale");
			output.linkImmagine = XPathUtility.getNodeValue(body, "//linkImmagine");
			output.linkReferto = XPathUtility.getNodeValue(body, "//linkReferto");
			output.tipoImmagine = XPathUtility.getNodeValue(body, "//tipoImmagine");
			output.urlImmagine = XPathUtility.getNodeValue(body, "//URLimmagine");
			return output;
		}
		
		public function getNameService():String
		{
			return "CRM.richiediURLimmagine";
		}
		
		public function getQNameResponse():QName
		{
			return new QName("http://www.crs.lombardia.it/schemas/CRS-SISS/CRM/2005-01/richiediURLimmagine/","CRM.richiediURLimmagineResponse");
		}
		
		private const XML_CRM_RICHIEDI_URL_IMMAGINE:XML =
		<SOAP-ENV:Envelope SOAP-ENV:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/" 
		xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" 
		xmlns:xsi="http://www.w3.org/1999/XMLSchema-instance" 
		xmlns:xsd="http://www.w3.org/1999/XMLSchema" 
		xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/">
			<SOAP-ENV:Header>
				<a:AppContext xmlns:a="http://www.crs.lombardia.it/schemas/mw/2004-01/appcontext/">
				   <Request 
				     recipient=""
				     applicationType="REPOSITORY" 
				     applicationIdentifier="" 
				     clientProd="" 
				     clientVer="" 
				   />
				</a:AppContext>
			</SOAP-ENV:Header>
			<SOAP-ENV:Body>
				<m:CRM.richiediURLimmagine 
					xmlns:m="http://www.crs.lombardia.it/schemas/CRS-SISS/CRM/2005-01/richiediURLimmagine/"
					dataSetVersion="1.0">
				  <param>
				    <dati>
						<richiestaURLimmagine>
							<codiceFiscale></codiceFiscale>
							<linkReferto></linkReferto >
							<linkImmagine></linkImmagine>
							<tipoImmagine></tipoImmagine>
						</richiestaURLimmagine>
					</dati>
				  </param>
				</m:CRM.richiediURLimmagine>
			</SOAP-ENV:Body>
		</SOAP-ENV:Envelope>;
	}
}