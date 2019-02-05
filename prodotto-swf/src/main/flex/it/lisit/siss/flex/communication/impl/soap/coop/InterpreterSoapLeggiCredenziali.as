package it.lisit.siss.flex.communication.impl.soap.coop
{
	import it.lisit.siss.flex.communication.ValueObject;
	import it.lisit.siss.flex.communication.impl.soap.IInterpreterSoap;

	internal class InterpreterSoapLeggiCredenziali implements IInterpreterSoap
	{
		public function InterpreterSoapLeggiCredenziali()
		{
		}

		public function toXmlInput(vo:ValueObject=null):XML
		{
			var copy:XML = XML_REQUEST_LEGGI_CREDENZIALI_OPERATORE.copy();
			return copy;
		}
		
		public function toVoOutput(body:XML=null):ValueObject
		{
			return new ParserLeggiCredenziali(body).execute();
		}
		
		public function getNameService():String
		{
			return "LeggiCredenziali";
		}
		
		public function getQNameResponse():QName
		{
			return new QName("http://soapinterop.org","LeggiCredenzialiResponse");	 
		}
		
		/*public static function fromXMLToVoOperatore(xml:XML):VoOperatore
		{
			var voOperatore:VoOperatore;
			
			if (xml != null){
				voOperatore = new VoOperatore();
				// set: codice fiscale
				voOperatore.codiceFiscale =  XMLUtility.getNodeValue(xml,"//userId");
				
				// set: nome
				voOperatore.cognome = XMLUtility.getNodeValue(xml,"//LastName");
				
				// set: cognome
				voOperatore.nome = XMLUtility.getNodeValue(xml,"//FirstName");
				
				// set: codiceFiscale
				voOperatore.codiceFiscale = XMLUtility.getNodeValue(xml,"//userId");
				
				// set: ruolo
				// - prelievo del solo tag 'role'
				var ruolo:XML = new XML(XMLUtility.getNode(xml,"//role").toString());
				// - recupero del codice ruolo
				voOperatore.ruolo.codice = XMLUtility.getNodeValue(ruolo,"//code");
				// - recupero della descrizione ruolo
				voOperatore.ruolo.descrizione = XMLUtility.getNodeValue(ruolo,"//description");
				
				// set: attributi -> elenco reti
				var existTagAttributi:Boolean = XMLUtility.countNodes(xml,"//attributi") == 1;
				// - esistono degli attributi
				if (existTagAttributi){
					// - prelievo del solo tag 'attributi'
					var attributi:XML = new XML(XMLUtility.getNode(xml,"//attributi").toString());
					// - recupero della lista di tag 'attributo'
					var attributo:XMLList = XMLUtility.getNodeList(attributi,"//attributo");
					var reti:Array = new Array();
					
					if (attributo != null || attributo.length() > 0)
					{
						for (var i:uint=0; i < attributo.length(); i++) {
							 
							var nodo:XML = new XML(attributo[i].toString());
							
							var item:VoItem = new VoItem();
							item.codice = XMLUtility.getNodeValue(nodo,"//cod");
							item.descrizione = XMLUtility.getNodeValue(nodo,"//des");
							
							//Recupero il tipo
							var tipo:String = XMLUtility.getAttributeValueFromNode(nodo,"//attributo","tipo");
							// Se di tipo "RETE"
							if (tipo == "PRRP"){
								reti.push(item);
							}
						} 
						voOperatore.reti = reti;
					}
				}
				
				// set: struttura, presidio, uo
				var existTagCtf:Boolean = XMLUtility.countNodes(xml,"//ctf") == 1;
				// - esiste ctf
				if (existTagCtf){
					// - prelievo del solo tag 'ctf'
					var ctf:XML = new XML(XMLUtility.getNode(xml,"//ctf").toString());
					
					// - recupera la struttura (STR)
					var existTagStruttura:Boolean = XMLUtility.countNodes(xml,"//str") == 1;
					if (existTagStruttura){
						// - prelievo del solo tag 'ctf'
						var str:XML = new XML(XMLUtility.getNode(ctf,"//str").toString());
						var struttura:VoItem = new VoItem();
						struttura.codice = XMLUtility.getNodeValue(str,"//cod");
						struttura.descrizione = XMLUtility.getNodeValue(str,"//des");
						voOperatore.struttura = struttura;
					}
					
					// - recupera il presidio (PRE)
					var existTagPresidio:Boolean = XMLUtility.countNodes(xml,"//pre") == 1;
					if (existTagPresidio){
						// - prelievo del solo tag 'ctf'
						var pre:XML = new XML(XMLUtility.getNode(ctf,"//pre").toString());
						var presidio:VoItem = new VoItem();
						presidio.codice = XMLUtility.getNodeValue(pre,"//cod");
						presidio.descrizione = XMLUtility.getNodeValue(pre,"//des");
						voOperatore.presidio = presidio;
					}
					
					// - recupera il reparto (REP)
					var existTagReparto:Boolean = XMLUtility.countNodes(xml,"//rep") == 1;
					if (existTagReparto){
						// - prelievo del solo tag 'ctf'
						var rep:XML = new XML(XMLUtility.getNode(ctf,"//rep").toString());
						var reparto:VoItem = new VoItem();
						reparto.codice = XMLUtility.getNodeValue(rep,"//cod");
						reparto.descrizione = XMLUtility.getNodeValue(rep,"//des");
						voOperatore.reparto = reparto;
					}
				}
			}
			return voOperatore;
		}*/
		////////////////////////
		private const XML_REQUEST_LEGGI_CREDENZIALI_OPERATORE:XML =
		<SOAP-ENV:Envelope SOAP-ENV:encodingStyle="http://schemas.xmlsoap.org/soap/encoding" xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/">
			<SOAP-ENV:Header>
				<h:msgPath SOAP-ENV:actor="http://schemas.xmlsoap.org/soap/actor/next" SOAP-ENV:mustUnderstand="1" SOAP-ENC:arrayType="xsd:string[1]" SOAP-ENC:offset="[0]" xmlns:h="http://whitemesa.com/headers/soapmsgrouter.xsd" xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding">
					<item>http://services.soaplite.com/interop.cgi</item>
				</h:msgPath>
			</SOAP-ENV:Header>
			<SOAP-ENV:Body>
				<m:LeggiCredenziali xmlns:m="http://soapinterop.org">
					<param/>
				</m:LeggiCredenziali>
			</SOAP-ENV:Body>
		</SOAP-ENV:Envelope>;
	}
}