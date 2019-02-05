package it.lisit.siss.flex.communication.impl.soap.util
{
	import it.lisit.siss.flex.communication.util.voVerificaPDC.VoOutputVerificaPDC;
	import it.lisit.siss.flex.utility.xml.XPathUtility;
	
	public class ParserVerificaPDCSecurityInfo
	{
		public function ParserVerificaPDCSecurityInfo()
		{
		}
		public function execute(body:XML):VoOutputVerificaPDC
		{
			var vo:VoOutputVerificaPDC 	= new VoOutputVerificaPDC();		
			vo.codiceFiscale 			= XPathUtility.getNodeValue(body,"//codiceFiscale");
			vo.unicId 					= XPathUtility.getNodeValue(body,"//unicId");
			return vo; 
		}
	}
}