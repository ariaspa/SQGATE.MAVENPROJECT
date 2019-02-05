package it.lisit.siss.flex.communication.impl.soap.icce
{
	import it.lisit.siss.flex.communication.ValueObject;
	import it.lisit.siss.flex.communication.icce.voIdentificaCittadinoEsteso.VoInputIdentificaCittadinoEsteso;
	import it.lisit.siss.flex.communication.impl.soap.IInterpreterSoap;
	import it.lisit.siss.flex.utility.debug.Debug;
	import it.lisit.siss.flex.utility.xml.XPathUtility;

	internal class InterpreterSoapIdentificaCittadinoEsteso implements IInterpreterSoap
	{
		public function InterpreterSoapIdentificaCittadinoEsteso()
		{
		}

		public function toXmlInput(vo:ValueObject=null):XML
		{
			var input:XML	= getXmlInput(vo as VoInputIdentificaCittadinoEsteso);
			return input
		}
		
		public function toVoOutput(body:XML=null):ValueObject
		{
			return new ParserIdentificaCittadino(body).execute();
		}
		
		public function getNameService():String
		{
			return "ICCE.identificaCittadinoEsteso";
		}
		public function getQNameResponse():QName
		{
			return new QName("http://www.crs.lombardia.it/schemas/DCSanita/ICCE/2008-01/identificaCittadinoEsteso/","ICCE.identificaCittadinoEstesoResponse");
		}
		/////////////////////////////
		private function getXmlInput(vo:VoInputIdentificaCittadinoEsteso):XML
		{
			var myXML:XML = XML_REQUEST_ICCE_IDENTIFICA_CITTADINO_ESTESO_2008_01.copy();
			XPathUtility.setNodeValue(myXML,"//idAssistito", vo.idAssistito);
		    XPathUtility.setNodeValue(myXML,"//cognome",vo.cognome);
		    XPathUtility.setNodeValue(myXML,"//nome",vo.nome);
		    XPathUtility.setNodeValue(myXML,"//codiceFiscale",vo.codiceFiscale);
		    XPathUtility.setNodeValue(myXML,"//dataNascita",vo.dataNascita);
		    XPathUtility.setNodeValue(myXML,"//idLocalitaNascita",vo.idLocalitaNascita);
		    XPathUtility.setNodeValue(myXML,"//codiceSesso",vo.codiceSesso);
		    XPathUtility.setNodeValue(myXML,"//omettiEsenzioni",vo.omettiEsenzioni);
		    XPathUtility.setNodeValue(myXML,"//pageNumber",vo.pageNumber);
		    XPathUtility.setNodeValue(myXML,"//useWildcard",vo.useWildcard);
		    XPathUtility.setNodeValue(myXML,"//maxRecords",vo.maxRecords);
		    XPathUtility.setNodeValue(myXML,"//ricercaAnagraficaEstesa", vo.ricercaAnagraficaEstesa);
			return myXML;
		}
		///////////////////////////////////////////////////////////////////////////
		
		private const XML_REQUEST_ICCE_IDENTIFICA_CITTADINO_ESTESO_2008_01:XML = 
	    <SOAP-ENV:Envelope SOAP-ENV:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/" 
	    xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/" 
	    xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" 
	    xmlns:xsd="http://www.w3.org/1999/XMLSchema" xmlns:xsi="http://www.w3.org/1999/XMLSchema-instance">
		  <SOAP-ENV:Body>
		    <m:ICCE.identificaCittadinoEsteso dataSetVersion="1.0" 
		    xmlns:m="http://www.crs.lombardia.it/schemas/DCSanita/ICCE/2008-01/identificaCittadinoEsteso/">  
		      <param>
		        <profiloCittadino>
		          <idAssistito/>
		          <cognome/>
		          <nome/>
		          <codiceFiscale/>
		          <dataNascita/>
		          <idLocalitaNascita/>
		          <codiceSesso/>
		          <omettiEsenzioni/>
		        </profiloCittadino>
		        <attributiRicerca>
		          <pageNumber/>
		          <useWildcard/>
		          <maxRecords/>
		        </attributiRicerca>
		      </param>
		    </m:ICCE.identificaCittadinoEsteso>
		  </SOAP-ENV:Body>
		</SOAP-ENV:Envelope>;
	}
}