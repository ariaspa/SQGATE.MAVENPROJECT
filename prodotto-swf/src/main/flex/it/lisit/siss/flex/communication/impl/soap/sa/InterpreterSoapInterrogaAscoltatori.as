package it.lisit.siss.flex.communication.impl.soap.sa
{
	import it.lisit.siss.flex.communication.ValueObject;
	import it.lisit.siss.flex.communication.exception.SebException;
	import it.lisit.siss.flex.communication.impl.soap.IInterpreterSoap;
	import it.lisit.siss.flex.communication.sa.VoInterrogaAscoltatori.VoInputInterrogaAscoltatori;
	import it.lisit.siss.flex.utility.xml.XPathUtility;

	internal class InterpreterSoapInterrogaAscoltatori implements IInterpreterSoap
	{
		public function InterpreterSoapInterrogaAscoltatori()
		{
		}

		public function toXmlInput(vo:ValueObject=null):XML
		{
			var interpAscol:XML = INPUT_InterAsc.copy();
			var input:VoInputInterrogaAscoltatori;
			try 
			{
				input = vo as VoInputInterrogaAscoltatori;
			} catch (e:Error) {
				throw new SebException("ValueObject non di tipo VoInputInterrogaAscoltatori",SebException.FSE_ERROR);
			}
			if (input.nomeMetodo == null || input.nomeMetodo.length == 0)
				throw new SebException("il VoInputInterrogaAscoltatori.nomeMetodo non contiene un valore corretto", SebException.FSE_ERROR);
			XPathUtility.setNodeValue(interpAscol, "//nomeMetodo", input.nomeMetodo);
			
			if (input.nameSpace == null || input.nameSpace.length == 0)
				throw new SebException("il VoInputInterrogaAscoltatori.nameSpace non contiene un valore corretto", SebException.FSE_ERROR);
			XPathUtility.setNodeValue(interpAscol, "//nameSpace", input.nameSpace);
				
			return interpAscol;
		}
		
		public function toVoOutput(body:XML=null):ValueObject
		{
			return new ParserInterrogaAscoltatori(body).execute();
		}
		
		public function getNameService():String
		{
			return "SA.interrogaAscoltatori";
		}
		
		public function getQNameResponse():QName
		{
			return new QName("http://www.crs.lombardia.it/schemas/mw/2008-01/interrogaAscoltatori/", "SA.interrogaAscoltatoriResponse");
		}
		
		private const INPUT_InterAsc:XML = <SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" 
			xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/" 
			xmlns:xsd="http://www.w3.org/1999/XMLSchema" 
			xmlns:xsi="http://www.w3.org/1999/XMLSchema-instance" 
			SOAP-ENV:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">
				<SOAP-ENV:Body>
					<m:SA.interrogaAscoltatori xmlns:m="http://www.crs.lombardia.it/schemas/mw/2008-01/interrogaAscoltatori/" dataSetVersion="1.0">
						<param>
	  						<nomeMetodo></nomeMetodo> 
	  						<nameSpace></nameSpace>
  						</param>
  					</m:SA.interrogaAscoltatori>
				</SOAP-ENV:Body>
			</SOAP-ENV:Envelope>;
		
	}
}