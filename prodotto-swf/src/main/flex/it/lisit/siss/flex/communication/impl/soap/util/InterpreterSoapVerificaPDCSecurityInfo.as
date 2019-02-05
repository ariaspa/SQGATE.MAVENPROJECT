package it.lisit.siss.flex.communication.impl.soap.util
{
	import it.lisit.siss.flex.communication.impl.soap.IInterpreterSoap;
	import it.lisit.siss.flex.communication.ValueObject;

	public class InterpreterSoapVerificaPDCSecurityInfo implements IInterpreterSoap
	{
		private const XML_REQUEST_VERIFICA_PDC_SECURITY_INFO:XML =
		<SOAP-ENV:Envelope SOAP-ENV:encodingStyle="http://schemas.xmlsoap.org/soap/encoding" xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/">
			<SOAP-ENV:Body>
				<UTIL.verificaPDCSecurityInfo>
					<param/>
				</UTIL.verificaPDCSecurityInfo>
			</SOAP-ENV:Body>
		</SOAP-ENV:Envelope>;
		
		public function InterpreterSoapVerificaPDCSecurityInfo()
		{
		}

		public function toXmlInput(vo:ValueObject=null):XML
		{
			return XML_REQUEST_VERIFICA_PDC_SECURITY_INFO;
		}
		public function toVoOutput(body:XML=null):ValueObject
		{
			return new ParserVerificaPDCSecurityInfo().execute(body);
		}
		public function getNameService():String
		{
			return "UTIL.verificaPDCSecurityInfo";
		}
		public function getQNameResponse():QName
		{
			return new QName("", "UTIL.verificaPDCSecurityInfoResponse");
		}
		 
	}
}