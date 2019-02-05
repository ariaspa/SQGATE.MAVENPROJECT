package it.lisit.siss.flex.communication.impl.soap.fse
{
	import it.lisit.siss.flex.communication.ValueObject;
	import it.lisit.siss.flex.communication.exception.SebException;
	import it.lisit.siss.flex.communication.fse.voApriPDT.VoInputApriPDT;
	import it.lisit.siss.flex.communication.impl.soap.IInterpreterSoap;
	import it.lisit.siss.flex.utility.xml.XPathUtility;

	internal class InterpreterSoapApriPDT implements IInterpreterSoap
	{
		public function InterpreterSoapApriPDT()
		{
		}
		public function toXmlInput(vo:ValueObject=null):XML
		{
			var apripdt:XML = INPUT_APRIPDT.copy();
			var input:VoInputApriPDT;
			try{
				input = vo as VoInputApriPDT;
			}catch(e:Error)
			{
				throw new SebException("ValueObject non di tipo VoInputApriPDT",SebException.FSE_ERROR);
			}
			if(input.idCittadino== null || input.idCittadino.length==0)
			{
				throw new SebException("VoInputApriPDT.idCittadino non valido",SebException.FSE_ERROR);
			}
			XPathUtility.setNodeValue(apripdt,"//idCittadino",input.idCittadino );
			if(input.tipoIdCittadino== null || input.tipoIdCittadino.length==0)
			{
				throw new SebException("VoInputApriPDT.tipoIdCittadino non valido",SebException.FSE_ERROR);
			}
			XPathUtility.setAttributeValueIntoNode(apripdt,"//idCittadino","tipo",input.tipoIdCittadino);
			if(input.cognomeCittadino== null || input.cognomeCittadino.length==0)
			{
				throw new SebException("VoInputApriPDT.cognomeCittadino non valido",SebException.FSE_ERROR);
			}
			XPathUtility.setNodeValue(apripdt,"//cognomeCittadino", input.cognomeCittadino);
			if(input.nomeCittadino == null || input.nomeCittadino.length==0)
			{
				throw new SebException("VoInputApriPDT.nomeCittadino non valido",SebException.FSE_ERROR);
			}
			XPathUtility.setNodeValue(apripdt,"//nomeCittadino",input.nomeCittadino);
			if(input.sessoCittadino == null || input.sessoCittadino.length==0)
			{
				throw new SebException("VoInputApriPDT.sessoCittadino non valido",SebException.FSE_ERROR);
			}
			XPathUtility.setNodeValue(apripdt,"//sessoCittadino",input.sessoCittadino);
			if(input.dataNascitaCittadino == null || input.dataNascitaCittadino.length==0)
			{
				throw new SebException("VoInputApriPDT.dataNascitaCittadino non valido",SebException.FSE_ERROR);
			}
			XPathUtility.setNodeValue(apripdt,"//dataNascitaCittadino",input.dataNascitaCittadino);
			
			if(input.idComuneNascitaCittadino == null || input.idComuneNascitaCittadino.length==0)
			{
				throw new SebException("VoInputApriPDT.idComuneNascitaCittadino non valido",SebException.FSE_ERROR);
			}
			XPathUtility.setNodeValue(apripdt,"//idComuneNascitaCittadino",input.idComuneNascitaCittadino);
			
			if(input.dataApertura == null || input.dataApertura.length==0)
			{
				throw new SebException("VoInputApriPDT.dataApertura non valido",SebException.FSE_ERROR);
			}
			XPathUtility.setNodeValue(apripdt,"//dataApertura",input.dataApertura);
			
			if(input.codicePDT == null ||  input.codicePDT.length==0)
			{
				throw new SebException("VoInputApriPDT.codicePDT non valido",SebException.FSE_ERROR);
			}
			XPathUtility.setNodeValue(apripdt,"//codicePDT",input.codicePDT);
			
			if(input.descrizionePDT == null || input.descrizionePDT.length==0)
			{
				throw new SebException("VoInputApriPDT.descrizionePDT non valido",SebException.FSE_ERROR);
			}
			XPathUtility.setNodeValue(apripdt,"//descrizionePDT",input.descrizionePDT);
			return apripdt;
		}
		 
		public function toVoOutput(body:XML=null):ValueObject
		{
			return new ParserApriPDT(body).execute();
		}
		
		public function getNameService():String
		{
			return "FSE.apriPDT";
		}
		
		public function getQNameResponse():QName
		{
			return new QName("http://www.crs.lombardia.it/schemas/DCSanita/FSE/2009-01/apriPDT/","FSE.apriPDTResponse");
		}
		 					
		private const INPUT_APRIPDT:XML = <SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" 
			xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/" 
			xmlns:xsd="http://www.w3.org/1999/XMLSchema" 
			xmlns:xsi="http://www.w3.org/1999/XMLSchema-instance" 
			SOAP-ENV:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">
				<SOAP-ENV:Body>
					<m:FSE.apriPDT xmlns:m='http://www.crs.lombardia.it/schemas/DCSanita/FSE/2009-01/apriPDT/' dataSetVersion='1.0'>
  							<percorsoDiagnosticoTerapeutico>
  								    <cittadino>
								        <idCittadino tipo="CF"></idCittadino>
								        <cognomeCittadino></cognomeCittadino>
								        <nomeCittadino></nomeCittadino>
								        <sessoCittadino></sessoCittadino>
								        <dataNascitaCittadino></dataNascitaCittadino>
								        <idComuneNascitaCittadino></idComuneNascitaCittadino>
								    </cittadino>
								    <datiPDT>
								      <dataApertura></dataApertura>
								      <codicePDT></codicePDT>
								      <descrizionePDT></descrizionePDT>
								    </datiPDT>
  							</percorsoDiagnosticoTerapeutico>
					</m:FSE.apriPDT>
				</SOAP-ENV:Body>
			</SOAP-ENV:Envelope>;		
	}
}