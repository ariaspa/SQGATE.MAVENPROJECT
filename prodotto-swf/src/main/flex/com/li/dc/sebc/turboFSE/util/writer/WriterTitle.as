package com.li.dc.sebc.turboFSE.util.writer
{
	import it.lispa.siss.sebc.middleground.entity.response.EsitoNegativo;
	import it.lispa.siss.sebc.middleground.entity.response.ListaWarning;
	
	import mx.collections.ArrayCollection;
	import mx.events.ValidationResultEvent;
	import mx.rpc.Fault;
	import mx.rpc.events.FaultEvent;
	import mx.validators.Validator;
	
	public class WriterTitle
	{
		public function WriterTitle()
		{
		}
		private function getMessageListaWarning():String
		{
			return "Warnigs";
		}
		private function getMessageEsitoNegativo():String
		{
			return "Esito negativo";
		}
		private function getMessageValidatorEvent():String
		{
			return "Validazione";
		}
		private function getMessageResponseFault():String
		{
			return "Fault";
		}
		private function getMessageFaultEvent():String
		{
			return "Fault interno";
		}
		private function getMessageArray():String
		{
			return "Lista";
		}
		public function getTitle(obj:Object):String
		{
			if(obj is ArrayCollection)
			{
				return getMessageArray( );
			}else if(obj is Array)
			{
				return getMessageArray( );
			}else if(obj is FaultEvent)
			{
				return getMessageFaultEvent( );
			}else if(obj is Fault)
			{
				return getMessageFaultEvent( );
			}else if(obj is ValidationResultEvent)
			{
				return getMessageValidatorEvent( );
			}else if(obj is Validator)
			{
				return getMessageValidatorEvent( ); 
			}else if(obj is EsitoNegativo) 
			{
				return getMessageEsitoNegativo( );
			}else if(obj is it.lispa.siss.sebc.middleground.entity.response.Fault)
			{
				return getMessageResponseFault( );
			}else if(obj is ListaWarning)
			{
				return getMessageListaWarning( );
			}else if(obj is String)
			{
				return "Messaggio";
			}else if(obj is Object)
			{
				return "Messaggio";
			} 
			return "";
		}
	}
}