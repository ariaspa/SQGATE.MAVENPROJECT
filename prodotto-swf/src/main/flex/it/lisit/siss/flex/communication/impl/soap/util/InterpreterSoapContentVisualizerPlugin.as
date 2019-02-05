package it.lisit.siss.flex.communication.impl.soap.util
{
	import it.lisit.siss.flex.communication.ValueObject;
	import it.lisit.siss.flex.communication.exception.SebException;
	import it.lisit.siss.flex.communication.impl.soap.IInterpreterSoap;
	import it.lisit.siss.flex.communication.util.voCreaStrutturato.VoInputCreaStrutturato;
	import it.lisit.siss.flex.utility.xml.XPathUtility;

	internal class InterpreterSoapContentVisualizerPlugin implements IInterpreterSoap
	{
		public function InterpreterSoapContentVisualizerPlugin()
		{
		}

		public function toXmlInput(vo:ValueObject=null):XML
		{
			var visPlugin:XML = INPUT_contentVisualizerPlugin.copy();
			var input:VoInputCreaStrutturato;
			try 
			{
				input = vo as VoInputCreaStrutturato;
			} catch (e:Error) {
				throw new SebException("ValueObject non di tipo VoInputCreaStrutturato",SebException.FSE_ERROR);
			}
			if (input.name == null || input.name.length == 0)
				throw new SebException("il VoInputCreaStrutturato.name non contiene un valore corretto", SebException.FSE_ERROR);
			XPathUtility.setNodeValue(visPlugin, "//name", input.name);
			
			if (input.contentType == null || input.contentType.length == 0)
				throw new SebException("il VoInputCreaStrutturato.contentType non contiene un valore corretto", SebException.FSE_ERROR);
			XPathUtility.setNodeValue(visPlugin, "//contentType", input.contentType);
			
			if (input.content == null || input.content.length == 0)
				throw new SebException("il VoInputCreaStrutturato.content non contiene un valore corretto", SebException.FSE_ERROR);
			XPathUtility.setNodeValue(visPlugin, "//content", input.content);
				
			return visPlugin;
		}
		
		public function toVoOutput(body:XML=null):ValueObject
		{
			return new ParserContentVisualizerPlugin(body).execute();
		}
		
		public function getNameService():String
		{
			return "UTIL.contentVisualizerPlugin";
		}
		
		public function getQNameResponse():QName
		{
			return new QName("", "UTIL.contentVisualizerPluginResponse");
		}
		
		private const INPUT_contentVisualizerPlugin:XML = <SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" 
				xmlns:xsi="http://www.w3.org/1999/XMLSchema-instance" xmlns:xsd="http://www.w3.org/1999/XMLSchema" 
				xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/" 
				SOAP-ENV:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">
				  <SOAP-ENV:Body>
				     <UTIL.contentVisualizerPlugin>
								<param>
								  <name/>
								  <content/>
								  <contentType/>
								</param>
				     </UTIL.contentVisualizerPlugin>
				  </SOAP-ENV:Body>
				</SOAP-ENV:Envelope>;
		
	}
}