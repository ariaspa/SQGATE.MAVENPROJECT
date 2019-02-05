package it.lisit.siss.flex.communication.impl.soap.fse
{
	import it.lisit.siss.flex.communication.ValueObject;
	import it.lisit.siss.flex.communication.exception.SebException;
	import it.lisit.siss.flex.communication.fse.voCancellaDCEDaFolder.VoInputCancellaDCEDaFolder;
	import it.lisit.siss.flex.communication.impl.soap.IInterpreterSoap;
	import it.lisit.siss.flex.utility.xml.XPathUtility;

	internal class InterpreterCancellaDCEDaFolder implements IInterpreterSoap
	{
		public function InterpreterCancellaDCEDaFolder()
		{
			
		}

		public function toXmlInput(vo:ValueObject=null):XML
		{
			var cancellaDce:XML = INPUT_CANCELLA_DCE.copy();
			var input:VoInputCancellaDCEDaFolder
			try{
				input = vo as VoInputCancellaDCEDaFolder;
			}catch(e:Error)
			{
				throw new SebException("ValueObject non di tipo VoInputCancellaDCEDaFolder",SebException.FSE_ERROR);
			}
			if(input.idSetDocumenti == null || input.idSetDocumenti.length==0)
			{
				throw new SebException("VoInputCancellaDCEDaFolder.idSetDocumenti non valido",SebException.FSE_ERROR);
			}
			XPathUtility.setNodeValue(cancellaDce,"//idSetDocumenti",input.idSetDocumenti );
			
			if(input.codicePDT == null || input.codicePDT.length == 0)
			{
				XPathUtility.removeNode(cancellaDce, "attributiSpecifici");
			}
			XPathUtility.setNodeValue(cancellaDce,"//attributiSpecifici/codicePDT",input.codicePDT );
			////////////////////////////////////////////////////////////////////////////////////////////
			////////////////////////////////////////////////////////////////////////////////////////////
			////////////////////////////////////////////////////////////////////////////////////////////
			if(input.idCittadino == null || input.idCittadino.length==0)
			{
				throw new SebException("VoInputCancellaDCEDaFolder.idCittadino non valido",SebException.FSE_ERROR);
			}
			XPathUtility.setNodeValue(cancellaDce,"//idCittadino",input.idCittadino );
			if(input.tipoIdCittadino.length==0)
			{
				throw new SebException("VoInputCancellaDCEDaFolder.tipoIdCittadino non valido",SebException.FSE_ERROR);
			}
			XPathUtility.setAttributeValueIntoNode(cancellaDce,"//idCittadino","tipo",input.tipoIdCittadino);
			if (input.idFolder == null)
			{
				throw new SebException("VoInputCancellaDCEDaFolder.idFolder non valido",SebException.FSE_ERROR);
			}
			XPathUtility.setNodeValue(cancellaDce, "//datiFolder/idFolder", input.idFolder);
			if (input.idTipoFolder == null)
			{
				throw new SebException("VoInputCancellaDCEDaFolder.idTipoFolder non valido",SebException.FSE_ERROR);
			}
			XPathUtility.setNodeValue(cancellaDce, "//datiFolder/idTipoFolder", input.idTipoFolder);
			return cancellaDce;
		}
		
		public function toVoOutput(body:XML=null):ValueObject
		{
			return new ParserCancellaDCEDaFolder(body).execute();	 
		}
		
		public function getNameService():String
		{
			return "FSE.cancellaDCEDaFolder";
		}
		
		public function getQNameResponse():QName
		{
			return new QName("http://www.crs.lombardia.it/schemas/DCSanita/FSE/2009-01/cancellaDCEDaFolder/","FSE.cancellaDCEDaFolderResponse");
		}
		
		
		private const INPUT_CANCELLA_DCE:XML = <SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" 
			xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/" 
			xmlns:xsd="http://www.w3.org/1999/XMLSchema" 
			xmlns:xsi="http://www.w3.org/1999/XMLSchema-instance" 
			SOAP-ENV:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">
				<SOAP-ENV:Body>
					<m:FSE.cancellaDCEDaFolder xmlns:m="http://www.crs.lombardia.it/schemas/DCSanita/FSE/2009-01/cancellaDCEDaFolder/" dataSetVersion="1.0">
  						<DCEDaFolder>
						    <documentoClinicoElettronico>
						      <idSetDocumenti></idSetDocumenti>
						    </documentoClinicoElettronico>
						    <cittadino>
						        <idCittadino tipo="CF"></idCittadino>
						    </cittadino>
						    <datiFolder>
						      <idFolder></idFolder>
						      <idTipoFolder></idTipoFolder>
						    </datiFolder>
						    <attributiSpecifici>
						      <codicePDT></codicePDT>
						    </attributiSpecifici>
						</DCEDaFolder>
					</m:FSE.cancellaDCEDaFolder>
				</SOAP-ENV:Body>
			</SOAP-ENV:Envelope>;	
	}
}