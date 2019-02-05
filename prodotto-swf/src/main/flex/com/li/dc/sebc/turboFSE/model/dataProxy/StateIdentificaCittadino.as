package com.li.dc.sebc.turboFSE.model.dataProxy
{
	import com.li.dc.sebc.turboFSE.view.nodeView.IdentificaCittadino;
	
	import it.lispa.siss.sebc.flex.mvc.model.proxy.StringProxy;

	public class StateIdentificaCittadino extends StringProxy
	{
		public function StateIdentificaCittadino( )
		{
			super(IdentificaCittadino.IDENT_SINGOLA);
		}
		override protected function controlValue(value:Object):Object
		{
			switch(value as String)
			{
				case IdentificaCittadino.IDENT_MULTIPLA:
				case IdentificaCittadino.IDENT_SINGOLA:
				return value;
			} 
			return getData();
		}
	}
}