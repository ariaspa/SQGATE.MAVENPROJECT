package com.li.dc.sebc.turboFSE.model.vo
{
	import it.lispa.siss.sebc.flex.collection.ArrayIterator;
	import it.lispa.siss.sebc.flex.collection.IIterator;
	import it.lispa.siss.sebc.middleground.entity.DatoCodificato;
	import it.lispa.siss.sebc.middleground.entity.Folder;
	
	import mx.collections.ArrayCollection;
	[Bindable]
	[RemoteClass(alias="com.li.dc.sebc.sviluppoOpeFse.voFlex.FolderTree")]
	public class FolderTree extends Folder
	{
		public var complete:Boolean;
		public var visible:Boolean;
		public var label:String;
		public var tooltip:String;
		public var children:ArrayCollection;
		/* array di DataAgregazione */		
		public var listDataAgregazione:Array;
		
		public function FolderTree() {
			super();
			children 	= new ArrayCollection();
			visible		= true;
			complete	= false;
		}
	}
}














