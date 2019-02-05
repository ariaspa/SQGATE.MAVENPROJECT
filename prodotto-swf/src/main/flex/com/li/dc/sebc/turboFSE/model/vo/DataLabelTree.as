package com.li.dc.sebc.turboFSE.model.vo
{
	import mx.collections.ArrayCollection;
	
	public class DataLabelTree
	{
		public var children:ArrayCollection;
		public var label:String;
		public var toolTip:String;
		public var value:Object;
		public var complete:Boolean	= false;
		public function DataLabelTree(label:String = "",toolTip:String = "",value:Object = null)
		{
			this.label = label;
			this.toolTip = toolTip;
			this.value = value;
		}
	}
}