package com.li.dc.sebc.turboFSE.view.builders
{
	import com.li.dc.sebc.turboFSE.model.vo.WrapData;
	
	public class RicoveroEventBuilderWrap extends RicoveroEventBuilder
	{
		public function RicoveroEventBuilderWrap()
		{
			super();
		}
		override  protected function transformData(obj:Object):Object
		{
			return super.transformData( (obj as WrapData).data );	
		}
	}
}