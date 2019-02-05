package com.li.dc.sebc.turboFSE.model.dataProxy
{
	import it.lispa.siss.sebc.flex.mvc.model.proxy.BooleanProxy;

	public class DataSmartCardCitt extends BooleanProxy
	{
		public function DataSmartCardCitt(value:Boolean=false)
		{
			super(value);
		}
		override protected function controlValue(value:Object):Object
		{
			var old:Boolean = getData() as Boolean;
			if(value == old)
			{
				return old
			}
			return value;
		}
	}
}