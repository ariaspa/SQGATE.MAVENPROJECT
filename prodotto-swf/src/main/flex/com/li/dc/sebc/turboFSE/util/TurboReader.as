package com.li.dc.sebc.turboFSE.util
{
	import com.li.dc.sebc.turboFSE.util.writer.WriterBody;
	import com.li.dc.sebc.turboFSE.util.writer.WriterTitle;
	import com.li.dc.sebc.turboFSE.util.writer.WriterType;
	
	import it.lispa.siss.library.ui.menustandard.Footer;
	import it.lispa.siss.sebc.flex.messages.ConstStatus;
	import it.lispa.siss.sebc.flex.messages.ITransformMessage;
	import it.lispa.siss.sebc.flex.messages.Message;
	import it.lispa.siss.sebc.middleground.entity.response.Eccezione;
	import it.lispa.siss.sebc.middleground.entity.response.EsitoNegativo;
	import it.lispa.siss.sebc.middleground.entity.response.ListaWarning;
	import it.lispa.siss.sebc.middleground.entity.response.WarningType;
	
	import mx.collections.ArrayCollection;
	
	public class TurboReader implements ITransformMessage
	{
		
		private var writerType:WriterType;
		private var writerBody:WriterBody;
		private var writerTitle:WriterTitle 
		private var footer : Footer;
		 
		public function TurboReader(footer : Footer)
		{
			
			/* gestione mista */
			writerType 	= new WriterType();
			writerBody 	= new WriterBody();
			writerTitle = new WriterTitle(); 
			this.footer = footer;
		}
		private function getTitle(obj:Object):String
		{
			return writerTitle.getTitle( obj );
		}
		private function getBody(obj:Object):String
		{
			return writerBody.getBody( obj ); 
		}
		private function getType(obj:Object):String
		{
			return writerType.getType( obj ); 
		} 
	 	//////////////////////////////////////////////////////////////////  
	 	//////////////////////////////////////////////////////////////////  
		private function createWarningType( obj : WarningType ):Object
		{
			var o : Object 			= new Object();
			o.codiceWarning  		= obj.codiceWarning;
			o.codiceWarningCampo  	= obj.codiceWarningCampo;
			o.descWarning  			= obj.descWarning;
			o.descWarningCampo  	= obj.descWarningCampo;
			o.nomeCampo  			= obj.nomeCampo;
			o.roi  					= obj.roi;
			o.valoreCampo  			= obj.valoreCampo;
			return o;
		}
		private function createListaWarning(obj : ListaWarning ):Object
		{
			var listWarning : Array = new Array();
			if(obj.warning!=null)
			{
				var list : Array = obj.warning.toArray();
				for(var i:uint = 0;i<list.length;i++)
				{
					listWarning.push( createWarningType(list[i] as WarningType) );
				}
			}
			return listWarning;
		}
		private function createEsitoNegativo( obj : EsitoNegativo ):Object
		{
			var testa : Object 	= new Object();
			testa.codiceErrore 	= obj.codiceErrore;
			testa.descErrore 	= obj.descErrore;
			var listaEccezioni :Array = new Array();
			listaEccezioni.push( testa );
			if(obj.listaEccezioni !=null  && obj.listaEccezioni.eccezione!=null)
			{
				var list : Array = obj.listaEccezioni.eccezione.toArray();
				for(var i:uint = 0;i<list.length;i++)
				{
					var e: Eccezione 			= list[i] as Eccezione;
					var ecc : Object 			= new Object();
					ecc.codiceEccezione 		= e.codiceEccezione;
					ecc.codiceEccezioneCampo 	= e.codiceEccezioneCampo;
					ecc.descEccezione 			= e.descEccezione;
					ecc.nomeCampo 				= e.nomeCampo;
					ecc.roi 					= e.roi;
					ecc.valoreCampo 			= e.valoreCampo;
					listaEccezioni.push( ecc );	
				}
			}
			return listaEccezioni;
		}
		private function createFaultEntity( fault : it.lispa.siss.sebc.middleground.entity.response.Fault ):Object
		{
			var testa : Object = new Object();
			/* o.faultcode 	= fault.faultcode; 
			o.faultstring 	= fault.faultstring;  */
			testa.codiceErrore 	= fault.faultcode; 
			testa.descErrore 	= fault.faultstring; 
			if(fault.detail!=null && fault.detail.faultDetail!=null)
			{
				testa.errorCode = fault.detail.faultDetail.errorCode; 
				testa.errorStack = fault.detail.faultDetail.errorStack; 
			}		
			return testa;	
		}
		public function createMessage( obj:Object ):Message
		{
			if(obj == null)return null;
			if(footer!=null)
			{
				var objMsg : Object = null;
				var type : String 	= "";
				var list : Array 	= new Array();
				
				if(obj is ArrayCollection || obj is Array)
				{
					return null;
				}else if(obj is it.lispa.siss.sebc.middleground.entity.response.Fault)
				{
					// FAULT entity
					objMsg = createFaultEntity(obj as it.lispa.siss.sebc.middleground.entity.response.Fault);
					if(objMsg!=null){
						type = ConstStatus.ERROR;
						list.push( objMsg );
					}
				}else if(obj is EsitoNegativo) 
				{
					list = createEsitoNegativo(obj as EsitoNegativo) as Array;
					if(list!=null && list.length>0)
					{
						type = ConstStatus.ERROR;
					}
				}else if(obj is ListaWarning) 
				{
					list = createListaWarning(obj as ListaWarning) as Array;
					if(list!=null && list.length>0)
					{
						type = ConstStatus.WARNING;
					}
				}else if(obj is WarningType) 
				{
					objMsg = createWarningType(obj as WarningType);
					if(objMsg!=null)
					{
						type = ConstStatus.WARNING;
						list.push( objMsg );
					}
				}else
				{
					return new Message(getTitle(obj), getBody(obj) , getType( obj ) );
				}
				if(list!=null)
				{
					if( type == ConstStatus.ERROR)
					{
						footer.setError( list );	
					}else if(type == ConstStatus.WARNING)
					{
						footer.setWarning( list );
					}
				}
			}
			return null;
		}
 
		
		
		/*protected function createMessageEvent(msg:IMessage):String
		{
			var result:String		= "\n";
			var body:String			= (msg.body!=null) ? "Body : "+msg.body.toString()+"\n" : ""; 
			var clientId:String		= (msg.clientId!=null && msg.clientId.length>0) ? "Client Id : "+msg.clientId+"\n" : ""; 
			var destination:String	= (msg.destination!=null && msg.destination.length>0) ? "Destination : "+msg.destination+"\n" : "";
			var headers:String		= (msg.headers!=null) ? "Headers : "+msg.headers.toString()+"\n" : "";
			var msgId:String		= (msg.messageId!=null && msg.messageId.length) ? "Message Id : "+msg.messageId+"\n" : "";
			var timestmp:String		= (msg.timestamp!=undefined) ? "Timestamp : "+msg.timestamp+"\n" : "";
			var timeToLive:String	= (msg.timeToLive!=undefined) ? "Time To Live : "+msg.timeToLive+"\n" : "";
			result += clientId + destination + headers + msgId + body + timestmp + timeToLive;    
			return result 
		}
		////////////////////////////////////////////
		protected function getMessageObject(obj:Object):Message
		{
			var m:String = obj.toString()+"\n";
			for(var s:String in obj)
			{
				m += s + " : " + obj[s]+"\n";
			}
			return new Message(ConstStatus.WARNING, m ,ConstStatus.WARNING);
		}
		protected function getMessageArray(listObje:Array,writer:StringWriter):Message 
		{
			writer.add( "Lista : " );
			writer.newLine(2);
			var nt:int	= writer.getTabsAtNewLine()<0 ? 1 : writer.getTabsAtNewLine() + 1;
			writer.setTabsAtNewLine( nt , "*" );
			//	
			var iterator:IIterator = new ArrayIterator(listObje);
			while(iterator.hasNext())
			{
				var mmm:Message = createMessage( iterator.next() ,writer );
				writer
				
				writer.tab();
				writer.add("*");
				writer.tab();
				
				str +="*" + mmm.message + "\n";  
			}
			return  new Message(title,str,type);
		}
		protected function getMessageFaultMap(msg:Fault):Message
		{
			return null;
		}
		protected function getMessageFaultEventMap(ev:FaultEvent):Message
		{
			return null;
		}
		protected function getMessageFault(msg:Fault):Message
		{
			var messageMap:Message	= getMessageFaultMap(msg);
			if(messageMap==null)
			{
				var result:String	= "FAULT\n\n";
				var name:String		= (msg.name!=null && msg.name.length>0) ? "Nome : "+msg.name+"\n" : "";
				var content:String	= (msg.content!=null) ? "Content : "+ msg.content.toString() +"\n": ""; 
				var message:String	= (msg.message!=null && msg.message.length>0) ?"Message : "+ msg.message +"\n": "";
				var rootCause:String	= (msg.rootCause!=null) ?"Cause : "+ msg.rootCause.toString() +"\n": "";
				var errorId:String		= "Error ID : "+ msg.errorID+"\n"
				var faultCode:String	= (msg.faultCode!=null && msg.faultCode.length>0) ?"Fault Code : "+ msg.faultCode +"\n": "";
				var faultDetail:String	= (msg.faultDetail!=null && msg.faultDetail.length>0) ?"Fault Detail : "+ msg.faultDetail +"\n": "";
				var faultString:String	= (msg.faultString!=null && msg.faultString.length>0) ?"Fault message : "+ msg.faultString +"\n": "";
				result += name + errorId + rootCause + content + message + faultCode + faultDetail + faultString;
				return new Message("FAULT",result,ConstStatus.ERROR)
			}
			return messageMap;
		}
		protected function getMessageFaultEvent(ev:FaultEvent):Message
		{
			var messageMap:Message	= getMessageFaultEventMap(ev);
			if(messageMap==null)
			{
				var bodyResult:String 	= "FAULT EVENT\n\n";
				var messageEvent:String = createMessageEvent(ev.message) + "\n";
				var id:String			= (ev.messageId!=null && ev.messageId.length>0) ? ev.messageId : ""; 
				var headers:String		= (ev.headers!=null) ? "Headers : "+ev.headers.toString() +"\n": ""; 
				var statusCode:String	= "SatusCode : "+ ev.statusCode.toString()+"\n";
				var msgF:Message		= createMessage(ev.fault);
				var faultString:String	= msgF.message;
				var title:String		= msgF.title;
				id = (id.length>0) ? "Message id : "+id+"\n" : id;
				bodyResult += id + messageEvent + headers +  statusCode + faultString; 
				return new Message(title,bodyResult,ConstStatus.ERROR);
			}
			return messageMap;
		}
		protected function getMessageValidatorEvent(event:ValidationResultEvent):Message
		{
			if(event.results!=null)
			{
				var msg:String = "";
				var ite:IIterator = new ArrayIterator(event.results);
				while(ite.hasNext())
				{
					var valid:ValidationResult = ite.next() as ValidationResult;
					if(valid.isError)
					{
						msg += "  * Error Code : "+ valid.errorCode+", message : "+valid.errorMessage+"\n"
					}
				}
			}
			var mes:String		= event.message + "\n"
			var field:String	= (event.field !=null) ? "Campo : "+ event.field + "\n" : "";
			var bd:String		= field+" Messagge : "+mes+msg;
			return new Message(ConstStatus.ERROR,bd,ConstStatus.ERROR);
		}
		protected function getMessageValidator(validator:Validator):Message
		{
			var property:String = (validator.property != null && validator.property.length>0)? "La proprietà : " +validator.property +"\n" : ""; 	
			var msg:String		= (validator.requiredFieldError!=null && validator.requiredFieldError.length>0) ? validator.requiredFieldError : "";
			if(msg.length>0)
			{
				return new Message(ConstStatus.ERROR,property + msg,ConstStatus.ERROR);
			}
			return null;
		}
		protected function getMessageString(str:String):Message
		{
			return new Message(ConstStatus.INFO,str,ConstStatus.INFO);
		}
		
		protected function getMessageListaWarning(obj:ListaWarning):Message
		{
			return new Message(ConstStatus.WARNING,"",ConstStatus.WARNING);
		}
		
		protected function getMessageResponseFault(obj:it.lispa.siss.sebc.middleground.entity.response.Fault):Message
		{
			const TAB:String	= "	 ";
			var pnt:String = TAB+TAB+TAB+"* ";
			var str:String	= "FAULT :\n"+TAB+"fault code : "+obj.faultcode;
			str += "\n"+TAB+"fault string : "+obj.faultstring;
			if(obj.detail!=null && obj.detail.faultDetail!=null)
			{
				str += "\n"+TAB+"detail : "+obj.detail.faultDetail.errorCode;
				if(obj.detail.faultDetail.errorStack!=null && obj.detail.faultDetail.errorStack.length>0)
				{
						
				}
			}
			return new Message(ConstStatus.ERROR,str,ConstStatus.ERROR);
		}
		protected function getMessageEsitoNegativoType(obj:EsitoNegativo):Message
		{
			const TAB:String	= "	 ";
			var str:String		= "ESITO NEGATIVO :\n"+TAB+"codice errore : " + obj.codiceErrore;
			str += "\n"+TAB+"descrizione errore : "+obj.descErrore;
			str +="\n"+TAB+"listaEccezioni : ";
			var pnt:String = TAB+TAB+TAB+"* ";
			if(obj.listaEccezioni!=null&& obj.listaEccezioni.eccezione!=null && obj.listaEccezioni.eccezione.length>0)
			{
				var iter:IIterator = new ArrayCollectionIterator( obj.listaEccezioni.eccezione );
				while(iter.hasNext())
				{
					var ecc:Eccezione =  iter.next() as Eccezione;
					str += "\n"+TAB+TAB+"Eccezione : "
					str += "\n"+pnt+"codice eccezione : "+ecc.codiceEccezione;
					str += "\n"+pnt+"codice eccezione campo : "+ecc.codiceEccezioneCampo;
					str += "\n"+pnt+"descrizione eccezione : "+ecc.descEccezione;
					str += "\n"+pnt+"descrizione eccezione campo : "+ecc.descEccezioneCampo;
					str += "\n"+pnt+"nome campo : "+ecc.nomeCampo;
					str += "\n"+pnt+"roi : "+ecc.roi;
					str += "\n"+pnt+"valore campo : "+ecc.valoreCampo+"\n";
				}
			}
			return new Message(ConstStatus.ERROR,str,ConstStatus.ERROR);
		}
		protected function getMessageEsitoNegativo(obj:EsitoNegativo):Message
		{
		 	return getMessageEsitoNegativoType( obj );
		}
		*/
	}
}