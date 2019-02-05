package com.li.dc.sebc.turboFSE.business.soapPdlService.util
{
	import it.lisit.siss.flex.communication.AbstractServiceSEB;
	import it.lisit.siss.flex.communication.crm.voTestoReferto.VoOutputTestoreferto;
	import it.lisit.siss.flex.communication.util.IFactoryUtils;
	import it.lisit.siss.flex.communication.util.service.AbstractCreaStrutturato;
	import it.lisit.siss.flex.communication.util.voCreaStrutturato.VoInputCreaStrutturato;
	import it.lisit.siss.flex.communication.util.voCreaStrutturato.VoOutputCreaStrutturato;
	import it.lispa.siss.sebc.flex.debug.Debug;
	
	import mx.rpc.IResponder;

	public class ContentVisualizerPluginService extends UtilService
	{
		public var data:Object;
		
		public function ContentVisualizerPluginService(responder:IResponder=null, factory:IFactoryUtils=null)
		{
			super(responder, factory);
			Debug.logDebug("ContentVisualizerPluginService instance");
		}
		override protected function getService():AbstractServiceSEB
		{
			var serv:AbstractServiceSEB = factory.getContentVisualizerPlugin() as AbstractServiceSEB;
			Debug.logDebug("ContentVisualizerPluginService getService "+serv);
			return serv;
		}	
		override protected function executeService( ):void
		{
			try{
				// {uri:uri,output:output};
				Debug.logDebug("ContentVisualizerPluginService.executeService");
				var testoReferto:String 		= (data as VoOutputTestoreferto).testoReferto;
				var descTipoTestoReferto:String = (data as VoOutputTestoreferto).descTipoTestoReferto;
				(this.serviceSEB as AbstractCreaStrutturato).execute( getInput( descTipoTestoReferto, testoReferto ) );
			}catch(e:Error)
			{
				Debug.logDebug("ContentVisualizerPluginService.executeService Error: "+e.getStackTrace() );
			}
		}
			
		override protected function getDataResult(esitiPositivi:Array):Object
		{
			Debug.logDebug("ContentVisualizerPluginService.getDataResult esitiPositivi.length : "+esitiPositivi.length);
			if(esitiPositivi!=null && esitiPositivi.length>0 )
			{
				return esitiPositivi[0] as VoOutputCreaStrutturato;	 
			}
			return null;
		}
		
		private function getInput(refTipoDoc:String,testoReferto:String):VoInputCreaStrutturato 
		{
			var tipoDoc:String	= refTipoDoc.toLowerCase();
			var input:VoInputCreaStrutturato = new VoInputCreaStrutturato(); 
			input.name = "localFile";
			if (tipoDoc == "pdf"){
				input.contentType = "fse_pdf";
			}else if (tipoDoc == "zip"){
				input.contentType = "fse_zip";
			}else{
				input.contentType = tipoDoc;
			}
			input.content = testoReferto;
			Debug.logDebug("ContentVisualizerPluginService.getInput  contentType : "+input.contentType+", name : "+input.name+", content.length :: "+input.content.length);
			return input;
		}
	}
}