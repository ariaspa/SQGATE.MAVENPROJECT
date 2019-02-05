package it.lisit.siss.flex.communication.impl.soap
{
	import flash.external.ExternalInterface;
	
	import it.lisit.siss.flex.utility.debug.Debug;
	 /**
	 * APPLET rappresenta un Communicator in grado di comunicare
	 * attraverso l'applet. E' di fatto un Bridge verso function JS
	 * le quali a loro volta comunicano con l'applet.
	 * Questo Communicator utilizza le function JS scritte Da Luca Sartori
	 * Trascrizione della classe AppletServiceCOM di Luca Sartori
	 * Internet Explorer ActiveX, Firefox, Mozilla 1.7.5 and greater, or other browsers that support NPRuntime are required.
	 * Non ha bisogno di parametri  
	 * @author Marco Salonia  
	 */	
	public class AppletCommunicator extends Communicator
	{
		private static const classname:String 								= "AppletCommunicator ";
		private static const JS_METHOD_SEND_SOAP_TO_APPLET:String 			= "sendSoapToAppletAsync_bridge";
		private static const JS_METHOD_SEND_SOAP_TO_APPLET_CALLBACK:String 	= "sendSoapToAppletAsync_bridge_callback";
		private static const ERROR_MESSAGE:String 							= "ExternalInterface is not available in this container. Internet Explorer ActiveX, Firefox, Mozilla 1.7.5 and greater, or other browsers that support NPRuntime are required.";
 		///////////////////////////////////////////////////////////////////////////////////////
		public function AppletCommunicator()
		{
			super();
			if (!ExternalInterface.available)
			{
			    throw new Error(classname + " : "+ERROR_MESSAGE);
			}
		}
		override protected function protectedExecute(input:XML):void
		{
		 	ExternalInterface.addCallback(JS_METHOD_SEND_SOAP_TO_APPLET_CALLBACK, sendSoapToAppletAsync_bridge_callback);
			ExternalInterface.call(JS_METHOD_SEND_SOAP_TO_APPLET,input.toXMLString());
		}
		/**
     	 * @private
     	 * Metodo di callback dall'applet a Flex
     	 * @param output la stringa di risposta inviata dall'applet.
     	 * Verosimilmente sarà una striga in forma di xml
     	 */
		private function sendSoapToAppletAsync_bridge_callback(output:String) :void
		{
			try{
				var xml:XML = new XML(output);
				responder.result( xml );
			}catch(e:Error)
			{
				Debug.logInfo("sendSoapToAppletAsync_bridge_callback ERROR ::: "+e.getStackTrace() );
			}
			//var rs:ResultEvent = new ResultEvent(ResultEvent.RESULT,true,true,output,null,null); 		
			//dispatchEvent(rs);	
		} 
	}
}