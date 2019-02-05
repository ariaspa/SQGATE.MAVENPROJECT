package com.li.dc.sebc.turboFSE.model.dataProxy
{
	import it.lispa.siss.sebc.flex.mvc.model.proxy.ArrayProxy;

	public class DataPDTOpen extends ArrayProxy
	{
		public function DataPDTOpen(data:Array=null)
		{
			super(data);
		}
		override protected function controlType(value:Object):Boolean
		{
			return (value is Array);
		}
	}
}