package com.li.dc.sebc.turboFSE.model.dataProxy
{
	import com.li.dc.sebc.turboFSE.model.vo.Configuration;
	
	import it.lispa.siss.sebc.flex.mvc.model.proxy.DataProxy;

	public class DataConfiguration extends DataProxy
	{
		public function DataConfiguration()
		{
			super();
		}
		override protected function controlType(value:Object):Boolean
		{
			return value is Configuration;
		}
		override protected function controlValue(value:Object):Object
		{
			updateData( value as Configuration );
			return value;
		}
		private function updateData(configuration:Configuration):void
		{
			
		}
	}
}