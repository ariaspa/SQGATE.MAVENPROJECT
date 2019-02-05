package com.li.dc.sebc.turboFSE.model.dataProxy
{
	import it.lispa.siss.sebc.flex.mvc.model.proxy.DataProxy;
	import it.lispa.siss.sebc.middleground.entity.Cittadino;

	public class DataCittadino extends DataProxy
	{
		private var cittadino:Cittadino;
		public function DataCittadino()
		{
			super(null);
		}
		override protected function controlType(value:Object):Boolean
		{
			return (value == null) || (value is Cittadino);
		}
		override protected function controlValue(value:Object):Object
		{
			/*var old:Cittadino = getData() as Cittadino;
			if(old!=null)
			{
				var cf:String = old.codiceFiscale;
				if((value as Cittadino).codiceFiscale == cf)
				{
					return old;
				}	
			}*/
			return value;
		}
	}
}