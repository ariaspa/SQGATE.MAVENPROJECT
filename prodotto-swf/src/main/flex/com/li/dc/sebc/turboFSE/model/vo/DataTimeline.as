package com.li.dc.sebc.turboFSE.model.vo
{
	import mx.collections.ArrayCollection;
	
	[Bindable]
	[RemoteClass(alias="com.li.dc.sebc.sviluppoOpeFse.voFlex.DataTimeline")]
	public class DataTimeline
	{
		public var dateStart:String;
		public var dateEnd:String;
		public var data:Object;
		public var nameData:String;
		public var tooltip:String;
		 
		public var children:ArrayCollection;
		public var id:String;
		public var type:String;
		public var father:String;
	}
}