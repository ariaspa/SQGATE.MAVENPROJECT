package it.lisit.siss.flex.core
{
	import it.lisit.siss.flex.communication.event.VoEccezione;
	import it.lisit.siss.flex.communication.event.VoEsitoNegativo;
	import it.lisit.siss.flex.communication.event.VoFault;
	import it.lisit.siss.flex.communication.event.VoFaultDetail;
	import it.lisit.siss.flex.communication.event.VoListaWarning;
	import it.lisit.siss.flex.communication.event.VoWarning;
	
	public class TransformerObjects  
	{
		public function TransformerObjects()
		{
		}
		protected function readFault(vo:VoFault):String
		{
			var msg:String	 = "";
			var acapo:String = "\n";
			if(vo.faultcode!=null && vo.faultcode.length>0)
			{
				msg += "Fault code : "+vo.faultcode+acapo;
			}
			if(vo.faultstring!=null && vo.faultstring.length>0)
			{
				msg += "Fault : "+vo.faultstring+acapo;
			}
			vo.faultDetail.reset();
			if(vo.faultDetail.hasNext())
			{
				msg += "Fault detail : "+acapo;
				while(vo.faultDetail.hasNext())
				{
					var detail:VoFaultDetail = vo.faultDetail.next() as VoFaultDetail;
					if(detail.errorCode!=null && detail.errorCode.length>0)
					{
						msg += "Error code : "+detail.errorCode+acapo;
					}
					if(detail.errorStack!=null && detail.errorStack.length>0)
					{
						msg += "Error stack : "+detail.errorStack+acapo;
					}
				}
			}
			return msg;
		}
		protected function readWarning(vo:VoListaWarning):String
		{
			var msg:String	 = "";
			var acapo:String = "\n";	
			var counter:uint = 0;
			vo.iterator.reset();
			while(vo.iterator.hasNext())
			{
				var warn:VoWarning	= vo.iterator.next() as VoWarning;
				msg += "WARNING n° "+(++counter)+acapo; 
				if(warn.codiceWarning!=null && 	warn.codiceWarning.length>0)
				{
					msg += "Codice warning : "+warn.codiceWarning+acapo;
				}
				if(warn.nomeCampo!=null && warn.nomeCampo.length>0)
				{
					msg += "Nome campo  : "+warn.nomeCampo+acapo;
				}
				if(warn.valoreCampo!=null && warn.valoreCampo.length>0)
				{
					msg += "Valore campo  : "+warn.valoreCampo+acapo;
				}
				if(warn.codiceWarningCampo!=null && warn.codiceWarningCampo.length>0)
				{
					msg += "Codice campo warning : "+warn.codiceWarningCampo+acapo;
				}
				if(warn.descWarningCampo!=null && warn.descWarningCampo.length>0)
				{
					msg += "Descrizione campo warning : "+warn.descWarningCampo+acapo;
				}
				if(warn.ROI!=null && warn.ROI.length>0)
				{
					msg += "ROI : "+warn.ROI+acapo;
				}
				if(warn.descWarning!=null && warn.descWarning.length>0)
				{
					msg += "Descrizione warning : "+warn.descWarning+acapo;
				}
				msg += acapo;  	 
			} 
			return msg;
		}
		protected function readEsitoNegativo(vo:VoEsitoNegativo):String
		{
			var msg:String	 = "";
			var acapo:String = "\n";
			if(vo.codiceErrore!=null && vo.codiceErrore.length>0)
			{
				msg += "Codice errore : "+vo.codiceErrore+acapo;
			}
			if(vo.descErrore!=null && vo.descErrore.length>0)
			{
				msg += "Descrizione errore : "+vo.descErrore+acapo;
			}
			if(vo.dettaglio!=null && vo.dettaglio.length>0)
			{
				msg += "Dettaglio errore : "+vo.dettaglio+acapo;
			}
			if(vo.listaEccezioni!=null)
			{
				vo.listaEccezioni.iterator.reset();
				var counter:uint = 0;
				while(vo.listaEccezioni.iterator.hasNext())
				{
					var warn:VoEccezione	= vo.listaEccezioni.iterator.next() as VoEccezione;
					msg += "ECCEZIONE n° "+(++counter)+acapo;
					
					if(warn.codiceEccezione!=null && 	warn.codiceEccezione.length>0)
					{
						msg += "Codice eccezione : "+warn.codiceEccezione+acapo;
					}
					if(warn.nomeCampo!=null && warn.nomeCampo.length>0)
					{
						msg += "Nome campo  : "+warn.nomeCampo+acapo;
					}
					if(warn.valoreCampo!=null && warn.valoreCampo.length>0)
					{
						msg += "Valore campo  : "+warn.valoreCampo+acapo;
					}
					if(warn.codiceEccezioneCampo!=null && warn.codiceEccezioneCampo.length>0)
					{
						msg += "Codice campo eccezione : "+warn.codiceEccezioneCampo+acapo;
					}
					if(warn.descEccezioneCampo!=null && warn.descEccezioneCampo.length>0)
					{
						msg += "Descrizione campo eccezione : "+warn.descEccezioneCampo+acapo;
					}
					if(warn.ROI!=null && warn.ROI.length>0)
					{
						msg += "ROI : "+warn.ROI+acapo;
					}
					if(warn.descEccezione!=null && warn.descEccezione.length>0)
					{
						msg += "Descrizione eccezione : "+warn.descEccezione+acapo;
					}
					msg += acapo; 
				}
			}
			return msg;
		}
		protected function getTypeMessage(currMessage:Object):String
		{
			if(currMessage is VoListaWarning)
			{
				return ConstStatusBar.WARNING;
			}else if(currMessage is VoFault)
			{
				return ConstStatusBar.ERROR;
			}else if(currMessage is VoEsitoNegativo)
			{
				return ConstStatusBar.ERROR;
			}else if(currMessage is MessageObject)
			{
				return MessageObject(currMessage).type;
			}else if(currMessage is String)
			{
				return ConstStatusBar.INFO;
			} 
			return ConstStatusBar.INFO;
		}
		private function getInternalMessageObject(message:MessageObject):MessageObject
		{
			return new MessageObject(message.title,message.message,message.type);
		}
		protected function getFault(message:VoFault):MessageObject
		{
			var msg:String			= readFault( message );
			var title:String		= "FAULT";
			var type:String			= getTypeMessage(message);
			return new MessageObject(title,msg,type);
		}
		protected function getListaWarning(message:VoListaWarning):MessageObject
		{
			var msg:String			= readWarning( message );
			var title:String		= "WARNING";
			var type:String			= getTypeMessage(message);
			return new MessageObject(title,msg,type);
		}
		protected function getEsitoNegativo(message:VoEsitoNegativo):MessageObject
		{
			var msg:String			= readEsitoNegativo( message );
			var title:String		= "ESITO NEGATIVO";
			var type:String			= getTypeMessage(message);
			return new MessageObject(title,msg,type);
		}
		protected function getString(message:String):MessageObject
		{
			var msg:String			= message;
			var title:String		= "INFORMAZIONE";
			var type:String			= getTypeMessage(message);
			return new MessageObject(title,msg,type);
		}
		protected function getObject(message:Object):MessageObject
		{ 
			var msg:String			= message.toString(); 
			var title:String		= "INFORMAZIONE";
			var type:String			= getTypeMessage(message);
			return new MessageObject(title,msg,type);
		}
		public function readMessage(message:Object):MessageObject
		{ 
			var msg:MessageObject;
			if(message is MessageObject)
			{
				msg = getInternalMessageObject(message as MessageObject);
			}else if(message is VoListaWarning)
			{
				msg = getListaWarning(message as VoListaWarning);
			}else if(message is VoFault)
			{
				msg = getFault(message as VoFault); 
			}else if(message is VoEsitoNegativo)
			{
				msg = getEsitoNegativo(message as VoEsitoNegativo); 
			}else if(message is String)
			{
				msg = getString(message as String);  
			}else 
			{
				msg = getObject(message as Object);  
			} 
			return msg; 
		}
		 
	}
}