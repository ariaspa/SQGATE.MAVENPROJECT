package com.li.dc.sebc.turboFSE.model.vo
{
	import it.lispa.siss.sebc.middleground.entity.Cittadino;
	import mx.collections.ArrayCollection;
	
	[Bindable]
	[RemoteClass(alias="com.li.dc.sebc.sviluppoOpeFse.voFlex.TreeEventi")]
	public class TreeEventi
	{
		public var cittadino:Cittadino;
		public var listaEventi:ArrayCollection  /*EventoTree*/;
		public function TreeEventi()
		{
		}

	}
}