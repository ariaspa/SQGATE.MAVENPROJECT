package it.lisit.siss.flex.communication.impl.soap.fse
{
	import it.lisit.siss.flex.communication.fse.voCancellaDCEDaFolder.VoOutputCancellaDCEDaFolder;
	
	internal class ParserCancellaDCEDaFolder
	{
		private var _body:XML
		public function ParserCancellaDCEDaFolder(body:XML)
		{
			_body = body;
		}
		public function execute():VoOutputCancellaDCEDaFolder
		{
			return new VoOutputCancellaDCEDaFolderImpl(_body);
		}
	}
}
	import it.lisit.siss.flex.communication.fse.voCancellaDCEDaFolder.VoOutputCancellaDCEDaFolder;
	
class VoOutputCancellaDCEDaFolderImpl extends VoOutputCancellaDCEDaFolder
{
	public function VoOutputCancellaDCEDaFolderImpl(body:XML)
	{
		super();
		var esit:XMLList = body.child( "esitoCancellaDCEDaFolder" );
		if(esit!=null && esit.length()>0)
		{
			this.esitoCancellaDCEDaFolder = esit[0].child( "esito" );
		}
	}
}