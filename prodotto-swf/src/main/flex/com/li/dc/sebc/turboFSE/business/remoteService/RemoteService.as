package com.li.dc.sebc.turboFSE.business.remoteService
{
	import com.li.dc.sebc.turboFSE.business.TurboService;
	
	import flash.events.IEventDispatcher;
	import flash.external.ExternalInterface;
	
	import mx.messaging.ChannelSet;
	import mx.messaging.channels.AMFChannel;
	import mx.messaging.channels.SecureAMFChannel;
	import mx.rpc.Fault;
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.InvokeEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;
	import mx.utils.URLUtil;

	public class RemoteService extends TurboService
	{
		public var destination:String;
		public function RemoteService(responder:IResponder=null,destination:String=null)
		{
			super(responder);
			this.destination = destination;
		}
		final protected function addListener(remote:RemoteObject):void
		{
			if(remote==null)return;
			remote.addEventListener(FaultEvent.FAULT,onFault);
			remote.addEventListener(ResultEvent.RESULT,onResult);
			remote.addEventListener(InvokeEvent.INVOKE,onInvoke);
		}
		final protected function removeListener(remote:RemoteObject):void
		{
			if(remote==null)return;
			remote.removeEventListener(FaultEvent.FAULT,onFault);
			remote.removeEventListener(ResultEvent.RESULT,onResult);
			remote.removeEventListener(InvokeEvent.INVOKE,onInvoke);
		}
		private function onFault(e:FaultEvent):void
		{
			var ro:RemoteObject = e.target as RemoteObject;   
			removeListener(ro);   
			ro.channelSet.disconnectAll(); 
			fault( e );
		}
		private function onResult(e:ResultEvent):void
		{
			var ro:RemoteObject = e.target as RemoteObject;   
			removeListener(ro);   
			ro.channelSet.disconnectAll(); 
			result( e );
		}
		private function onInvoke(e:InvokeEvent):void
		{
			invoke( e );
		}
		protected function fault(e:FaultEvent):void
		{ 
			responder.fault( e );
		}
		
		protected function result(e:ResultEvent):void
		{
			responder.result( e );
		}
		protected function invoke(e:InvokeEvent):void
		{
			
		}
		
	/**
    * Workaround per BlazeDS.
    */
 
		private function initChannelSetBlazeDS(contextRoot:String):ChannelSet
	    {
		    // workaround: blazeDS
		   var url:String = null;
		   if (ExternalInterface.available)
		   {
		   	url = ExternalInterface.call('eval','document.location.href');
		    	
	     	var port:int 			= URLUtil.getPort(url);
	     	var protocol:String 	= URLUtil.getProtocol(url);
	     	var serverName:String 	= URLUtil.getServerName(url);
	     	url = protocol + '://' + serverName;
	     	if (port != 0)
	     	{
	      		url += ':' + port;
	      	}
	     	url += '/' + contextRoot + '/';
		   }else{
		    	url = 'http://localhost/' + contextRoot + '/';
		   }
	    	var amfsecurereverse:SecureAMFChannel 	= new SecureAMFChannel('amf-secure-reverse-proxy', url + 'messagebroker/amfsecurereverse');
	    	//var amfsecure:SecureAMFChannel 			= new SecureAMFChannel('amf-secure', url + 'messagebroker/amfsecure');
	    	//var amf:AMFChannel 						= new AMFChannel('amf', url + 'messagebroker/amf');
	    	var chanel:ChannelSet 					= new ChannelSet(); 
	    	chanel.addChannel(amfsecurereverse);
	    	//chanel.addChannel(amfsecure);
	    	//chanel.addChannel(amf);
		    return chanel;
		}
		 
		protected function getRemote():RemoteObject
		{
			if(destination==null || destination.length==0)
			{
				throw new Error("Destination non può essere vuota");
			}
			var remote:RemoteObject = new RemoteObject(destination);
			remote.channelSet		= initChannelSetBlazeDS("ope_fse");
			addListener( remote ); 
			return remote;
		} 
		protected function callInternalFault(msg:String,target:IEventDispatcher = null):void
		{
			var ev:FaultEvent = new FaultEvent(FaultEvent.FAULT,false,false,new Fault(msg,msg,msg));
			if(target!=null)
			{
				target.dispatchEvent( ev );
			}else
			{
				onFault( ev );
			}
		}
	}
}