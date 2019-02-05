package it.lisit.siss.flex.communication.impl.soap.fse
{
	import it.lisit.siss.flex.communication.ValueObject;
	import it.lisit.siss.flex.communication.exception.SebException;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoInputConsultaFascicolo;
	import it.lisit.siss.flex.communication.impl.soap.IInterpreterSoap;
	import it.lisit.siss.flex.utility.xml.XPathUtility;
	//////////////////////////////////////////////////////////////////////////////
	public class InterpreterSoapConsultaFascicolo implements IInterpreterSoap
	{
		public function InterpreterSoapConsultaFascicolo(){}
		//=================IMPLEMENTAZIONE DELL'INTERFACCIA======================
		public function toXmlInput(vo:ValueObject=null):XML
		{
			var input:XML = enhancesSOAP(vo as VoInputConsultaFascicolo);
			return input;
		}
		public function toVoOutput(body:XML=null):ValueObject
		{
			var parsing:ParserConsultaFascicolo = new ParserConsultaFascicolo( body );
			return parsing.execute();
		}
		public function getNameService():String
		{
			//FSE:Consultafascicolo
			return "FSE.consultaFascicolo"; 
		}
		public function getQNameResponse():QName
		{
			return new QName('http://www.crs.lombardia.it/schemas/DCSanita/FSE/2008-01/consultaFascicolo/', "FSE.consultaFascicoloResponse");
		}
		//==========================================================================
		/**
		 * ritorna l'xml di input per il servizio soap 
		 * @return 
		 */	
		private function enhancesSOAP(_vo:VoInputConsultaFascicolo):XML
		{
			var consultaFascicolo:XML = INPUT_CONSULTAFASCICOLO.copy();
			if(_vo.idCittadino==null || _vo.idCittadino.length==0)
			{
				throw new SebException("VoInputConsultaFascicolo.idCittadino deve essere valorizzato",SebException.FSE_ERROR);
			}
			XPathUtility.setNodeValue(consultaFascicolo,"//idCittadino",_vo.idCittadino);
			if(_vo.tipoIdCittadino==null || _vo.tipoIdCittadino.length==0)
			{
				throw new SebException("VoInputConsultaFascicolo.tipoIdCittadino deve essere valorizzato",SebException.FSE_ERROR);
			}
			XPathUtility.setAttributeValueIntoNode(consultaFascicolo,"//idCittadino","tipo",_vo.tipoIdCittadino);
			if(_vo.idFolder!=null && _vo.idFolder.length>0)
			{
				XPathUtility.setNodeValue(consultaFascicolo,"//idFolder",_vo.idFolder);
			}
			if(_vo.idTipoFolder!=null && _vo.idTipoFolder.length>0)
			{
				XPathUtility.setNodeValue(consultaFascicolo,"//idTipoFolder",_vo.idTipoFolder);
			}
			if(_vo.nMaxRecord!=-1)
			{
				XPathUtility.setNodeValue(consultaFascicolo,"//nMaxRecord",getValueToSTR(_vo.nMaxRecord));
			}
			var npagina:uint = _vo.nPagina;
			if(npagina<=0) npagina = 1;
			XPathUtility.setNodeValue(consultaFascicolo,"//nPagina",getValueToSTR(npagina));
			//da reimplementare <listaRetiPatologia></listaRetiPatologia>
			/*if(_vo.listaRetiPatologia!=null && _vo.listaRetiPatologia.length>0)
			{
				for(var i:uint = 0;i<_vo.listaRetiPatologia.length;i++)
				{
					var copyrete:XML 	= RETEPATOLOGIA.copy();
					var rete:String		= _vo.listaRetiPatologia[i];
					if(rete!=null && rete.length>0)
					{
						XPathUtility.setNodeValue(copyrete,"//reteDiPatologia",rete);
						XPathUtility.importNode(consultaFascicolo,"//listaRetiPatologia",copyrete);
					}
				}
			}else
			{
				delete XPathUtility.getNode(consultaFascicolo,"//listaRetiPatologia");
			}*/
			return consultaFascicolo;
		}
		private function  getValueToSTR(value:int):String
		{
			var res:String = "";	
			if(value>-1)
			{
				if(value<10)
					res = "0"+value;
				else
					res = ""+value;
			}
			return res;
		}
		private function  getValueSTR(str:String):String
		{ 
			if(str==null)return "";
			if(str.length==0)return "";
			return str;
		}
		private const INPUT_CONSULTAFASCICOLO:XML = <SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" 
			xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/" 
			xmlns:xsd="http://www.w3.org/1999/XMLSchema" 
			xmlns:xsi="http://www.w3.org/1999/XMLSchema-instance" 
			SOAP-ENV:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">
				<SOAP-ENV:Body>
					<m:FSE.consultaFascicolo xmlns:m="http://www.crs.lombardia.it/schemas/DCSanita/FSE/2008-01/consultaFascicolo/" dataSetVersion="1.0">
						<richiestaConsultaFascicolo>  
						    <cittadino>  
	        					<idCittadino tipo="CF"></idCittadino>  
	    					</cittadino>
	    					
		    				<idFolder></idFolder> 
		    				<idTipoFolder></idTipoFolder>  
		    				<nMaxRecord></nMaxRecord>  
		    				<nPagina></nPagina>  
						</richiestaConsultaFascicolo>
					</m:FSE.consultaFascicolo>
				</SOAP-ENV:Body>
			</SOAP-ENV:Envelope>;
			
		
		private const RETEPATOLOGIA:XML =  <retePatologia>
							      				<reteDiPatologia></reteDiPatologia>
							     		   </retePatologia>;
			 
	}
}