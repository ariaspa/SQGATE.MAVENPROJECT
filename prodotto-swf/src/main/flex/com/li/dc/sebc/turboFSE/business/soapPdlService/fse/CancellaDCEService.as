package com.li.dc.sebc.turboFSE.business.soapPdlService.fse
{
	import it.lisit.siss.flex.communication.AbstractServiceSEB;
	import it.lisit.siss.flex.communication.fse.IFactoryFSE;
	import it.lisit.siss.flex.communication.fse.service.AbstractCancellaDCEDaFolder;
	import it.lisit.siss.flex.communication.fse.voCancellaDCEDaFolder.VoInputCancellaDCEDaFolder;
	import it.lisit.siss.flex.communication.fse.voCancellaDCEDaFolder.VoOutputCancellaDCEDaFolder;
	import it.lispa.siss.sebc.middleground.entity.AttributiFolderPDT;
	import it.lispa.siss.sebc.middleground.entity.Cittadino;
	import it.lispa.siss.sebc.middleground.entity.ConstAttributiSpecificiFolder;
	import it.lispa.siss.sebc.middleground.entity.Folder;
	import it.lispa.siss.sebc.middleground.entity.SetDocumentale;
	
	import mx.rpc.IResponder;
	
	public class CancellaDCEService extends FSEService
	{
		public var cittadino:Cittadino;
		public var folderDest:Folder;
		public var dce:SetDocumentale;
		
		public function CancellaDCEService(responder:IResponder=null, factory:IFactoryFSE=null)
		{
			super(responder, factory);
		}
		
		override protected function getDataResult(esitiPositivi:Array):Object
		{
			//Restituisco "OK" se la cancellazione è andata a buon fine, altrimenti "KO"
			if (esitiPositivi.length >= 1)
			{
				var pos:VoOutputCancellaDCEDaFolder = esitiPositivi[0] as VoOutputCancellaDCEDaFolder;
				return pos.esitoCancellaDCEDaFolder.toUpperCase();
			}
			// è andato male
			return "KO";
		}
		private function getInput():VoInputCancellaDCEDaFolder
		{
			var input:VoInputCancellaDCEDaFolder = new VoInputCancellaDCEDaFolder();
			if (folderDest.attributiSpecificiFolder != null && folderDest.attributiSpecificiFolder.tipo == ConstAttributiSpecificiFolder.ATTRIBUTI_PDT) {
				input.codicePDT = (folderDest.attributiSpecificiFolder as AttributiFolderPDT).datiPDT.PDT.codice;
			} 
			input.idCittadino 				= cittadino.codiceFiscale;
			input.idFolder 					= (folderDest.folder != null)?folderDest.folder.codice:"";
			input.idTipoFolder 				= folderDest.idTipoFolder;
			input.idSetDocumenti 			= dce.idSetDocumenti;
			return input;
		}
		override protected function getService():AbstractServiceSEB
		{
			return factory.getCancellaDCEDaFolder() as AbstractServiceSEB;
		}	
		override protected function executeService( ):void
		{
			(this.serviceSEB as AbstractCancellaDCEDaFolder).execute( getInput() );
		}
	}
}