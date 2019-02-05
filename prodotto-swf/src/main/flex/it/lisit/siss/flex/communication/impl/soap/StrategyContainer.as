package it.lisit.siss.flex.communication.impl.soap
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import it.lisit.siss.flex.communication.ValueObject;
	import it.lisit.siss.flex.communication.event.*;
	import it.lispa.siss.sebc.flex.debug.Debug;
	
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	import mx.utils.StringUtil;

	internal class StrategyContainer implements IResponder
	{
		private static const PI_WHITESPACE_PATTERN:RegExp 	= new RegExp("[\\?][>]\\s*[<]", "g");  
	 
		////////////////////////////////
		private var communicator:ICommunicatorSoap;
		private var dispatcher:EventDispatcher;
		private var interpreter:IInterpreterSoap; 
		private var qNameResponse:QName; 
		private var input:XML
		 
		//=================================================================
		public function StrategyContainer(communicator:ICommunicatorSoap, interpreter:IInterpreterSoap,dispatcher:EventDispatcher,vo:ValueObject=null )
		{
			this.communicator  	= communicator;
			this.dispatcher  	= dispatcher;
			this.interpreter 	= interpreter;
			//
			qNameResponse		= interpreter.getQNameResponse();
			if(qNameResponse == null )
			{
				throw new Error("IInterpreterSoap.getQNameResponse() non restituisce un QName valido");
			}
			input				= interpreter.toXmlInput( vo );
			if(input==null || input.length()==0)
			{
				throw new Error("IInterpreterSoap.toXmlInput() non restituisce un xml valido");
			}
		}
		/**
		 * manda in esecuzione il Strategy 
		 * 
		 */		
		public function execute():void
		{
			var outmsg:String	=  input.normalize().toXMLString();
			Debug.logInfo("Chiamata al servizio : "+interpreter.getNameService() +"  INPUT :: "+outmsg);
			/*  Il service è delegato alla spedizione della richiesta, richiede il responder per trasmettere il risultato*/
			var sender:ServiceSendXML = new ServiceSendXML( communicator, this , interpreter.getNameService());
			sender.send( input );
		}
		/**
		 *  This method is called by a service when an error has been received.
		 *  While <code>info</code> is typed as Object it is often
		 *  (but not always) an mx.rpc.events.FaultEvent.
		 */
		public function fault(info:Object):void
		{
			stopPropagation( info );
			var event:Event = new ServiceSEBErrorEvent("Flex Fault ",info);
			dispatcher.dispatchEvent( event );
		} 
		 
		/**
		 *  This method is called by a service when the return value
		 *  has been received. 
		 *  While <code>data</code> is typed as Object, it is often
		 *  (but not always) an mx.rpc.events.ResultEvent.
		 */
		public function result(data:Object):void
		{
			stopPropagation( data );
			var outPut:XML;
			var envelopePrefix:String;
			var event:Event;
			var bodyXML:XML;
			var oldIgnoreWhitespace:Boolean 		= XML.ignoreWhitespace;
			try{
				/* ---------------------------------------------------------- */
				try{
					/* estrae l'xml di result dal data*/
					outPut		 					= extractOutputData(data);
				}catch(e:Error)
				{
					event							= new ServiceSEBErrorEvent("La risposta non contiene data valido :: "+e.getStackTrace());
					throw new Error();
				}
				var outmsg:String	=  outPut.normalize().toXMLString();
				Debug.logInfo("Risposta al servizio : "+interpreter.getNameService() +"  OUTPUT :: "+outmsg );
				/* ---------------------------------------------------------- */
				try{
					
					/* il nome del soap Envelope */
					var qNameEnvelope:QName 		= outPut.name();
					/* l'uri Envelope, se qNameEnvelope è null genera errore */
					envelopePrefix 					= qNameEnvelope.uri;
				}catch(e:Error)
				{
					// Non contiene envelope, ridefinisco l'event
					event 							= new ServiceSEBErrorEvent("Non contiene Envelope :: "+e.getStackTrace());
					throw new Error();
				} 
				/* ---------------------------------------------------------- */
				try
				{
					bodyXML			 				= extractBody(outPut,envelopePrefix);
				}catch(e:Error)
				{
					event							= new ServiceSEBErrorEvent("Non contiene Body :: "+e.getStackTrace());
					throw new Error();
				}
				/* ---------------------------------------------------------- */
				/* fault deve essere controllato per prima perchè non è dentro il tag body */
				 
				var voFault:VoFault  				= extractFault(bodyXML,envelopePrefix);
				if(voFault!=null)
				{
					event 							= new ServiceSEBFaultEvent(voFault);
					throw new Error();
				}
				/* ---------------------------------------------------------- */
				var response:XML;
				try{
					response	 					= bodyXML[qNameResponse][0];
					//////////////////////////////////////////////////////////
					if(response==null)
					{
						var local:String				= qNameResponse.localName;
						if(local!=null && local.length>0)
						{
							local						= local.split("Response")[0];
							var isVisualizzaReferto:Boolean = (local=="CRM.visualizzaTestoReferto");
							if(isVisualizzaReferto)
							{
								qNameResponse			= new QName(qNameResponse.uri,local);
								response	 			= bodyXML[qNameResponse][0];
							}
						}
					}
				}catch(e:Error)
				{
					event 							= new ServiceSEBErrorEvent("Errore Response : "+e.getStackTrace());
					throw new Error( );
				}
				if(response==null || response.length()==0)
				{
					event 							= new ServiceSEBErrorEvent("Non contiene Response");
					throw new Error( );
				}
				/* nel caso l'esito negativo sia direttamente dentro senza param  */
				var esit:XMLList = response.child("esitoNegativo");
				if(esit.length()>0)
				{
					event 							= new ServiceSEBErrorEvent("Errore interno al Dominio Centrale");
					throw new Error();
				}
				var params:XMLList					= response.children();
				if(params==null || params.length()==0)
				{
					event 							= new ServiceSEBErrorEvent("Non contiene Documenti");
					throw new Error( );
				}
				/* ---------------------------------------------------------- */
				// genera evento di risposta positiva
				var temp:Array		= new Array();
				for(var i:uint = 0;i<params.length();i++)
				{
					var par:XML		= params[i];
					var esitoNegativo:VoEsitoNegativo	= extractEsitoNegativo(par);
					var isEsitoNegativo:Boolean			= (esitoNegativo!=null);
					var warnings:VoListaWarning			= null;
					var voResponse:ValueObject 			= null;
					//
					if(!isEsitoNegativo)
					{
						var listaWarning:XMLList 		=  par.child("listaWarning");
						if(listaWarning!=null && listaWarning.length()>0)
						{
							delete par.listaWarning[0]; 
							warnings 					= new VoListWarningImpl(listaWarning[0]);
						}
						
						try{
							voResponse				 	= interpreter.toVoOutput( par );	
						}catch(e:Error)
						{
							var mes:String = "IInterpreterSoap di "+interpreter.getNameService()+" non è stato in grado di interpretare il documento, per il seguente motivo : "+e.getStackTrace();
							event 						= new ServiceSEBErrorEvent(mes);
							throw new Error();
						}
					}
					//
					var esito:VoResponse				= new VoResponse();
					esito.isEsitoNegativo				= isEsitoNegativo;
					esito.warnings						= warnings;
					esito.esitoNegativo					= esitoNegativo;
					esito.esitoPositivo 				= voResponse;
					temp.push( esito );
				}
				event	= new ServiceSEBCompleteEvent(ServiceSEBCompleteEvent.SERVICE_COMPLETE,temp);
			}catch(e:Error)
			{
			}finally
			{	
				XML.ignoreWhitespace = oldIgnoreWhitespace; 
				if(event==null)
				{
					event 	= new ServiceSEBErrorEvent("Errore interno","Non in grado di leggere la risposta ad "+interpreter.getNameService());
				}
				dispatcher.dispatchEvent(event);
			}
		}
		//////////////////////////////////////////////////////////////////////////////
		//////////////////////////////////////////////////////////////////////////////
		//////////////////////////////////////////////////////////////////////////////
		private function stopPropagation(obj:Object):void
		{
			if(obj is Event)
			{
				Event( obj ).stopPropagation();
			}
		}
		private function extractFault(xml:XML, envelopePrefix:String):VoFault
		{
			// Check for SOAP faults for all resultFormats
	        var faultQName :QName = new QName(envelopePrefix,"Fault");
			var faultList:XMLList = xml[faultQName] as XMLList; 
			if( faultList==null || faultList.length() == 0)
			{
				return null;
			} 
			var faultXml:XML = xml[faultQName][0];
			var voFault:VoFaultImpl = new VoFaultImpl(faultXml);
			return voFault;
		}
		private function extractBody(resultXml:XML,envelopePrefix:String):XML
		{
			/*  Body */
			var bodyQName:QName = new QName(envelopePrefix, "Body");
			var bodyXML:XML 	= resultXml[bodyQName][0]; 
			if (bodyXML == null || bodyXML.hasComplexContent() == false || bodyXML.children().length() <= 0)
		    {  	
		       throw new Error("Body mancante");
		    } 
			return bodyXML;
		}
		private function extractEsitoNegativo(xml:XML):VoEsitoNegativo
		{
												 //esitoNegativo
			var esitoNegativo:XMLList = xml.child("esitoNegativo"); 
			Debug.logDebug("extractEsitoNegativo : "+esitoNegativo);
			if(esitoNegativo == null || esitoNegativo.length() == 0)
			{
				return null;
			}
			var voEsitoNegativo:VoEsitoNegativoImpl = new VoEsitoNegativoImpl(esitoNegativo[0]);
			return voEsitoNegativo;
		}
	 
		  
		/**
		 * comprende il tipo di data passato e converte la parte interessata
		 * in un xml 
		 * @param data
		 * @return XML 
		 * 
		 */	
		private function extractOutputData(data:Object):XML
		{
			var strx:String ="";
			if( data is ResultEvent )
			{
				Debug.logDebug("ResultEvent(data).result!=null: " + (ResultEvent(data).result!=null));
				if(ResultEvent(data).result!=null)
				{
					strx = ResultEvent(data).result.toString();
				} 
			}else if( data is XML )
			{
				strx = XML(data).toString();
			}else
			{
				strx = data.toString();
			}
			if( strx.length>0 )
			{
				/* Work around di Mindaugas Ajauskas */
				// Work around Flash Player bug 192355 by removing whitespace 
				// between processing instructions and the root tag before 
				// constructing an XML instance of the SOAP response. 
				strx = strx.replace( PI_WHITESPACE_PATTERN, "?><" ); 
				strx = StringUtil.trim( strx );
			}else
			{
				throw new Error("Data null");
			}
			return new XML(strx);
		}
	}
}


import  it.lisit.siss.flex.communication.event.VoFault;
import it.lisit.siss.flex.communication.event.ServiceSEBErrorEvent;
import it.lisit.siss.flex.communication.event.VoEsitoNegativo;

import it.lisit.siss.flex.communication.event.VoListaEccezioni;
import it.lisit.siss.flex.communication.event.VoEccezione;

import mx.utils.XMLUtil;
import flash.events.Event;
import it.lisit.siss.flex.communication.event.VoWarning;
import it.lisit.siss.flex.communication.impl.soap.IInterpreterSoap;
import it.lisit.siss.flex.communication.ClonableValueObject;
import it.lisit.siss.flex.communication.event.VoListaWarning;

class VoFaultImpl extends VoFault
{

	public function VoFaultImpl(xml:XML)
	{
		super();
		create(xml);
	}
	 
	private function create(xml:XML):void
	{
		var detailAr:Array 	= new Array();
		this.faultDetail 	= new ArrayIterator( detailAr );
		this.faultcode 		= xml.child("faultcode");
		this.faultstring 	= xml.child("faultstring");
		var detail:XMLList	= xml.child("detail");
		if(detail!=null && detail.length()>0)
		{
			var fltDetail:XMLList	= detail[0].child("faultDetail");
			if(fltDetail!=null && fltDetail.length()>0)
			{
				for(var i:uint = 0;i<fltDetail.length();i++)
				{
					var dtxm:XML				= fltDetail[i];
					var ftDetail:VoFaultDetail 	= new VoFaultDetail();
					ftDetail.errorCode			= dtxm.child( "errorCode" );
					ftDetail.errorStack			= dtxm.child( "errorStack" );
					detailAr.push( ftDetail );
				}
			}
		}
	}
}
class VoEsitoNegativoImpl extends VoEsitoNegativo
{
	public function VoEsitoNegativoImpl(esito:XML=null)
	{
		super();
		create(esito);
	}
	public function create(esito:XML):void
	{
		if(esito==null)return;
		this.codiceErrore 		= esito.child("codiceErrore");
		this.descErrore			= esito.child("descErrore");
		this.dettaglio			= esito.child("dettaglio");	
		var listaEcc:XMLList	= esito.child("listaEccezioni");
		if(listaEcc!=null && listaEcc.length()>0)
		{
			this.listaEccezioni = new VoListaEccezioniImpl(listaEcc[0]);
		}
	}
}
class VoListaEccezioniImpl extends VoListaEccezioni
{
	internal var list:Array;
	public function VoListaEccezioniImpl(listaEccezioni:XML = null)
	{
		super();
		list = new Array();
		iterator = new ArrayIterator(list);
		create(listaEccezioni);
	}
	private function create(listaEccezioni:XML = null):void
	{
		if(listaEccezioni==null)return;
		var eccezioni:XMLList	= listaEccezioni.child("eccezione");
		for(var i:uint = 0;i<eccezioni.length();i++)
		{
			var voEccezione:VoEccezioneImpl = new VoEccezioneImpl(eccezioni[i]);
			list.push( voEccezione );
		}
		list = list.reverse();
	}
	 	
	public override function getLength():uint
	{
		return list.length;
	}
	 			
	public override function getEccezione(index:uint):VoEccezione
	{
		return list[index];
	}
}
class VoEccezioneImpl extends VoEccezione
{
	public function VoEccezioneImpl(eccezione:XML)
	{
		super();
		create(eccezione);	
	}
	private function create(eccezione:XML):void
	{
		this.codiceEccezione 		= eccezione.child("codiceEccezione");
		this.codiceEccezioneCampo	= eccezione.child("codiceEccezioneCampo");
		this.descEccezione			= eccezione.child("descEccezione");
		this.nomeCampo				= eccezione.child("nomeCampo");
		this.valoreCampo			= eccezione.child("valoreCampo");
		this.descEccezioneCampo		= eccezione.child("descEccezioneCampo");
		this.ROI					= eccezione.child("ROI");
	}
}
import it.lisit.siss.flex.communication.event.VoListaWarning;
class VoListWarningImpl extends VoListaWarning
{
	private var lista:Array;
	public function VoListWarningImpl(list:XML=null)
	{
		super();
		iterator = new ArrayIterator();
		create(list);
	}
	private function create(list:XML):void
	{
		if(list==null)return;
		lista = new Array();
		var warnings:XMLList = list.child("warning");
		for(var i:uint=0;i<warnings.length();i++)
		{
			var varn:VoWarning = new VoWarningImpl(warnings[i]);
			lista.push( varn );
		}
		lista = lista.reverse();
		iterator = new ArrayIterator(lista);
	}
	override public function lenght():uint
	{
		return lista.length;
	}
	override public function getWarning(index:uint):VoWarning
	{
		 return lista[index];
	}
}

import it.lisit.siss.flex.communication.event.VoWarning;
import it.lisit.siss.flex.utility.IIterator;
import it.lisit.siss.flex.utility.ArrayIterator;
import it.lisit.siss.flex.communication.event.VoFaultDetail;
class VoWarningImpl extends VoWarning
{
	public function VoWarningImpl(warning:XML)
	{
		super();
		create(warning);
	}
	private function create(warning:XML):void
	{
		this.codiceWarning = warning.child("codiceWarning");
		this.codiceWarningCampo = warning.child("codiceWarningCampo");
		this.descWarning = warning.child("descWarning");
		this.descWarningCampo = warning.child("descWarningCampo");
		this.nomeCampo = warning.child("nomeCampo");
		this.ROI = warning.child("ROI");
		this.valoreCampo = warning.child("valoreCampo");
	}
}