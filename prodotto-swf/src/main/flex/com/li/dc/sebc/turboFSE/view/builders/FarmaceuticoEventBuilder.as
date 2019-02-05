package com.li.dc.sebc.turboFSE.view.builders
{
	import com.li.dc.sebc.turboFSE.view.viste.Vista;
	import com.li.dc.sebc.turboFSE.view.viste.headVista.HeadFarmaceutico;
	
	public class FarmaceuticoEventBuilder extends FarmaceuticoFolderBuilder
	{
		public function FarmaceuticoEventBuilder()
		{
			super();
		}
		override protected function getVista():Vista
		{
			return new HeadFarmaceutico();
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