package com.li.dc.sebc.turboFSE.model.vo
{
	import it.lispa.siss.sebc.middleground.entity.response.Risposta;
	
	[Bindable]
	[RemoteClass(alias="com.li.dc.sebc.sviluppoOpeFse.voFlex.ContentFolder")]
	public class ContentFolder extends Risposta
	{
		public var folder:FolderTree;
		
		public function ContentFolder() {
			folder = new FolderTree();
		}
	}
}