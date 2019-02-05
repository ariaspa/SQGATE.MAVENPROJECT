package com.li.dc.sebc.turboFSE.view.builders
{
	import com.li.dc.sebc.turboFSE.view.viste.Vista;
	import com.li.dc.sebc.turboFSE.view.viste.headVista.HeadPSoccorso;
	
	public class PSoccorsoEventBuilder extends PSoccorsoFolderBuilder
	{
		public function PSoccorsoEventBuilder()
		{
			super();
		}
		override protected function getVista():Vista
		{
			return new HeadPSoccorso();
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