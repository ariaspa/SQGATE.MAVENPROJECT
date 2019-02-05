package com.li.dc.sebc.turboFSE.view.builders
{
	import com.li.dc.sebc.turboFSE.view.viste.Vista;
	import com.li.dc.sebc.turboFSE.view.viste.headVista.HeadRicovero;
	
	public class RicoveroEventBuilder extends RicoveroFolderBuilder
	{
		public function RicoveroEventBuilder()
		{
			super();
		}
		override protected function getVista():Vista
		{
			return new HeadRicovero();
		}
		override protected function transformData(obj:Object):Object
		{	
			return  getDataHeader( obj );
		}
		override protected function createMediator( v:Vista ):void
		{
			
		}
	}
}