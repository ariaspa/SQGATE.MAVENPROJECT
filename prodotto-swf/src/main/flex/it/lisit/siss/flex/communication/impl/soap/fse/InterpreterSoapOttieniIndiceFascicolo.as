package it.lisit.siss.flex.communication.impl.soap.fse
{
	import it.lisit.siss.flex.communication.ValueObject;
	import it.lisit.siss.flex.communication.exception.SebException;
	import it.lisit.siss.flex.communication.fse.voOttieniIndiceFascicolo.VoInputOttieniIndiceFascicolo;
	import it.lisit.siss.flex.communication.impl.soap.IInterpreterSoap;
	import it.lisit.siss.flex.utility.xml.XPathUtility;

	public class InterpreterSoapOttieniIndiceFascicolo implements IInterpreterSoap
	{
		public function InterpreterSoapOttieniIndiceFascicolo()
		{
			
		}

		public function toXmlInput(vo:ValueObject=null):XML
		{
			var ottieniIndice:XML = INPUT_OTTIENI_IND_FASC.copy();
			var input:VoInputOttieniIndiceFascicolo;
			try 
			{
				input = vo as VoInputOttieniIndiceFascicolo;
			} catch (e:Error) {
				throw new SebException("ValueObject non di tipo VoInputOttieniDocumentoTestuale",SebException.FSE_ERROR);
			}
			if (input.idCittadino == null || input.idCittadino.length == 0) {
				throw new SebException("VoInputOttieniIndiceFascicolo.idCittadino non valido", SebException.FSE_ERROR);
			}
			XPathUtility.setNodeValue(ottieniIndice, "//cittadino/idCittadino", input.idCittadino);
			XPathUtility.setAttributeValueIntoNode(ottieniIndice, "//cittadino/idCittadino", "tipo", "CF");
			if (input.nMaxRecord == 0) {
				XPathUtility.removeNode(ottieniIndice, "//nMaxRecord");
			} else {
				XPathUtility.setNodeValue(ottieniIndice, "//nMaxRecord", String(input.nMaxRecord));
			}
			if (input.nPagina == 0) {
				XPathUtility.removeNode(ottieniIndice, "//nPagina");
			} else {
				XPathUtility.setNodeValue(ottieniIndice, "//nPagina", String(input.nPagina));
			}
			return ottieniIndice;
		}
		
		public function toVoOutput(body:XML=null):ValueObject
		{
			var parsing:ParserOttieniIndiceFascicolo = new ParserOttieniIndiceFascicolo( body );
			return parsing.execute();
		}
		
		public function getNameService():String
		{
			return "FSE.ottieniIndiceFascicolo";
		}
		
		public function getQNameResponse():QName
		{
			return new QName("http://www.crs.lombardia.it/schemas/DCSanita/FSE/2009-01/ottieniIndiceFascicolo/", "FSE.ottieniIndiceFascicoloResponse");
		}
		
		private const INPUT_OTTIENI_IND_FASC:XML = <SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" 
			xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/" 
			xmlns:xsd="http://www.w3.org/1999/XMLSchema" 
			xmlns:xsi="http://www.w3.org/1999/XMLSchema-instance" 
			SOAP-ENV:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">
				<SOAP-ENV:Body>
					<m:FSE.ottieniIndiceFascicolo
					  xmlns:m="http://www.crs.lombardia.it/schemas/DCSanita/FSE/2009-01/ottieniIndiceFascicolo/"
					  dataSetVersion="1.0">
					  <richiestaIndiceFascicolo>
					  	    <cittadino>
						        <idCittadino tipo=""></idCittadino>
						    </cittadino>
						    <nMaxRecord></nMaxRecord>
						    <nPagina></nPagina>
					  </richiestaIndiceFascicolo>
					</m:FSE.ottieniIndiceFascicolo>
				</SOAP-ENV:Body>
			</SOAP-ENV:Envelope>;
	
	}
}