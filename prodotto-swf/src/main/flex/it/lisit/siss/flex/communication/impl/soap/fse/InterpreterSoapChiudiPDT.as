package it.lisit.siss.flex.communication.impl.soap.fse
{
	import it.lisit.siss.flex.communication.ValueObject;
	import it.lisit.siss.flex.communication.exception.SebException;
	import it.lisit.siss.flex.communication.fse.voChiudiPDT.VoInputChiudiPDT;
	import it.lisit.siss.flex.communication.impl.soap.IInterpreterSoap;
	import it.lisit.siss.flex.utility.xml.XPathUtility;

	internal class InterpreterSoapChiudiPDT implements IInterpreterSoap
	{
		public function InterpreterSoapChiudiPDT()
		{
		}
		public function toXmlInput(vo:ValueObject=null):XML
		{
			var chiudupdt:XML = INPUT_CHIUDIPDT.copy();
			var input:VoInputChiudiPDT;
			try{
				input = vo as VoInputChiudiPDT;
			}catch(e:Error)
			{
				throw new SebException("ValueObject non di tipo VoInputChiudiPDT",SebException.FSE_ERROR);
			}
			if(input.idCittadino.length==0)
			{
				throw new SebException("VoInputChiudiPDT.idCittadino non valido",SebException.FSE_ERROR);
			}
			XPathUtility.setNodeValue(chiudupdt,"//idCittadino",input.idCittadino );
			if(input.tipoIdCittadino.length==0)
			{
				throw new SebException("VoInputChiudiPDT.tipoIdCittadino non valido",SebException.FSE_ERROR);
			}
			XPathUtility.setAttributeValueIntoNode(chiudupdt,"//idCittadino","tipo",input.tipoIdCittadino);
			if(input.cognomeCittadino.length==0)
			{
				throw new SebException("VoInputChiudiPDT.cognomeCittadino non valido",SebException.FSE_ERROR);
			}
			XPathUtility.setNodeValue(chiudupdt,"//cognomeCittadino", input.cognomeCittadino);
			if(input.nomeCittadino.length==0)
			{
				throw new SebException("VoInputChiudiPDT.nomeCittadino non valido",SebException.FSE_ERROR);
			}
			XPathUtility.setNodeValue(chiudupdt,"//nomeCittadino",input.nomeCittadino);
			if(input.sessoCittadino.length==0)
			{
				throw new SebException("VoInputChiudiPDT.sessoCittadino non valido",SebException.FSE_ERROR);
			}
			XPathUtility.setNodeValue(chiudupdt,"//sessoCittadino",input.sessoCittadino);
			if(input.dataNascitaCittadino.length==0)
			{
				throw new SebException("VoInputChiudiPDT.dataNascitaCittadino non valido",SebException.FSE_ERROR);
			}
			XPathUtility.setNodeValue(chiudupdt,"//dataNascitaCittadino",input.dataNascitaCittadino);
			
			if(input.idComuneNascitaCittadino.length==0)
			{
				throw new SebException("VoInputChiudiPDT.idComuneNascitaCittadino non valido",SebException.FSE_ERROR);
			}
			XPathUtility.setNodeValue(chiudupdt,"//idComuneNascitaCittadino",input.idComuneNascitaCittadino);
			  
			if(input.codicePDT.length==0)
			{
				throw new SebException("VoInputChiudiPDT.codicePDT non valido",SebException.FSE_ERROR);
			}
			XPathUtility.setNodeValue(chiudupdt,"//codicePDT",input.codicePDT);
			
			if(input.descrizionePDT.length==0)
			{
				throw new SebException("VoInputChiudiPDT.descrizionePDT non valido",SebException.FSE_ERROR);
			}
			XPathUtility.setNodeValue(chiudupdt,"//descrizionePDT",input.descrizionePDT);
			
			if(input.dataChiusura.length==0)
			{
				throw new SebException("VoInputChiudiPDT.dataChiusura non valido",SebException.FSE_ERROR);
			}
			XPathUtility.setNodeValue(chiudupdt,"//dataChiusura",input.dataChiusura);
			
			if(input.note !=null && input.note.length>0)
			{
				XPathUtility.setNodeValue(chiudupdt,"//note",input.note);
			}
			return chiudupdt;
		}
		
		public function toVoOutput(body:XML=null):ValueObject
		{
			return new ParserChiudiPDT(body).execute();
		}
		
		public function getNameService():String
		{
			return "FSE.chiudiPDT";
		}
		
		public function getQNameResponse():QName
		{
			return new QName("http://www.crs.lombardia.it/schemas/DCSanita/FSE/2009-01/chiudiPDT/","FSE.chiudiPDTResponse");
		}
		
		private const INPUT_CHIUDIPDT:XML = <SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" 
			xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/" 
			xmlns:xsd="http://www.w3.org/1999/XMLSchema" 
			xmlns:xsi="http://www.w3.org/1999/XMLSchema-instance" 
			SOAP-ENV:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">
				<SOAP-ENV:Body>
					<m:FSE.chiudiPDT xmlns:m="http://www.crs.lombardia.it/schemas/DCSanita/FSE/2009-01/chiudiPDT/" dataSetVersion="1.0">
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
							    <dataChiusura></dataChiusura>
							    <codicePDT></codicePDT>
							    <descrizionePDT></descrizionePDT>
							    <note></note>
						    </datiPDT>
  						</percorsoDiagnosticoTerapeutico>
					</m:FSE.chiudiPDT>
				</SOAP-ENV:Body>
			</SOAP-ENV:Envelope>;	
	}
}