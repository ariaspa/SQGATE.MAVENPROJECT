package com.li.dc.sebc.turboFSE.view.builders
{
	import com.li.dc.sebc.turboFSE.model.vo.DataFarmaceutico;
	import com.li.dc.sebc.turboFSE.util.ArrayCollectionIterator;
	import com.li.dc.sebc.turboFSE.util.UtilDate;
	import com.li.dc.sebc.turboFSE.view.viste.headVista.HeadFarmaceutico;
	
	import it.lispa.siss.sebc.middleground.entity.AttributiFolderFarmaceutico;
	import it.lispa.siss.sebc.middleground.entity.DatoCodificato;
	import it.lispa.siss.sebc.middleground.entity.Farmaco;
	
	import mx.collections.ArrayCollection;
	
	public class FarmaceuticoFolderBuilder extends OpenableBuilder
	{
		public function FarmaceuticoFolderBuilder()
		{
			super();
		}
		override protected function getHeadVistaClass():Class
		{
			return HeadFarmaceutico;
		}
		override protected function getDataHeader( data:Object ):Object
		{
			var dt:Object = super.getDataHeader( data );
			if(dt is AttributiFolderFarmaceutico)
			{
				var farm:AttributiFolderFarmaceutico =  dt as AttributiFolderFarmaceutico;
				var result:DataFarmaceutico = new DataFarmaceutico();
				result.labErogazione		= UtilDate.getStringDataAndOra( farm.dataErogazione );
				result.dataProviderGrid		= getListDataProvider(farm.elencoFarmaciErogati);
				result.rowCountDataGrid		= (farm.elencoFarmaciErogati!=null && farm.elencoFarmaciErogati.length<=5) ? farm.elencoFarmaciErogati.length : 5; 
				return result;
			}
			return null;	
		}
		/*<mx:DataGridColumn headerText="Denominazione Commerciale" dataField="denominazioneCommercialeFarmaco" />
			<mx:DataGridColumn headerText="Principio Attivo" dataField="descPrincipioAttivoFarmaco"/> 
			<mx:DataGridColumn headerText="Classe Terapeutica" dataField="descClasseTerapeuticaFarmaco"/> 
			<mx:DataGridColumn headerText="Quantità" dataField="quantitaConfezioni"/> 
			<mx:DataGridColumn headerText="Unità misura" dataField="unitaMisura"/>*/ 
		private function getListDataProvider(elencoFarmaciErogati:ArrayCollection):ArrayCollection
		{
			var iter:ArrayCollectionIterator = new ArrayCollectionIterator(elencoFarmaciErogati);
			var result:ArrayCollection		 = new ArrayCollection();	
			while(iter.hasNext())
			{
				var farmaco:Farmaco = iter.next()  as Farmaco;
				var o:Object	={denominazioneCommercialeFarmaco:createLabel(farmaco.denominazioneCommerciale),
								descPrincipioAttivoFarmaco:createLabel(farmaco.principioAttivo),
								descClasseTerapeuticaFarmaco:createLabel(farmaco.classeTerapeutica),
								quantitaConfezioni:farmaco.quantitaConfezioni,
								 unitaMisura:farmaco.unitaMisura};
				result.addItem( o );
			}
			return result;
		}
		private function createLabel(dt:DatoCodificato):String
		{
			var id:String 	= extrCod(dt);
			var desc:String = extrDesc(dt);
			var res:String	= (id.length>0) ? desc + " ("+id+")" : desc;
			return res;
		}
		private function extrCod(dt:DatoCodificato):String
		{
			if(dt!=null)
			{
				if(dt.codice!=null && dt.codice.length>0)
				{
					return dt.codice;
				}
			}
			return "";
		}
		private function extrDesc(dt:DatoCodificato):String
		{
			if(dt!=null)
			{
				if(dt.descrizione!=null && dt.descrizione.length>0)
				{
					return dt.descrizione;
				}
			}
			return "";
		}
	}
}