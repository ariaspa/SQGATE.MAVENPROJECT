package com.li.dc.sebc.turboFSE.model.dataProxy
{
	import com.li.dc.sebc.turboFSE.view.nodeView.AreaLavoro;
	
	import it.lispa.siss.sebc.flex.mvc.model.proxy.StringProxy;

	public class StateAreaLavoro extends StringProxy
	{
		public function StateAreaLavoro()
		{
			super(AreaLavoro.WAIT);
		}
		override protected function controlValue(value:Object):Object
		{
			switch(value as String)
			{
				 case AreaLavoro.ACTIVE:
				 case AreaLavoro.WAIT:
				return value;
			} 
			return getData();
		}
	}
}