package com.li.dc.sebc.turboFSE.business.soapPdlService.fse
{
	import it.lisit.siss.flex.communication.AbstractServiceSEB;
	import it.lisit.siss.flex.communication.fse.IFactoryFSE;
	import it.lisit.siss.flex.communication.fse.service.AbstractCopiaDCEInPDT;
	import it.lisit.siss.flex.communication.fse.voCopiaDCEInPDT.VoInputCopiaDCEInPDT;
	import it.lisit.siss.flex.communication.fse.voCopiaDCEInPDT.VoOutputCopiaDCEInPDT;
	import it.lispa.siss.sebc.middleground.entity.AttributiFolderPDT;
	import it.lispa.siss.sebc.middleground.entity.Cittadino;
	import it.lispa.siss.sebc.middleground.entity.ConstAttributiSpecificiFolder;
	import it.lispa.siss.sebc.middleground.entity.Folder;
	import it.lispa.siss.sebc.middleground.entity.SetDocumentale;
	
	import mx.rpc.IResponder;
	
	public class CopiaDCEService extends FSEService
	{
		public var cittadino:Cittadino;
		public var folderDest:Folder;
		public var dce:SetDocumentale;
		
		public function CopiaDCEService(responder:IResponder=null, factory:IFactoryFSE=null)
		{
			super(responder, factory);
		}
		
		override protected function getDataResult(esitiPositivi:Array):Object
		{
			//Restituisco "OK" se la copia è andata a buon fine, altrimenti "KO"
			if (esitiPositivi.length >= 1)
			{
				var pos:VoOutputCopiaDCEInPDT = esitiPositivi[0] as VoOutputCopiaDCEInPDT;
				return pos.esitoCopiaDCEInFolder.toUpperCase();
			}
			// è andato male
			return "KO";
		}
		private function getInput():VoInputCopiaDCEInPDT
		{
			var input:VoInputCopiaDCEInPDT = new VoInputCopiaDCEInPDT();
			if (folderDest.attributiSpecificiFolder != null && folderDest.attributiSpecificiFolder.tipo == ConstAttributiSpecificiFolder.ATTRIBUTI_PDT) {
				input.codicePDT = (folderDest.attributiSpecificiFolder as AttributiFolderPDT).datiPDT.PDT.codice;
			} 
			input.cognomeCittadino 			= cittadino.cognome;
			input.dataNascitaCittadino 		= cittadino.dataNascita;
			input.idCittadino 				= cittadino.codiceFiscale;
			input.idComuneNascitaCittadino 	= (cittadino.localitaNascita != null)?cittadino.localitaNascita.codiceIstat:"";
			input.nomeCittadino 			= cittadino.nome;
			input.sessoCittadino 			= cittadino.codiceSesso;
			input.idFolder 					= (folderDest.folder != null)?folderDest.folder.codice:"";
			input.idTipoFolder 				= folderDest.idTipoFolder;
			input.idSetDocumenti 			= dce.idSetDocumenti;
			return input;
		}
		override protected function getService():AbstractServiceSEB
		{
			return factory.getCopiaDCEInPDT() as AbstractServiceSEB;
		}	
		override protected function executeService( ):void
		{
			(this.serviceSEB as AbstractCopiaDCEInPDT).execute( getInput() );
		}
	}
}