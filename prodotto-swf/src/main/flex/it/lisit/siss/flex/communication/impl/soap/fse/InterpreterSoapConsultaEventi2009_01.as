package it.lisit.siss.flex.communication.impl.soap.fse
{
	import it.lisit.siss.flex.communication.ValueObject;
	import it.lisit.siss.flex.communication.exception.SebException;
	import it.lisit.siss.flex.communication.fse.voConsultaEventiDaFlussi.VoInputConsultaEventiDaFlussi;
	import it.lisit.siss.flex.communication.impl.soap.IInterpreterSoap;
	import it.lisit.siss.flex.utility.xml.XPathUtility;

	internal class InterpreterSoapConsultaEventi2009_01 implements IInterpreterSoap
	{
		public function InterpreterSoapConsultaEventi2009_01()
		{	
		}
		public function toXmlInput(vo:ValueObject=null):XML
		{
			var _vo:VoInputConsultaEventiDaFlussi = vo as VoInputConsultaEventiDaFlussi;
			var input:XML	= XMLINPUT.copy();
			if(_vo.idCittadino==null || _vo.idCittadino.length==0)
			{
				throw new SebException("VoInputConsultaEventiDaFlussi.idCittadino deve essere valorizzato",SebException.FSE_ERROR);
			}
			XPathUtility.setNodeValue(input,"//idCittadino",_vo.idCittadino);
			if(_vo.tipoIdCittadino==null || _vo.tipoIdCittadino.length==0)
			{
				throw new SebException("VoInputConsultaEventiDaFlussi.tipoIdCittadino deve essere valorizzato",SebException.FSE_ERROR);
			}
			XPathUtility.setAttributeValueIntoNode(input,"//idCittadino","tipo",_vo.tipoIdCittadino);
			try
			{
				if(_vo.idTipoEvento!=null && _vo.idTipoEvento.length>0)
				{
					XPathUtility.setNodeValue(input,"//idTipoEvento",_vo.idTipoEvento);	
				}
				if(_vo.nMaxRecord!=null && _vo.nMaxRecord.length>0)
				{
					XPathUtility.setNodeValue(input,"//nMaxRecord",_vo.nMaxRecord);	
				}
				if(_vo.nMaxRecord!=null && _vo.nMaxRecord.length>0)
				{
					XPathUtility.setNodeValue(input,"//nMaxRecord",_vo.nMaxRecord);	
				}
				if(_vo.nPagina>0)
				{
					XPathUtility.setNodeValue(input,"//nPagina",String(_vo.nPagina));	
				}
				if(_vo.dataInizio!=null && _vo.dataInizio.length>0)
				{
					XPathUtility.setNodeValue(input,"//dataInizio",_vo.dataInizio);	
				}
				if(_vo.dataFine!=null && _vo.dataFine.length>0)
				{
					XPathUtility.setNodeValue(input,"//dataFine",_vo.dataFine);	
				}
			}catch(e:Error)
			{
				throw new SebException("VoInputConsultaEventiDaFlussi : "+e.message,SebException.FSE_ERROR);
			}
			return input;
		}
		
		public function toVoOutput(body:XML=null):ValueObject
		{
			return new ParserConsultaEventi2009_01().execute(body);
		}
		
		public function getNameService():String
		{
			return "FSE.consultaEventiDaFlussi";
		}
		
		public function getQNameResponse():QName
		{
			return new QName("http://www.crs.lombardia.it/schemas/DCSanita/FSE/2009-01/consultaEventiDaFlussi/","FSE.consultaEventiDaFlussiResponse");
		}
		//
		private const XMLINPUT:XML	= <SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" 
										xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/" 
										xmlns:xsd="http://www.w3.org/1999/XMLSchema" 
										xmlns:xsi="http://www.w3.org/1999/XMLSchema-instance" 
										SOAP-ENV:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/"> 	
											<SOAP-ENV:Body>
												<m:FSE.consultaEventiDaFlussi xmlns:m="http://www.crs.lombardia.it/schemas/DCSanita/FSE/2009-01/consultaEventiDaFlussi/" dataSetVersion="1.0">
													<richiestaConsultaEventiDaFlussi>
														    <cittadino>
														        <idCittadino tipo="CF"></idCittadino>
														    </cittadino>
														    <idTipoEvento></idTipoEvento>
														    <dataInizio></dataInizio>
														    <dataFine></dataFine>
														    <nMaxRecord></nMaxRecord>
														    <nPagina></nPagina>
						  							</richiestaConsultaEventiDaFlussi>
												</m:FSE.consultaEventiDaFlussi>
											</SOAP-ENV:Body>
									  </SOAP-ENV:Envelope>;
		 

	}
}