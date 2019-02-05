package com.li.dc.sebc.turboFSE.controller.commands
{
	import com.li.dc.sebc.turboFSE.business.FactoryService;
	import com.li.dc.sebc.turboFSE.controller.commands.serviceCommand.ControlWait;
	import com.li.dc.sebc.turboFSE.fseTurbo;
	import com.li.dc.sebc.turboFSE.util.window.operation.SalvaIncartellaOperation;
	
	import it.lispa.siss.sebc.flex.messages.MessageManager;
	import it.lispa.siss.sebc.middleground.entity.Documento;
	import it.lispa.siss.sebc.middleground.entity.SetDocumentale;
	use namespace fseTurbo
	public class OttieniDocumentoCommand extends ControlWait
	{
		private var reference:SalvaIncartellaOperation;
		public function OttieniDocumentoCommand()
		{
			super();
		}
		override protected function executeCommand(data:Object=null):void
		{
			if(data !=null)
			{
				this.reference 				= data.reference;
				var docVisualizzato:uint	= data.docVisualizzato;
				var dce:SetDocumentale		= data.currDocEntry;
				var doc:Documento			= data.currDocument;
				var base64:String			= data.base64;
				var note:String				= data.note;
				FactoryService.getInstance().getOttieniDocumento(this,docVisualizzato,dce,doc,base64,note).execute();
			}
		}
		override protected function executeFault(info:Object):void
		{
			reference.callBackOttieniDoc( "Errore nel salvataggio del documento" );
			MessageManager.getInstance().addMessage( info );
		}
		override protected function executeResult(info:Object):void
		{
			reference.callBackOttieniDoc( "Salvataggio in cartella eseguito con successo" );
		}
	}
}