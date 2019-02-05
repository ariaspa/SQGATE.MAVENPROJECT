package com.li.dc.sebc.turboFSE.view.builders
{
	import com.li.dc.sebc.turboFSE.model.vo.FolderTree;
	import com.li.dc.sebc.turboFSE.view.viste.VaccinazioniVista;
	import com.li.dc.sebc.turboFSE.view.viste.Vista;
	
	import it.lispa.siss.sebc.middleground.entity.AttributiFolderVaccinazioni;
	 

	public class VaccinazioniFolderBuilder extends Builder
	{
		public function VaccinazioniFolderBuilder()
		{
			super();
		}
		override protected function transformData(obj:Object):Object
		{
			var folder:FolderTree	= currentData as FolderTree;
			if(folder.attributiSpecificiFolder!=null && folder.attributiSpecificiFolder is AttributiFolderVaccinazioni)
			{
				var attFold:AttributiFolderVaccinazioni = folder.attributiSpecificiFolder as AttributiFolderVaccinazioni;
				if(attFold.elencoPatologie!=null && attFold.elencoPatologie.length>0)
				{
					return  attFold.elencoPatologie;
				}
			}
			return null;
		}
		override protected function getVista():Vista
		{
			return new VaccinazioniVista();
		}
	}
}
 
	

 
