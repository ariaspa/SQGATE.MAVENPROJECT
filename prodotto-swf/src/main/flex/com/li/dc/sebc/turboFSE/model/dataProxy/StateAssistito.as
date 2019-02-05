package com.li.dc.sebc.turboFSE.model.dataProxy
{
	import com.li.dc.sebc.turboFSE.view.nodeView.AssistitoFse;
	
	import it.lispa.siss.sebc.flex.mvc.model.proxy.StringProxy;

	public class StateAssistito extends StringProxy
	{
		public function StateAssistito()
		{
			super(AssistitoFse.IDENTIFICA);
		}
		override protected function controlValue(value:Object):Object
		{
			switch(value as String)
			{
				case AssistitoFse.IDENTIFICA: 
				case AssistitoFse.VISUALIZZA:
				return value;
			} 
			return getData();
		}
	}
}