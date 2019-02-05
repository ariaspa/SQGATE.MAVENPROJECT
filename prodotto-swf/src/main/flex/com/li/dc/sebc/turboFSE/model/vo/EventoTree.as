package com.li.dc.sebc.turboFSE.model.vo
{
	import it.lispa.siss.sebc.middleground.entity.Evento;
	
	import mx.collections.ArrayCollection;
	
	[Bindable]
	[RemoteClass(alias="com.li.dc.sebc.sviluppoOpeFse.voFlex.EventoTree")]
	public class EventoTree extends Evento
	{
		public var isRoot:Boolean = true;
		public var tooltip:String;
		public var label:String;
		//Collection di oggetti di tipo Event
		public var children:ArrayCollection /*EventoTree*/;
		
	}
}