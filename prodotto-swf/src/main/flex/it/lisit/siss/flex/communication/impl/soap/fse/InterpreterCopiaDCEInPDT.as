package it.lisit.siss.flex.communication.impl.soap.fse
{
	import it.lisit.siss.flex.communication.ValueObject;
	import it.lisit.siss.flex.communication.exception.SebException;
	import it.lisit.siss.flex.communication.fse.voCopiaDCEInPDT.VoInputCopiaDCEInPDT;
	import it.lisit.siss.flex.communication.impl.soap.IInterpreterSoap;
	import it.lisit.siss.flex.utility.xml.XPathUtility;

	internal class InterpreterCopiaDCEInPDT implements IInterpreterSoap
	{
		public function InterpreterCopiaDCEInPDT()
		{
			
		}

		public function toXmlInput(vo:ValueObject=null):XML
		{
			var copiapdt:XML = INPUT_COPIAPDT.copy();
			var input:VoInputCopiaDCEInPDT
			try{
				input = vo as VoInputCopiaDCEInPDT;
			}catch(e:Error)
			{
				throw new SebException("ValueObject non di tipo VoInputCopiaDCEInPDT",SebException.FSE_ERROR);
			}
			if(input.idSetDocumenti.length==0)
			{
				throw new SebException("VoInputCopiaDCEInPDT.idSetDocumenti non valido",SebException.FSE_ERROR);
			}
			XPathUtility.setNodeValue(copiapdt,"//idSetDocumenti",input.idSetDocumenti );
			
			if(input.codicePDT.length==0)
			{
				throw new SebException("VoInputCopiaDCEInPDT.codicePDT non valido",SebException.FSE_ERROR);
			}
			XPathUtility.setNodeValue(copiapdt,"//attributiSpecifici/codicePDT",input.codicePDT );
			////////////////////////////////////////////////////////////////////////////////////////////
			////////////////////////////////////////////////////////////////////////////////////////////
			////////////////////////////////////////////////////////////////////////////////////////////
			if(input.idCittadino.length==0)
			{
				throw new SebException("VoInputCopiaDCEInPDT.idCittadino non valido",SebException.FSE_ERROR);
			}
			XPathUtility.setNodeValue(copiapdt,"//idCittadino",input.idCittadino );
			if(input.tipoIdCittadino.length==0)
			{
				throw new SebException("VoInputCopiaDCEInPDT.tipoIdCittadino non valido",SebException.FSE_ERROR);
			}
			XPathUtility.setAttributeValueIntoNode(copiapdt,"//idCittadino","tipo",input.tipoIdCittadino);
			if(input.cognomeCittadino.length==0)
			{
				throw new SebException("VoInputCopiaDCEInPDT.cognomeCittadino non valido",SebException.FSE_ERROR);
			}
			XPathUtility.setNodeValue(copiapdt,"//cognomeCittadino", input.cognomeCittadino);
			if(input.nomeCittadino.length==0)
			{
				throw new SebException("VoInputCopiaDCEInPDT.nomeCittadino non valido",SebException.FSE_ERROR);
			}
			XPathUtility.setNodeValue(copiapdt,"//nomeCittadino",input.nomeCittadino);
			if(input.sessoCittadino.length==0)
			{
				throw new SebException("VoInputCopiaDCEInPDT.sessoCittadino non valido",SebException.FSE_ERROR);
			}
			XPathUtility.setNodeValue(copiapdt,"//sessoCittadino",input.sessoCittadino);
			if(input.dataNascitaCittadino.length==0)
			{
				throw new SebException("VoInputCopiaDCEInPDT.dataNascitaCittadino non valido",SebException.FSE_ERROR);
			}
			XPathUtility.setNodeValue(copiapdt,"//dataNascitaCittadino",input.dataNascitaCittadino);
			
			if(input.idComuneNascitaCittadino.length==0)
			{
				throw new SebException("VoInputCopiaDCEInPDT.idComuneNascitaCittadino non valido",SebException.FSE_ERROR);
			}
			XPathUtility.setNodeValue(copiapdt,"//idComuneNascitaCittadino",input.idComuneNascitaCittadino);
			if (input.idFolder == null)
			{
				throw new SebException("VoInputCopiaDCEInPDT.idFolder non valido",SebException.FSE_ERROR);
			}
			XPathUtility.setNodeValue(copiapdt, "//datiFolder/idFolder", input.idFolder);
			if (input.idTipoFolder == null)
			{
				throw new SebException("VoInputCopiaDCEInPDT.idTipoFolder non valido",SebException.FSE_ERROR);
			}
			XPathUtility.setNodeValue(copiapdt, "//datiFolder/idTipoFolder", input.idTipoFolder);
			return copiapdt;
		}
		
		public function toVoOutput(body:XML=null):ValueObject
		{
			return new ParserCopiaPDT(body).execute();	 
		}
		
		public function getNameService():String
		{
			return "FSE.copiaDCEInFolder";
		}
		
		public function getQNameResponse():QName
		{
			return new QName("http://www.crs.lombardia.it/schemas/DCSanita/FSE/2009-01/copiaDCEInFolder/","FSE.copiaDCEInFolderResponse");
		}
		
		
		private const INPUT_COPIAPDT:XML = <SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" 
			xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/" 
			xmlns:xsd="http://www.w3.org/1999/XMLSchema" 
			xmlns:xsi="http://www.w3.org/1999/XMLSchema-instance" 
			SOAP-ENV:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">
				<SOAP-ENV:Body>
					<m:FSE.copiaDCEInFolder xmlns:m="http://www.crs.lombardia.it/schemas/DCSanita/FSE/2009-01/copiaDCEInFolder/" dataSetVersion="1.0">
  						<DCEInFolder>
  							<documentoClinicoElettronico>
      							<idSetDocumenti></idSetDocumenti>
    						</documentoClinicoElettronico>
    						<cittadino>
        						<idCittadino tipo="CF"></idCittadino>
        						<cognomeCittadino></cognomeCittadino>
        						<nomeCittadino></nomeCittadino>
        						<sessoCittadino></sessoCittadino>
        						<dataNascitaCittadino></dataNascitaCittadino>
        						<idComuneNascitaCittadino></idComuneNascitaCittadino>
    						</cittadino>
						    <datiFolder>
						      <idFolder></idFolder>
						      <idTipoFolder></idTipoFolder>
						    </datiFolder>
    						<attributiSpecifici>
      							<codicePDT></codicePDT>
    						</attributiSpecifici>
  						</DCEInFolder>
					</m:FSE.copiaDCEInFolder>
				</SOAP-ENV:Body>
			</SOAP-ENV:Envelope>;	
	}
}