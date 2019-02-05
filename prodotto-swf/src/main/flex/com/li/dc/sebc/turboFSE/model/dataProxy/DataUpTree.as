package com.li.dc.sebc.turboFSE.model.dataProxy
{
	import it.lispa.siss.sebc.flex.mvc.model.proxy.DataProxy;
	
	import mx.collections.ArrayCollection;
	 
	public class DataUpTree extends DataProxy
	{
		public function DataUpTree()
		{
			super();
		}
		override protected function controlType(value:Object):Boolean
		{
			return (value is ArrayCollection);
		}
	}
}