package com.li.dc.sebc.turboFSE.business.xmlService
{
	import com.li.dc.sebc.turboFSE.business.TurboService;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import it.lispa.siss.sebc.flex.debug.Debug;
	
	import mx.rpc.Fault;
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;

	public class LoadXmlService extends TurboService
	{
		public var url:String;
		public function LoadXmlService(responder:IResponder = null, url:String = null)
		{
			super(responder);
			this.url = url;
		}
		override public function execute():void
		{
			Debug.logDebug( "LoadXmlService.execute " );
			loadXml();
		}
		private function loadXml():void
		{
			var contentXMLURL:URLRequest 		= new URLRequest( url );
			var contentXMLLoader:URLLoader 		= new URLLoader();
			addListener( contentXMLLoader );
			contentXMLLoader.load( contentXMLURL );
		}
		private function addListener(contentXMLLoader:URLLoader):void
		{
			contentXMLLoader.addEventListener(Event.COMPLETE, xmlLoaded);
			contentXMLLoader.addEventListener(IOErrorEvent.IO_ERROR,onIoError);
			contentXMLLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,onSecurityError);
		}
		private function removeListener(contentXMLLoader:URLLoader):void
		{
			contentXMLLoader.removeEventListener(Event.COMPLETE, xmlLoaded);
			contentXMLLoader.removeEventListener(IOErrorEvent.IO_ERROR,onIoError);
			contentXMLLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,onSecurityError);
		} 
		private function onSecurityError(e:SecurityErrorEvent):void
		{
			var target:URLLoader = e.target as URLLoader;
			removeListener( target ); 
			responder.fault( getFaultFromSecurity( e ) );
		}
		private function onIoError(e:IOErrorEvent):void
		{
			var target:URLLoader = e.target as URLLoader;
			removeListener( target ); 
			responder.fault( getFaultFromIOError( e ) );
		}
		private function xmlLoaded(e:Event):void
		{
			var target:URLLoader = e.target as URLLoader;
			removeListener( target ); 
			responder.result( getResult( e ) );
		}	
		private function getResult(e:Event):ResultEvent
		{
			var loader:URLLoader = e.target as URLLoader;
			var resultObject:Object = new XML( loader.data );
			return new ResultEvent(ResultEvent.RESULT,false,false,resultObject,null,null);
		}
		private function getFaultFromSecurity(e:SecurityErrorEvent):FaultEvent
		{
			//var loader:URLLoader 	= e.target as URLLoader;
		    // faultCode A simple code describing the fault.
		    // faultString Text description of the fault.
		    // faultDetail Additional details describing the fault.
		    var faultCode:String	= "SecurityError";
		    var faultString:String	= e.text;
		    var faultDetail:String	= "url : " + url;
		    var fault:Fault			= new Fault(faultCode,faultString,faultDetail);
			return new FaultEvent(FaultEvent.FAULT,false,false,fault,null,null);
		}
		private function getFaultFromIOError(e:IOErrorEvent):FaultEvent
		{
			//var loader:URLLoader 	= e.target as URLLoader;
			var faultCode:String	= "IOError";
		    var faultString:String	= e.text;
		    var faultDetail:String	= "url : " + url;
		    var fault:Fault			= new Fault(faultCode,faultString,faultDetail);
			return new FaultEvent(FaultEvent.FAULT,false,false,fault,null,null);
		}
	}
}