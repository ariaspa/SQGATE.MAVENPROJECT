package com.li.dc.sebc.turboFSE.model.dataProxy
{
	import com.li.dc.sebc.turboFSE.model.vo.FolderTree;
	
	import it.lispa.siss.sebc.flex.mvc.model.proxy.DataProxy;

	public class DataFolderSelect extends DataProxy
	{
		public function DataFolderSelect()
		{
			super();
		}
		/*override protected function controlType(value:Object):Boolean
		{
			return value == null || value is FolderTree;
		}
		override protected function controlValue(value:Object):Object
		{
			return value;
		}*/
	}
}