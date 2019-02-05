package com.li.dc.sebc.turboFSE.controller.commands.fse
{
	import com.li.dc.sebc.turboFSE.business.FactoryService;
	import com.li.dc.sebc.turboFSE.controller.commands.serviceCommand.ControlWait;
	import com.li.dc.sebc.turboFSE.model.ConstDataProxy;
	import com.li.dc.sebc.turboFSE.model.FSEModel;
	
	import flash.net.FileReference;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.net.navigateToURL;
	import flash.utils.ByteArray;
	
	import it.lisit.siss.flex.communication.fse.voRichiediUrlTestoReferto.VoOutputRichiediUrlTestoReferto;
	import it.lispa.siss.sebc.flex.debug.Debug;
	import it.lispa.siss.sebc.middleground.entity.Cittadino;
	import it.lispa.siss.sebc.middleground.entity.SetDocumentale;
	
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	import mx.utils.Base64Decoder;

	public class RichiediUrlTestoRefertoCommand extends ControlWait
	{
		private var voUrlTestoReferto:VoOutputRichiediUrlTestoReferto;
		private var fileFromServerDecoded:Object;

		public function RichiediUrlTestoRefertoCommand()
		{
			super();
		}

		override protected function executeCommand(data:Object = null):void
		{
			Debug.logDebug("RichiediUrlTestoRefertoCommand executeCommand (data !=null): " + (data !=null) + ", " + data);

			var setDoc: SetDocumentale = data as SetDocumentale;
			FactoryService.getInstance().getRichiediUrlTestoReferto(this, data as SetDocumentale).execute();
		}

		override protected function executeResult(data:Object):void
		{
			var urlServlet:String = "/ope_fse/servlet/proxy_service"; 
			Debug.logDebug("RichiediUrlTestoRefertoCommand executeResult data: " + data);
			if (data != null)
			{
				voUrlTestoReferto = (data as ResultEvent).result as VoOutputRichiediUrlTestoReferto;
				var request:URLRequest = null;
				if (voUrlTestoReferto != null && voUrlTestoReferto.urlTestoReferto) {
					request	= new URLRequest(urlServlet + "?url=" + encodeURIComponent(voUrlTestoReferto.urlTestoReferto));
					navigateToURL(request, "_blank");
				} else {
					/*
					var service : HTTPService = new HTTPService();
					service.url = urlServlet + "?url=BASE64";
					service.method = "POST";
					service.contentType = HTTPService.CONTENT_TYPE_FORM;
					service.resultFormat="text";
					service.addEventListener("result", httpResult); 
					service.addEventListener("fault", httpFault); 
					
					var parameters:Object = new Object();
					parameters["base64Testo"] = voUrlTestoReferto.testoReferto;
					parameters["tipoReferto"] = voUrlTestoReferto.tipoReferto;
					
					service.send(parameters);
					*/
					Alert.okLabel = "SI'";
					Alert.cancelLabel = "NO";
					fileFromServerDecoded = voUrlTestoReferto.testoReferto;
					Alert.show("Si vuole procedere al download del documento?", "Download Documento ", Alert.OK|Alert.CANCEL, null, closeHandler);
				}
				

//				Alert.show("File pronto", "Scarico file", Alert.OK, null, closeHandler);
			}
		}

//		protected function closeHandler( event:CloseEvent ):void
//		{
//
//			if ( event.detail == Alert.OK )
//			{
//				var request:URLRequest = new URLRequest(urlTestoReferto);
//				var fileToDownload:FileReference = new FileReference();
//				fileToDownload.download(request, "referto.pdf");
//
//				//			fileReference = new FileReference();
//				//			fileReference.save("http://www.bogdanmanate.com", "test.txt");
//			}
//		}

		
		public function httpResult(event:ResultEvent):void { 
			fileFromServerDecoded = event.result;
			Alert.show("Il referto e' pronto per il download", "Test", Alert.OK|Alert.CANCEL, null, closeHandler);
			
			//Do something with the result. 
		} 
		
	
		protected function closeHandler( event:CloseEvent ):void
		{			
			if ( event.detail == Alert.OK )
			{
				var myDecoder:Base64Decoder = new Base64Decoder();
				myDecoder.decode(fileFromServerDecoded as String);
				
				var decodedByteArr:ByteArray = myDecoder.toByteArray();
				
				var fileReference:FileReference = new FileReference();
				var b:ByteArray = new ByteArray();
				// Include the byte order mark for UTF-8
				/*b.writeByte(0xEF);
				b.writeByte(0xBB);
				b.writeByte(0xBF);
				b.writeUTFBytes(fileFromServerDecoded as String);
				*/
				fileReference.save(decodedByteArr, "referto" + getEstensioneReferto(voUrlTestoReferto.tipoReferto));
			}
		}
			
		
		public function httpFault(event:FaultEvent):void { 
			var faultstring:String = event.fault.faultString; 
			Alert.show("Errore nel reperimento del referto.\nCausa:" + faultstring); 
		} 
		
		override protected function executeFault(info:Object):void
		{
			Debug.logError("RichiediUrlTestoRefertoCommand executeFault: " + info as String);
		}
		
		protected function getEstensioneReferto(tipoReferto:String):String
		{
			var estensione = "";
			if (tipoReferto == "01") {
				estensione = ".txt";
			}
			if (tipoReferto == "02") {
				estensione = ".pdf";
			}
			if (tipoReferto == "04"){
				estensione = ".jpeg";
			}
			return estensione;
		}
	}
}