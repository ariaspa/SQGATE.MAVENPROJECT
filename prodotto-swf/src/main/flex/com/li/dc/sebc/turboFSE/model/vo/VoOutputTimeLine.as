package com.li.dc.sebc.turboFSE.model.vo
{
	import it.lispa.siss.sebc.middleground.entity.Cittadino;
	
	import mx.collections.ArrayCollection;
	[Bindable]
	[RemoteClass(alias="com.li.dc.sebc.sviluppoOpeFse.voFlex.VoOutputTimeLine")]
	public class VoOutputTimeLine
	{
		public var cittadino:Cittadino;
		// List<DataTimeLine>
		public var timeLine:ArrayCollection;
		// List<Risposta>
	 	public var risposte:ArrayCollection;
	}
}