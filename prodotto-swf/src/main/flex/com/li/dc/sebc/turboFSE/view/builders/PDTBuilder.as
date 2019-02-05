package com.li.dc.sebc.turboFSE.view.builders
{
	import com.li.dc.sebc.turboFSE.model.vo.FolderTree;
	import com.li.dc.sebc.turboFSE.view.viste.PDTVista;
	import com.li.dc.sebc.turboFSE.view.viste.Vista;
	
	import it.lispa.siss.sebc.middleground.entity.AttributiFolderPDT;
	import it.lispa.siss.sebc.middleground.entity.PercorsoDiagnosticoTerapeutico;
	
	public class PDTBuilder extends Builder
	{
		public function PDTBuilder()
		{
			super();
		}
		private function extractPDT(folder:FolderTree):PercorsoDiagnosticoTerapeutico
		{
			if(folder.attributiSpecificiFolder!=null && folder.attributiSpecificiFolder.tipo>-1)
			{
				var attributi:AttributiFolderPDT 		= folder.attributiSpecificiFolder as AttributiFolderPDT; 
				return  attributi.datiPDT;
			}
			return null;
		} 
		override protected function transformData(obj:Object):Object
		{
			return extractPDT( obj as FolderTree );
		}
		override protected function getKey():Object
		{
			/* costruisco l'identificativo univoco per questo pdt  */
			var fld:FolderTree 						= currentData as FolderTree;
			var str:String							= null;
			var pdt:PercorsoDiagnosticoTerapeutico	= extractPDT( fld );
			if(pdt!=null)
			{
				str = "";
				if(fld.folder!=null && fld.folder.codice!=null && fld.folder.codice.length>0)
				{
					str += fld.folder.codice;
				}
				if(pdt.dataApertura!=null && pdt.dataApertura.length>0)
				{
					str += pdt.dataApertura;
				}
				if(pdt.dataChiusura!=null && pdt.dataChiusura.length>0)
				{
					str += pdt.dataChiusura;
				}
			}
			return str;
		}
		override protected function getVista():Vista
		{
			return new PDTVista();
		}
	}
}