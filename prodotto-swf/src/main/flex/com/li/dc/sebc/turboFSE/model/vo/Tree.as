package com.li.dc.sebc.turboFSE.model.vo
{
	import it.lispa.siss.sebc.middleground.entity.Cittadino;
	
	import mx.collections.ArrayCollection;
	[Bindable]
	[RemoteClass(alias="com.li.dc.sebc.sviluppoOpeFse.voFlex.Tree")]
	public class Tree
	{
		public var cittadino:Cittadino;
		public var listaFolder:ArrayCollection;
	}
}