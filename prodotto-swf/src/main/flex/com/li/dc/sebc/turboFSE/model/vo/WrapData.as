package com.li.dc.sebc.turboFSE.model.vo
{
	import com.li.dc.sebc.turboFSE.view.viste.Vista;
	
	public class WrapData
	{
		public var vista:Vista
		private var _data:Object;
		public function get data():Object { return _data;}
		public function WrapData(origData:Object)
		{
			_data = origData;
		}
	}
}