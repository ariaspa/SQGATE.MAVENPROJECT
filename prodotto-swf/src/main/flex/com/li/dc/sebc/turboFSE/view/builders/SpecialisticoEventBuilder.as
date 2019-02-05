package com.li.dc.sebc.turboFSE.view.builders
{
	import com.li.dc.sebc.turboFSE.view.viste.Vista;
	import com.li.dc.sebc.turboFSE.view.viste.headVista.HeadSpecialistico;
	
	public class SpecialisticoEventBuilder extends SpecialisticoFolderBuilder
	{
		public function SpecialisticoEventBuilder()
		{
			super();
		}
		override protected function getVista():Vista
		{
			return new HeadSpecialistico();
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