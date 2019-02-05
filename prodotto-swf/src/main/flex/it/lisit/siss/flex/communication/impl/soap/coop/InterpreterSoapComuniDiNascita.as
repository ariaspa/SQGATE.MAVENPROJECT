package it.lisit.siss.flex.communication.impl.soap.coop
{
	import it.lisit.siss.flex.communication.ValueObject;
	import it.lisit.siss.flex.communication.impl.soap.IInterpreterSoap;
	import it.lisit.siss.flex.utility.xml.XPathUtility;

	public class InterpreterSoapComuniDiNascita implements IInterpreterSoap
	{
		public function InterpreterSoapComuniDiNascita()
		{
		}

		public function toXmlInput(vo:ValueObject=null):XML
		{
			var codiceProvincia:String 	= Object(vo).codiceProvincia;
			var strQueryComuni:String 	= "SELECT COD_CCOMU, DESC_DCOMU FROM comuni WHERE COD_PROV='"+codiceProvincia+"' ORDER BY DESC_DCOMU;";
			var input:XML				= XML_REQUEST_LDB.copy();
			XPathUtility.setNodeValue(input, "//statement", strQueryComuni);
			return input;
		}
		
		public function toVoOutput(body:XML=null):ValueObject
		{
			return new ParserComuniDiNascita( body ).execute();
		}
		
		public function getNameService():String
		{
			return "comuniDiNascita";
		}
		
		public function getQNameResponse():QName
		{
			return new QName("","LDB.executeStatementResponse");
		}
		private var XML_REQUEST_LDB:XML = 
		<SOAP-ENV:Envelope SOAP-ENV:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/" xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/">
			<SOAP-ENV:Body>
				<LDB.executeStatement>
					<param>
						<listQuery>
							<query>
								<idQuery>1</idQuery>
								<statement/>
							</query>
						</listQuery>
					</param>
				</LDB.executeStatement>
			</SOAP-ENV:Body>
		</SOAP-ENV:Envelope>;
	}
}