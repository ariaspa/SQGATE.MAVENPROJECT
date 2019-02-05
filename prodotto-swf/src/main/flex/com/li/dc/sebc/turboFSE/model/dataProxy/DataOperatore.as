package com.li.dc.sebc.turboFSE.model.dataProxy
{
	import it.lispa.siss.sebc.flex.mvc.model.proxy.DataProxy;
	import it.lispa.siss.sebc.middleground.entity.Operatore;

	public class DataOperatore extends DataProxy
	{
		public function DataOperatore()
		{
			super(null);
		}
		override protected function controlType(value:Object):Boolean
		{
			return (value == null) || (value is Operatore);
		}
		override protected function controlValue(value:Object):Object
		{
			return value;
		}
		 
	}
}