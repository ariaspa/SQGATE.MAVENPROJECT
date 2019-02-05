package com.li.dc.sebc.turboFSE.view.builders
{
	import com.li.dc.sebc.turboFSE.model.vo.WrapData;
	
	public class FarmaceuticoEventBuilderWrap extends FarmaceuticoEventBuilder
	{
		public function FarmaceuticoEventBuilderWrap()
		{
			super();
		}
		override protected function transformData(obj:Object):Object
		{
			return super.transformData( (obj as WrapData).data );	
		}
	}
}