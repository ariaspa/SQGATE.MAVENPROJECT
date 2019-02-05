package com.li.dc.sebc.turboFSE.model.dataProxy
{
	import com.li.dc.sebc.turboFSE.view.nodeView.Root;
	
	import it.lispa.siss.sebc.flex.mvc.model.proxy.StringProxy;
	/**
	 * Controllo sugli stati possibili del component Root
	 * @author Marco Salonia
	 * 
	 */	
	public class StateStack extends StringProxy
	{
		public function StateStack()
		{
			super(Root.STATE_STACK_ATTESA);
		}
		override protected function controlValue(value:Object):Object
		{
			switch(value as String)
			{
				case Root.STATE_STACK_ATTESA:
				case Root.STATE_STACK_VISUALIZZA:
				return value;
			} 
			return getData();
		}
	}
}