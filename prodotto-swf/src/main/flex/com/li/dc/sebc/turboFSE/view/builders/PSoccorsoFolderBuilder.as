package com.li.dc.sebc.turboFSE.view.builders
{
	import com.li.dc.sebc.turboFSE.util.UtilDate;
	import com.li.dc.sebc.turboFSE.view.viste.headVista.HeadPSoccorso;
	
	import it.lispa.siss.sebc.middleground.entity.AttributiFolderProntoSoccorso;
	import it.lispa.siss.sebc.middleground.entity.DatoCodificato;
	import it.lispa.siss.sebc.middleground.entity.DimissioneProntoSoccorso;
	import it.lispa.siss.sebc.middleground.entity.ProntoSoccorso;
	
	import mx.collections.ArrayCollection;
	
	public class PSoccorsoFolderBuilder extends OpenableBuilder
	{
		public function PSoccorsoFolderBuilder()
		{
			super();
		}
		override protected function getHeadVistaClass():Class
		{
			return HeadPSoccorso;
		}
		override protected function getDataHeader( data:Object ):Object
		{
			var dt:Object = super.getDataHeader( data );
			////////////////////////////////////////////
			if(dt is AttributiFolderProntoSoccorso)
			{
				var result:Object = new Object();
				var attributi:AttributiFolderProntoSoccorso = dt as AttributiFolderProntoSoccorso;
				if(attributi.datiProntoSoccorso!=null)
				{
					var dataPS:ProntoSoccorso = attributi.datiProntoSoccorso;
					result.valuePratica 		= (dataPS.numeroPraticaPS!=null) ?dataPS.numeroPraticaPS:"";
					result.valueDataIngresso 	= (dataPS.dataOraIngresso !=null && dataPS.dataOraIngresso.length>0) ? UtilDate.getStringDataAndOra( dataPS.dataOraIngresso ) :"";
					var triage:DatoCodificato = (dataPS.datiAccettazione !=null && dataPS.datiAccettazione.classePrioritaTriage != null ) ? dataPS.datiAccettazione.classePrioritaTriage : null;
					if(triage!=null && triage.descrizione!=null && triage.descrizione.length>0)
					{
						result.valuePrioritaTriage	=  triage.descrizione;					
					}
					var modIngresso:DatoCodificato = (dataPS.datiAccettazione!=null && dataPS.datiAccettazione.modalitaIngresso!=null)? dataPS.datiAccettazione.modalitaIngresso : null;
					if(modIngresso!=null && modIngresso.descrizione!=null && modIngresso.descrizione.length>0)
					{
						result.valueModIngresso = modIngresso.descrizione;
					}
					var modTrauma:DatoCodificato = (dataPS.datiAccettazione!=null && dataPS.datiAccettazione.modalitaTrauma) ? dataPS.datiAccettazione.modalitaTrauma:null;
					if(modTrauma!=null && modTrauma.descrizione!=null && modTrauma.descrizione.length>0)
					{
						result.valueModTrauma = modTrauma.descrizione;
					}
						
					var dimissioni:DimissioneProntoSoccorso = (dataPS.datiDimissione!=null  )? dataPS.datiDimissione:null;
					if(dimissioni!=null)
					{
						var dimi:ArrayCollection = ( dimissioni.elencoPrestazioni!=null)?dimissioni.elencoPrestazioni:null;
						if(dimi!=null && dimi.length>0)
						{
							result.rowCountDataGrid = (dimi.length>=5) ? 5 : dimi.length;
							result.dataProviderGrid = dimi; 	 
						}
						result.valueDataOraDimissione 	=  UtilDate.getStringDataAndOra(dimissioni.dataOraDimissione);
						var modDimmi:DatoCodificato = (dimissioni.modalitaDimissione!=null ) ? dimissioni.modalitaDimissione : null;
						if(modDimmi!=null && modDimmi.descrizione!=null && modDimmi.descrizione.length>0)
						{
							result.valueModDimissioni = modDimmi.descrizione;
						}
						var diagno:DatoCodificato = (dimissioni.diagnosiPrincipaleDimissione!=null) ? dimissioni.diagnosiPrincipaleDimissione:null;
						if(diagno!=null)
						{
							var cod:String 		= (diagno.codice!=null && diagno.codice.length>0) ? diagno.codice:"";
							var codCom:String	= (cod!=null && cod.length>0) ? " ( "+cod+" )" : "";
							var descDia:String	= (diagno.descrizione!=null && diagno.descrizione.length>0) ? diagno.descrizione : "";
							result.diagnosiDimissioni 	= descDia+codCom;
						}
						if(dimissioni.prognosi!=null && dimissioni.prognosi.length>0)
						{
							result.prognosi = dimissioni.prognosi;
						}
						if(dimissioni.noteDimissione!=null && dimissioni.noteDimissione.length>0)
						{
							result.noteDimissioni = dimissioni.noteDimissione;
						}
					}
				}
				return result;
			}
			return null;
		}
	}
}