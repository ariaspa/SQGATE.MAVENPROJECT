package com.li.dc.sebc.turboFSE.business.soapPdlService.util
{
	import it.lisit.siss.flex.communication.AbstractServiceSEB;
	import it.lisit.siss.flex.communication.util.IFactoryUtils;
	import it.lisit.siss.flex.communication.util.service.AbstractVerificaPDCSecurityInfo;
	import it.lisit.siss.flex.communication.util.voVerificaPDC.VoOutputVerificaPDC;
	import it.lispa.siss.sebc.flex.debug.Debug;
	import mx.rpc.IResponder;

	public class LeggiSmartCard extends UtilService
	{
		public function LeggiSmartCard(responder:IResponder=null, factory:IFactoryUtils=null)
		{
			super(responder, factory);
		}
		override protected function getService():AbstractServiceSEB
		{
			return factory.getVerificaPDCSecurityInfo() as AbstractServiceSEB;
		}
		override protected function executeService( ):void
		{
			try{ 
				(this.serviceSEB as AbstractVerificaPDCSecurityInfo).execute();
			}catch(e:Error)
			{
				Debug.logDebug("ContentVisualizerPluginService.executeService Error: " + e.getStackTrace() );
			}
		}
		override protected function getDataResult(esitiPositivi:Array):Object
		{
			Debug.logDebug("ContentVisualizerPluginService.getDataResult esitiPositivi.length : "+esitiPositivi.length);
			if(esitiPositivi!=null && esitiPositivi.length>0 )
			{
				return esitiPositivi[0] as VoOutputVerificaPDC;	 
			}
			return null;
		}	
	}
}