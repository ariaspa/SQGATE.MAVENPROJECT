package com.li.dc.sebc.turboFSE.model.dataProxy
{
	import com.li.dc.sebc.turboFSE.model.Costanti;
	
	import it.lispa.siss.sebc.flex.mvc.model.proxy.IntegerProxy;

	public class DataAreaTab extends IntegerProxy
	{
		public function DataAreaTab()
		{
			super(-1);
		}
		override protected function controlValue(value:Object):Object
		{
			//sono gli indici possibili per il tab
			if(((value as int)+1)>Costanti.MAX_TAB)
			{
				return getData();
			}
			return value;
		}
	}
}