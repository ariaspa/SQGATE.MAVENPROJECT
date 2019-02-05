package it.lisit.siss.flex.communication.impl.soap.fse
{
	import it.lisit.siss.flex.communication.ValueObject;
	import it.lisit.siss.flex.communication.exception.SebException;
	import it.lisit.siss.flex.communication.fse.voConsultaStoricoDCE.VoInputConsultaStoricoDCE;
	import it.lisit.siss.flex.communication.impl.soap.IInterpreterSoap;
	import it.lisit.siss.flex.utility.xml.XPathUtility;

	internal class InterpreterSoapConsultaStoricoDCE implements IInterpreterSoap
	{
		public function InterpreterSoapConsultaStoricoDCE()
		{
		}

		public function toXmlInput(vo:ValueObject=null):XML
		{
			var consultaStorico:XML = INPUT_CONSULTA_STORICO.copy();
			var input:VoInputConsultaStoricoDCE;
			try{
				input = vo as VoInputConsultaStoricoDCE;
			}catch(e:Error)
			{
				throw new SebException("ValueObject non di tipo VoInputConsultaStoricoDCE",SebException.FSE_ERROR);
			}
			if(input.idCittadino == null || input.idCittadino.length==0)
			{
				throw new SebException("VoInputConsultaStoricoDCE.idCittadino non valido",SebException.FSE_ERROR);
			}
			XPathUtility.setNodeValue(consultaStorico,"//idCittadino",input.idCittadino );
			
			if(input.idSetDocumenti == null || input.idSetDocumenti.length == 0)
			{
				throw new SebException("VoInputConsultaStoricoDCE.idSetDocumenti non valido",SebException.FSE_ERROR);
			}
			XPathUtility.setNodeValue(consultaStorico,"//idSetDocumenti",input.idSetDocumenti );
			
			return consultaStorico;
		}
		
		public function toVoOutput(body:XML=null):ValueObject
		{
			var parsing:ParserConsultaStorico = new ParserConsultaStorico( body );
			return parsing.execute();
		}
		
		public function getNameService():String
		{
			return "FSE.consultaStoricoDCE";
		}
		
		public function getQNameResponse():QName
		{
			return new QName("http://www.crs.lombardia.it/schemas/DCSanita/FSE/2008-01/consultaStoricoDCE/", "FSE.consultaStoricoDCEResponse");
		}
		
		private const INPUT_CONSULTA_STORICO:XML = <SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" 
			xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/" 
			xmlns:xsd="http://www.w3.org/1999/XMLSchema" 
			xmlns:xsi="http://www.w3.org/1999/XMLSchema-instance" 
			SOAP-ENV:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">
				<SOAP-ENV:Body>
					<m:FSE.consultaStoricoDCE xmlns:m="http://www.crs.lombardia.it/schemas/DCSanita/FSE/2008-01/consultaStoricoDCE/" 
						dataSetVersion="1.0">
  						<richiestaConsultaStoricoDCE>
  							<richiestaConsultaStoricoDCE>
							    <cittadino>
							        <idCittadino tipo="CF"></idCittadino>
							    </cittadino>
							    <idSetDocumenti></idSetDocumenti>
							</richiestaConsultaStoricoDCE>
  						</richiestaConsultaStoricoDCE>
					</m:FSE.consultaStoricoDCE>
				</SOAP-ENV:Body>
			</SOAP-ENV:Envelope>;	
		
	}
}