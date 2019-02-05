package com.li.dc.sebc.turboFSE.view.builders
{
	import com.li.dc.sebc.turboFSE.model.vo.DataPrericovero;
	import com.li.dc.sebc.turboFSE.util.UtilDate;
	import com.li.dc.sebc.turboFSE.view.viste.headVista.HeadPreRicovero;
	
	import it.lispa.siss.sebc.middleground.entity.AttributiFolderPrericovero;
	import it.lispa.siss.sebc.middleground.entity.Prericovero;
	
	public class PrericoveroFolderBuilder extends OpenableBuilder
	{
		public function PrericoveroFolderBuilder()
		{
			super();//HeadPreRicovero.mxml
		}
		override protected function getHeadVistaClass():Class
		{
			return HeadPreRicovero;
		}
		override protected function getDataHeader( data:Object ):Object
		{
			var dt:Object = super.getDataHeader( data );
			if(dt is AttributiFolderPrericovero)
			{
				var pre:AttributiFolderPrericovero = dt as AttributiFolderPrericovero;
				if(pre.datiPrericovero!=null)
				{
					var result:DataPrericovero = new DataPrericovero();
					var dtPre:Prericovero = pre.datiPrericovero;
					var npre:String	= dtPre.numeroPrericovero;
					var rep:String	= "";	
					if(dtPre.repartoRicovero!=null && dtPre.repartoRicovero.descrizione!=null)
					{
						rep = dtPre.repartoRicovero.descrizione;
					}
					result.labNumPrericovero 	= npre; 	
					result.labRepPrericovero 	= rep;
					result.labDataInizio		= UtilDate.getStringDataAndOra( dtPre.dataOraInizioPrericovero );
					result.labDataFine			= UtilDate.getStringDataAndOra( dtPre.dataOraFinePrericovero );
					var diagn:String 			= "";
					var codDiagn:String			= "";
					if(dtPre.diagnosi!=null)
					{
						if(dtPre.diagnosi.descrizioneDiagnosi!=null)
						{
							diagn = dtPre.diagnosi.descrizioneDiagnosi;
						}
						if(dtPre.diagnosi.idDiagnosi!=null)
						{
							codDiagn = dtPre.diagnosi.idDiagnosi;
						}
						codDiagn	= (codDiagn!=null && codDiagn.length>0) ? "("+codDiagn+")": "" ;
						result.labDiagnosi	= 	(diagn==null || diagn.length==0) ? "" : diagn + " "+codDiagn;	
					}
					return result; 
				}
			}	
			return null;
		}
	}
}