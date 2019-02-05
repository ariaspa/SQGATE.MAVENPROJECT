package com.li.dc.sebc.turboFSE.model.dataProxy
{
	import com.li.dc.sebc.turboFSE.view.component.Logo3DMXML;
	
	import it.lispa.siss.sebc.flex.mvc.model.proxy.StringProxy;

	public class StateLogo extends StringProxy
	{
		public function StateLogo()
		{
			super(Logo3DMXML.QUIET);
		}
		override protected function controlValue(value:Object):Object
		{
			switch(value as String)
			{
				case Logo3DMXML.QUIET:
				case Logo3DMXML.ACTIVITY:
				return value;
			} 
			return getData();
		}
	}
}