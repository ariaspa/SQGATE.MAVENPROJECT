package com.li.dc.sebc.turboFSE.model.dataProxy
{
	import com.li.dc.sebc.turboFSE.model.vo.TreeEventi;
	
	import it.lispa.siss.sebc.flex.mvc.model.proxy.DataProxy;

	public class DataTreeFlussi extends DataProxy
	{
		public function DataTreeFlussi(data:Object=null)
		{
			super(data);
		}
		override protected function controlType(value:Object):Boolean
		{
			return value is TreeEventi;
		}
	}
}