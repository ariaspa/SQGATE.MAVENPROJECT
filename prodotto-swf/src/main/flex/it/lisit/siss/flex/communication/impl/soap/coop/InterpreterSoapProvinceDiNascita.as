package it.lisit.siss.flex.communication.impl.soap.coop
{
	import it.lisit.siss.flex.communication.ValueObject;
	import it.lisit.siss.flex.communication.impl.soap.IInterpreterSoap;
	import it.lisit.siss.flex.utility.xml.XPathUtility;

	internal class InterpreterSoapProvinceDiNascita implements IInterpreterSoap
	{
		public function InterpreterSoapProvinceDiNascita()
		{
		}
		public function toXmlInput(vo:ValueObject=null):XML
		{
			// la querry utilizzata dal servizio su pdl LDB.executeStatement per raccogliere le province
			var strQueryProvincie:String = "SELECT COD_PROV,DESC_DPROV FROM province order by DESC_DPROV;";
			var input:XML	= XML_REQUEST_LDB.copy();
			XPathUtility.setNodeValue(input, "//statement", strQueryProvincie);
			return input;
		}
		
		public function toVoOutput(body:XML=null):ValueObject
		{
			return new ParserProvinceDiNascita(body).execute();
		}
		public function getNameService():String
		{
			return "provinceDiNascita";
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