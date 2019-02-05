package com.li.dc.sebc.turboFSE.model.dataProxy
{
	import com.li.dc.sebc.turboFSE.model.vo.Tree;
	
	import it.lispa.siss.sebc.flex.mvc.model.proxy.DataProxy;
	import it.lispa.siss.sebc.middleground.entity.Cittadino;
	 
	public class DataTree extends DataProxy
	{
		public function DataTree()
		{
			super();
		}
		override protected function controlType(value:Object):Boolean
		{
			return value is Tree || value == null;
		}
		override protected function controlValue(value:Object):Object
		{
			return value;
		}
	}
	
}