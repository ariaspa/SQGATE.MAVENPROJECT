package com.li.dc.sebc.turboFSE.util.writer
{
	import com.li.dc.sebc.turboFSE.util.ArrayCollectionIterator;
	import com.li.dc.sebc.turboFSE.util.StringWriter;
	
	import it.lispa.siss.sebc.flex.collection.ArrayIterator;
	import it.lispa.siss.sebc.flex.collection.IIterator;
	import it.lispa.siss.sebc.middleground.entity.response.Detail;
	import it.lispa.siss.sebc.middleground.entity.response.Eccezione;
	import it.lispa.siss.sebc.middleground.entity.response.EsitoNegativo;
	import it.lispa.siss.sebc.middleground.entity.response.FaultDetail;
	import it.lispa.siss.sebc.middleground.entity.response.ListaEccezioni;
	import it.lispa.siss.sebc.middleground.entity.response.ListaWarning;
	import it.lispa.siss.sebc.middleground.entity.response.WarningType;
	
	import mx.collections.ArrayCollection;
	import mx.events.ValidationResultEvent;
	import mx.rpc.Fault;
	import mx.rpc.events.FaultEvent;
	import mx.validators.ValidationResult;
	import mx.validators.Validator;
	
	public class WriterBody
	{
		public function WriterBody()
		{
		}
		 
		private function  createObject(obj:Object, writer:StringWriter):void
		{
			var temp:StringWriter = new StringWriter();
			for(var s:String in obj)
			{
				if(s.length>0)
				{
					var key:String 		= s;
					var value:String 	= ""+obj[s];
					if(key.length>0 && value.length>0)
					{
						temp.add( key + " : " + value );
						temp.newLine();
					}
				}
			}
			 
			if(temp.getLength()>=1)
			{
				writer.newLine();
				
				for(var i:uint = 0;i<temp.getLength();i++)
				{
					writer.add( temp.getItem( i ) );
				}
			}
		}
		
		private function  createString(obj:String, writer:StringWriter):void
		{
			writer.newLine();
			writer.add( obj );
		}
		private function createWarningType(warn:WarningType, writer:StringWriter):void
		{
			addLine("codice warning : "+warn.codiceWarning,writer);
			addLine("codice warning campo : "+warn.codiceWarningCampo,writer);
			addLine("descrizione warning : "+warn.descWarning,writer);
			addLine("descrizione warning campo : "+warn.descWarningCampo,writer);
			addLine("nome campo : "+warn.nomeCampo,writer);
			addLine("valore campo : "+warn.valoreCampo,writer);
			addLine("roi : "+warn.roi,writer);
		}
		private function  createListaWarning(obj:ListaWarning, writer:StringWriter):void
		{
			if(obj.warning!=null && obj.warning.length>0)
			{
				writer.add("Lista warnings : ");
				writer.newLine();
				
				var oldn:int		= writer.getTabsAtNewLine();
				var lineChar:String	= writer.getCharLine();
				var n:int			= (oldn<0) ? 2 : 1;
				writer.setTabsAtNewLine(n,"");
				
				var iter:IIterator = new ArrayCollectionIterator( obj.warning );
				while(iter.hasNext())
				{
					var warn:WarningType = iter.next() as WarningType;
					createWarningType( warn ,writer);
				}
				writer.setTabsAtNewLine();
			}else
			{
				writer.add("Warning");
			} 
		}
		private function createResponseFault(obj:it.lispa.siss.sebc.middleground.entity.response.Fault, writer:StringWriter):void
		{
			writer.add("FAULT : ");
			writer.newLine( );
			writer.add("fault code : "+obj.faultcode);
			writer.newLine( );
			writer.add("fault string : "+obj.faultstring);
			writer.newLine( );
			
			if(obj.detail!=null && obj.detail.faultDetail!=null)
			{
				writer.tab();
				writer.add("detail : "+obj.detail.faultDetail.errorCode);
				
				if(obj.detail.faultDetail.errorStack!=null && obj.detail.faultDetail.errorStack.length>0)
				{
					writer.newLine( );
					writer.add("error Stack");
					var iter:IIterator = new ArrayCollectionIterator(obj.detail.faultDetail.errorStack);
					while(iter.hasNext())
					{
						var str:String = iter.next() as String;
						addLine(str,writer);
					}		
				}
			}
		}
		
		private function createEsitoNegativoType(obj:EsitoNegativo, writer:StringWriter):void
		{
			writer.add("ESITO NEGATIVO :");
			writer.newLine(2);
			writer.tab();
			writer.add( "codice errore : "+ obj.codiceErrore);
			
			writer.newLine();
			writer.tab();
			writer.add( "descrizione errore : "+ obj.descErrore);
		  
			if(obj.listaEccezioni!=null && obj.listaEccezioni.eccezione!=null && obj.listaEccezioni.eccezione.length>0)
			{
				writer.newLine(2);
				writer.tab();
				writer.add( "listaEccezioni : ");
				writer.newLine();
				
				var oldn:int		= writer.getTabsAtNewLine();
				var lineChar:String	= writer.getCharLine();
				var n:int			= (oldn<0) ? 3 : 1;
				writer.setTabsAtNewLine(n,"");
				
				var iter:IIterator = new ArrayCollectionIterator( obj.listaEccezioni.eccezione );
				
				while(iter.hasNext())
				{
					var ecc:Eccezione =  iter.next() as Eccezione;
					writer.add( "Eccezione : " );
					writer.newLine();
					writer.tab();
					
					addLine("codice eccezione : "+ecc.codiceEccezione,writer);
					addLine("codice eccezione campo : "+ecc.codiceEccezioneCampo,writer);
					addLine("descrizione eccezione : "+ecc.descEccezione,writer);
					addLine("descrizione eccezione campo : "+ecc.descEccezioneCampo,writer);
					addLine("nome campo : "+ecc.nomeCampo,writer);
					addLine("roi : "+ecc.roi,writer);
					addLine("valore campo : "+ecc.valoreCampo,writer);
				}
				writer.setTabsAtNewLine(oldn,lineChar);
			}
		}
		private function addLine(str:String, writer:StringWriter):void
		{
			writer.newLine();
			writer.tab();
			writer.add( str );
		}
		private function createFaultFlex(obj:Fault, writer:StringWriter):void
		{
			writer.add("FAULT ");
			writer.newLine(2);
			if(obj.faultCode!=null && obj.faultCode.length>0)
			{
				writer.add("faultCode : "+obj.faultCode );
				writer.newLine();
			}
			if(obj.message!=null && obj.message.length>0)
			{
				writer.add("message : "+obj.message );
				writer.newLine();
			}
			if(obj.faultDetail!=null && obj.faultDetail.length>0)
			{
				writer.add("faultDetail : "+obj.faultDetail );
				writer.newLine();
			}
		}
		private function createEsitoNegativo(obj:EsitoNegativo, writer:StringWriter):void
		{
			createEsitoNegativoType( obj, writer );
		}
		private function createValidator(validator:Validator, writer:StringWriter ):void
		{
			if(validator!=null && validator.property != null && validator.property.length>0 && 
				validator.requiredFieldError!=null && validator.requiredFieldError.length>0)
			{
				writer.add("Validazione - la proprietà : "+validator.property );
				writer.newLine();
				writer.add(validator.requiredFieldError);
			}else
			{
				writer.add("Errore interno");	
			}
		}
		
		private function createValidatorEvent( event:ValidationResultEvent, writer:StringWriter ):void
		{
			if(event.results!=null)
			{
				writer.add("VALIDAZIONE ");
				writer.newLine(2);
				if(event.results!=null && event.results.length>0)
				{
					var oldn:int		= writer.getTabsAtNewLine();
					var oldChar:String	= writer.getCharLine();
					var n:int = (oldn < 0 ) ? 2 : oldn + 2;
					writer.setTabsAtNewLine( n, "" );
					var ite:IIterator = new ArrayIterator(event.results);
					while(ite.hasNext())
					{
						var valid:ValidationResult = ite.next() as ValidationResult;
						if(valid.isError)
						{
							writer.add( "Codice di errore : "+ valid.errorCode+", messaggio : "+valid.errorMessage );
							writer.newLine(); 
						}
					}
					writer.setTabsAtNewLine(oldn,oldChar);
				}
			}
			if(event.field !=null)
			{
				writer.add("Campo : "+ event.field);
			}
		}
		
		private function transformEsitoSeb( obj:Fault ):Array
		{
			var list:Array			= new Array();
			var str:String			= obj.faultString;
			var listDetails:Array	= str.split( "|" );
			for(var i:uint = 0;i<listDetails.length;i++)
			{
				var detsStr:String		= listDetails[i];
				
				var esitoStr:Array 		= detsStr.split("");
				var codDesc:Array		= esitoStr[0].split(".");
				
				var esito:EsitoNegativo = new EsitoNegativo();
				esito.codiceErrore		= codDesc[0];
				esito.descErrore		= codDesc[1];
				var temp:Array			= new Array();		
				for(var k:uint = 1;k<esitoStr.length;i++)
				{
					var ecc:Array 					= esitoStr[k].split(",");
					var eccezione:Eccezione			= new Eccezione();
					eccezione.codiceEccezione		= ecc[0];
					eccezione.codiceEccezioneCampo	= ecc[1]; 
					eccezione.descEccezione			= ecc[2]; 
					eccezione.descEccezioneCampo	= ecc[3]; 
					eccezione.nomeCampo				= ecc[4]; 
					eccezione.roi					= ecc[5]; 
					eccezione.valoreCampo			= ecc[6]; 
					temp.push( eccezione );
				} 
				esito.listaEccezioni 			= new ListaEccezioni(  );	
				esito.listaEccezioni.eccezione	= new ArrayCollection( temp );
				list.push( esito );
			}
			return list;
		}
		private function transformErrorSeb( obj:Fault ):it.lispa.siss.sebc.middleground.entity.response.Fault
		{
			var fseb:it.lispa.siss.sebc.middleground.entity.response.Fault = new it.lispa.siss.sebc.middleground.entity.response.Fault();
			fseb.faultcode			= "error load pdl";
			fseb.faultstring		= obj.faultString;
			fseb.detail 						= new Detail();
			fseb.detail.faultDetail 			= new FaultDetail();
			fseb.detail.faultDetail.errorCode	= obj.faultDetail;
			fseb.detail.faultDetail.errorStack	= new ArrayCollection();
		    return fseb;
		}
		
		private function transformFaultSeb(obj:Fault):it.lispa.siss.sebc.middleground.entity.response.Fault
		{
			var fseb:it.lispa.siss.sebc.middleground.entity.response.Fault = new it.lispa.siss.sebc.middleground.entity.response.Fault();
			var str:String			= obj.faultString;
			var list:Array			= str.split("|");
			if(list!=null && list.length>0)
			{ 
				var faultcode:String	= list[0].split(":")[1];
				var faultstring:String	= list[1].split(":")[1];
				var details:Array		= list[2].split(",");
					 
				fseb.detail 						= new Detail();
				fseb.detail.faultDetail 			= new FaultDetail();
				var errorCode:String				= null;
				var t:Array							= new Array();
				if(details!=null && details.length>0)
				{
					errorCode 	= details[0].split(":")[1];
					for(var i:uint = 1;i<details.length; i +=2)
					{
						t.push(details[i].split(":")[1]);
					}
				}
				fseb.detail.faultDetail.errorCode 	= errorCode;
				fseb.detail.faultDetail.errorStack 	= new ArrayCollection( t );
				fseb.faultcode						= faultcode;
				fseb.faultstring					= faultstring;
			}
			return 	fseb;
		}
		 
		private function intCreateArray(obj:Array, writer:StringWriter):void
		{
			var charLine:String;
			var tbs:int;
			var n:int;
			writer.add("Lista");
			writer.newLine(2); 
			n					= writer.getTabsAtNewLine();
			charLine 			= writer.getCharLine();
			tbs					= ( n >=0 ) ? n + 2 : 2; 
			writer.setTabsAtNewLine( tbs , "" );
			createArray( obj as Array , writer );
			writer.setTabsAtNewLine( n , charLine );
		}
		private function createArray( list:Array, writer:StringWriter ):void
		{
			for(var i:int = 0; i<list.length; i++)
			{
				if(list.length>1 && i >=1)
				{
					writer.add("------------------------------------");
				}
				writer.newLine();
				getInternalBody( list[i], writer );	
			}
		}
		
		private function createFault( obj:Fault, writer:StringWriter ):void
		{
			var faultcode:String		= obj.faultCode;
			if(faultcode=="faultSeb")
			{
				createResponseFault( transformFaultSeb( obj ) ,writer );
			}else if(faultcode=="errorSeb")
			{
				createResponseFault( transformErrorSeb( obj ) ,writer );
			}else if(faultcode=="esitoNegativo")
			{
				getInternalBody( transformEsitoSeb( obj ) ,writer);
			}else  
			{
				// fault flex
				createFaultFlex( obj  ,writer);
			}
		}
		
		private function getInternalBody(obj:Object, writer:StringWriter ):void
		{
			if(obj is ArrayCollection)
			{
				getInternalBody( (obj as ArrayCollection).toArray(), writer  );
			}else if(obj is Array)
			{
				intCreateArray(obj as Array,writer);
			}else if(obj is FaultEvent)
			{
				createFault( (obj as FaultEvent).fault , writer );	 
			}else if(obj is Fault)
			{
				// FAULT flex
				createFault(obj as Fault, writer);
			}else if(obj is it.lispa.siss.sebc.middleground.entity.response.Fault)
			{
				// FAULT entity
				 createResponseFault(obj as it.lispa.siss.sebc.middleground.entity.response.Fault, writer);
				
			}else if(obj is ValidationResultEvent)
			{
				 createValidatorEvent(obj as ValidationResultEvent, writer);
			}else if(obj is Validator)
			{
				 createValidator(obj as Validator, writer); 
			}else if(obj is EsitoNegativo) 
			{
				 createEsitoNegativo(obj as EsitoNegativo, writer);
			}else if(obj is ListaWarning) 
			{
				  createListaWarning(obj as ListaWarning, writer);
			}else if(obj is WarningType) 
			{
				  createWarningType(obj as WarningType, writer);
			}else if(obj is String)
			{
				  createString(obj as String, writer);
			}else if(obj is Object)
			{
				  createObject(obj, writer);
			} 
		}
		public function getBody( obj:Object ):String
		{
			var writer:StringWriter = new StringWriter();
			getInternalBody( obj,  writer );
			return writer.getString();
		}
	}
}









