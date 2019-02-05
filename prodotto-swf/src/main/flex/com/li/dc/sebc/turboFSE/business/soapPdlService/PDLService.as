package com.li.dc.sebc.turboFSE.business.soapPdlService
{
	import com.li.dc.sebc.turboFSE.business.TurboService;
	
	import it.lisit.siss.flex.communication.AbstractServiceSEB;
	import it.lisit.siss.flex.communication.event.ServiceSEBCompleteEvent;
	import it.lisit.siss.flex.communication.event.ServiceSEBErrorEvent;
	import it.lisit.siss.flex.communication.event.ServiceSEBFaultEvent;
	import it.lisit.siss.flex.communication.event.VoEccezione;
	import it.lisit.siss.flex.communication.event.VoFault;
	import it.lisit.siss.flex.communication.event.VoFaultDetail;
	import it.lisit.siss.flex.communication.event.VoListaEccezioni;
	import it.lisit.siss.flex.communication.event.VoResponse;
	import it.lisit.siss.flex.utility.IIterator;
	import it.lispa.siss.sebc.flex.debug.Debug;
	
	import mx.rpc.Fault;
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;

	public class PDLService extends TurboService
	{
		
		protected var serviceSEB:AbstractServiceSEB;
		public function PDLService(responder:IResponder = null)
		{
			super( responder );
		}
		override public final function execute():void
		{
			serviceSEB = getService();
			if(serviceSEB!=null)
			{
				addListener(serviceSEB);
				executeService( );
			}else
			{
				throw new Error("PDLService, serviceSEB is null");
			}
		}
		/**
		 * esegue il servizio 
		 * 
		 */	
		protected function executeService( ):void
		{
			
		}
		protected function getDataResult(esitiPositivi:Array):Object
		{
			return null;
		}
		protected function getService():AbstractServiceSEB
		{
			return  null;
		}
		private function getfaultFromVoid( ):FaultEvent
		{
			var faultCode:String	= "AbstractServiceSEB";
		    var faultString:String	= "Response is void";
		    var faultDetail:String	= "";
		    var fault:Fault			= new Fault(faultCode,faultString,faultDetail);
			return new FaultEvent(FaultEvent.FAULT,false,false,fault,null,null);
		}
		private function isOK(str:String):Boolean
		{
			return (str != null && str.length>0);
		}
		private function getVaStr(str:String):String
		{
			if(isOK(str))return str;
			return " ";
		}
		private function getfaultSEBComplete(esitiNegativi:Array):FaultEvent
		{
			var faultCode:String	= "esitoNegativo";
		    var faultString:String	= ""; 
		    var virgola:String		=  ",";
			for(var i:uint = 0;i<esitiNegativi.length;i++)
			{
				var response:VoResponse = esitiNegativi[i];
				if(response.isEsitoNegativo)
				{
					var codErrore:String 		= response.esitoNegativo.codiceErrore;
					var descErrore:String 		= response.esitoNegativo.descErrore;
					var liEcc:VoListaEccezioni	= response.esitoNegativo.listaEccezioni;
					var iterator:IIterator		= liEcc.iterator;
					var strecc:String			= "";
					if(iterator!=null)
					{
						while(iterator.hasNext())
						{
							var ecc:VoEccezione = iterator.next() as VoEccezione;
							strecc += "*";
							strecc += getVaStr( ecc.codiceEccezione )+virgola;
							strecc += getVaStr( ecc.codiceEccezioneCampo )+virgola;
							strecc += getVaStr( ecc.descEccezione )+virgola;
							strecc += getVaStr( ecc.descEccezioneCampo )+virgola;
							strecc += getVaStr( ecc.nomeCampo )+virgola;
							strecc += getVaStr( ecc.ROI )+virgola;
							strecc += getVaStr( ecc.valoreCampo )
						}
						if(strecc.length>0)strecc+="*";
					}
					faultString += "|"+codErrore+"."+descErrore + strecc;
				}
			}
			if(faultString.length>0)
			{
				faultString +="|";
			}
			var fault:Fault	= new Fault(faultCode,faultString);
			return new FaultEvent(FaultEvent.FAULT,false,false,fault,null,null);	
		}
		private function getEventResult(esitiPositivi:Array):ResultEvent
		{
			var resultObject:Object = getDataResult( esitiPositivi );
			return new ResultEvent(ResultEvent.RESULT,false,false,resultObject,null,null);
		}
		private function getfaultFromSEBFaultEvent(e:ServiceSEBFaultEvent):FaultEvent
		{
			var vofault:VoFault 		= e.getFault();
			var faultcode:String		= "faultSeb";
			var faultstring:String 		= "faultcode:"+vofault.faultcode+"|faultstring:"+vofault.faultstring;
			var detail:IIterator 		= vofault.faultDetail;
			var detailStr:String		= "";
			Debug.logError( "PDLService.getfaultFromSEBFaultEvent detail : "+detail);
			if(detail!=null)
			{
				while(detail.hasNext())
				{
					var fdt:VoFaultDetail = detail.next() as VoFaultDetail;
					detailStr += "|errorCode:"+fdt.errorCode + ",errorStack:" + fdt.errorStack;
				}
			}
			var fault:Fault	= new Fault(faultcode,faultstring+detailStr); 
			return new FaultEvent(FaultEvent.FAULT,false,false,fault,null,null);
		}
		private function getfaultFromSEBErrorEvent(e:ServiceSEBErrorEvent):FaultEvent
		{
			var faultCode:String	= "errorSeb";
		    var faultString:String	= e.getMessage()
		    var faultDetail:String	= e.getBody() as String;
		    if(faultDetail==null)
		    {
		    	faultDetail = "no body";
		    }
		    var fault:Fault			= new Fault(faultCode,faultString,faultDetail);
			return new FaultEvent(FaultEvent.FAULT,false,false,fault,null,null);
		}
		private function addListener(servicepdl:AbstractServiceSEB):void
		{
			servicepdl.addEventListener(ServiceSEBCompleteEvent.SERVICE_COMPLETE,onServiceComplete);
			servicepdl.addEventListener(ServiceSEBErrorEvent.SERVICE_SEB_ERROR,onServiceError);
			servicepdl.addEventListener(ServiceSEBFaultEvent.SERVICE_SEB_FAULT,onServiceFault);
		}
		private function removeListener(servicepdl:AbstractServiceSEB):void
		{
			servicepdl.removeEventListener(ServiceSEBCompleteEvent.SERVICE_COMPLETE,onServiceComplete);
			servicepdl.removeEventListener(ServiceSEBErrorEvent.SERVICE_SEB_ERROR,onServiceError);
			servicepdl.removeEventListener(ServiceSEBFaultEvent.SERVICE_SEB_FAULT,onServiceFault);
		}
		private function onServiceFault(e:ServiceSEBFaultEvent):void
		{
			removeListener(e.target as AbstractServiceSEB);
			Debug.logError( "PDL FAULT : "+e.getFault().faultstring );
			responder.fault( getfaultFromSEBFaultEvent( e ) );
		}
		private function onServiceError(e:ServiceSEBErrorEvent):void
		{
			removeListener(e.target as AbstractServiceSEB);
			Debug.logError( "PDL ERROR : "+e.getMessage() );
			responder.fault( getfaultFromSEBErrorEvent( e ) );
		}
		private function onServiceComplete(e:ServiceSEBCompleteEvent):void
		{
			removeListener(e.target as AbstractServiceSEB);
			if(e.getLength() > 0)
			{
				var iterator:IIterator 	= e.iterator;
				var esitiPositivi:Array	= new Array();
				var esitiNegativi:Array	= new Array();
				 
				while(iterator.hasNext())
				{
					var response:VoResponse = iterator.next() as VoResponse;
					if(response.isEsitoNegativo)
					{
						 esitiNegativi.push( response );
					}else
					{
						esitiPositivi.push( response.esitoPositivo );
					}
				}
				var isFault:Boolean = (esitiPositivi.length==0);
				if(isFault)
				{
					responder.fault( getfaultSEBComplete(  esitiNegativi  ) );
				}else
				{
					responder.result( getEventResult( esitiPositivi ) );
				}	
			}else
			{
				responder.fault( getfaultFromVoid( ) );
			}
		}
	}
}