package com.li.dc.sebc.turboFSE.view.builders
{
	import com.li.dc.sebc.turboFSE.model.vo.DataRicovero;
	import com.li.dc.sebc.turboFSE.util.UtilDate;
	import com.li.dc.sebc.turboFSE.util.Utils;
	import com.li.dc.sebc.turboFSE.view.viste.headVista.HeadRicovero;
	
	import it.lispa.siss.sebc.middleground.entity.AttributiFolderRicovero;
	import it.lispa.siss.sebc.middleground.entity.AttributiSpecificiFolder;
	import it.lispa.siss.sebc.middleground.entity.DatoCodificato;
	import it.lispa.siss.sebc.middleground.entity.Diagnosi;
	import it.lispa.siss.sebc.middleground.entity.Intervento;
	import it.lispa.siss.sebc.middleground.entity.Ricovero;
	import it.lispa.siss.sebc.middleground.entity.Trasferimento;
	
	import mx.collections.ArrayCollection;
	
	public class RicoveroFolderBuilder extends OpenableBuilder
	{
		public function RicoveroFolderBuilder()
		{
			super();
		}
		override protected function getHeadVistaClass():Class
		{
			return HeadRicovero;
		}
		private function getDataProviderDiagnosi(elenco:ArrayCollection):ArrayCollection
		{
			var temp:ArrayCollection	= new ArrayCollection();
			if(elenco!=null && elenco.length>0)
			{
				for(var i:uint = 0;i<elenco.length;i++)
				{
					var diagnosi:Diagnosi	= elenco.getItemAt( i ) as Diagnosi;
					var descrizione:String 	= diagnosi.descrizioneDiagnosi;
					var codice:String 		= diagnosi.idDiagnosi;
					var codExt:String		= (codice!=null && codice.length>0) ? "( "+codice+" )" : "";
					var descExt:String		= (descrizione!=null && descrizione.length>0) ? descrizione +" "+codExt  : "";
					if(descExt.length>0)
					{
						temp.addItem( new DatoCodificato(codice,descExt) );
					}
				}
			}
			return temp;
		}
	 
		private function getDataProviderTrasferimenti(elenco:ArrayCollection):ArrayCollection
		{
			var temp:ArrayCollection	= new ArrayCollection();
			if(elenco!=null && elenco.length>0)
			{
				for(var i:uint = 0;i<elenco.length;i++)
				{
					var trasf:Trasferimento			= elenco.getItemAt( i ) as Trasferimento;
					var nwtrasf:Trasferimento		= new Trasferimento();
					nwtrasf.repartoDestinazione		= trasf.repartoDestinazione;
					nwtrasf.repartoOrigine			= trasf.repartoOrigine;
					nwtrasf.dataTrasferimento		= "";
					if(trasf.dataTrasferimento!=null && trasf.dataTrasferimento.length>0)
					{
						nwtrasf.dataTrasferimento	= UtilDate.getStringDataAndOra( trasf.dataTrasferimento );
					}
					temp.addItem( nwtrasf ); 
				}
			}
			return temp;
		}
		private function getDataProviderInterventi(elenco:ArrayCollection):ArrayCollection
		{
			var temp:ArrayCollection	= new ArrayCollection();
			if(elenco!=null && elenco.length>0)
			{
				for(var i:uint = 0;i<elenco.length;i++)
				{
					var interv:Intervento	= elenco.getItemAt( i ) as Intervento; 
					var descrizione:String 	= interv.descrizioneIntervento;
					var codice:String 		= interv.idIntervento;
					var codExt:String		= (codice!=null && codice.length>0) ? "( "+codice+" )" : "";
					var descExt:String		= (descrizione!=null && descrizione.length>0) ? descrizione +" "+codExt  : "";
					if(descExt.length>0)
					{
						temp.addItem( new DatoCodificato(codice,descExt) );
					}
				}
			}
			return temp;
		}
		
		override protected function getDataHeader( data:Object ):Object
		{
			var attributi:AttributiSpecificiFolder  = super.getDataHeader( data ) as AttributiSpecificiFolder;
			if(attributi is AttributiFolderRicovero && (attributi as AttributiFolderRicovero).datiRicovero != null)
			{
				var ric:Ricovero 					= (attributi as AttributiFolderRicovero).datiRicovero;
				var dataRicovero:DataRicovero 		= new DataRicovero();
				dataRicovero.valueNosologico		= Utils.getStringValue( ric.numeroNosologico );
				dataRicovero.valueDataOraRicovero	= UtilDate.getStringDataAndOra( ric.dataOraRicovero );
				dataRicovero.valueRepartoRicovero	= Utils.getDescrizione( ric.repartoRicovero );
				var dataAcetta:Boolean				= (ric.datiAccettazione != null);
				dataRicovero.valueDiagnosiIngresso	= dataAcetta ? Utils.getDescrAndCod( ric.datiAccettazione.diagnosiIngresso ) : "";
				dataRicovero.valueProvenienza		= dataAcetta ? Utils.getDescrAndCod( ric.datiAccettazione.provenienzaPaziente ) : ""; 
				dataRicovero.valueTipoRicovero		= dataAcetta ? Utils.getDescrAndCod( ric.datiAccettazione.tipoRicovero ) : "";
				dataRicovero.valueOnereDegenza		= dataAcetta ? Utils.getDescrAndCod( ric.datiAccettazione.onereDegenza ) : "";
				dataRicovero.valueRegimeRicovero	= dataAcetta ? Utils.getDescrAndCod( ric.datiAccettazione.regimeRicovero ) : "";
				var dataDimi:Boolean				= (ric.datiDimissione!=null);
				dataRicovero.valueDataOraDimi		= dataDimi ? UtilDate.getStringDataAndOra( ric.datiDimissione.dataOraDimissione ):"";
				dataRicovero.valueModalitaDimi		= dataDimi ? Utils.getDescrAndCod( ric.datiDimissione.modalitaDimissione ):"";
				dataRicovero.valueRepartoDimi		= dataDimi ? Utils.getDescrAndCod( ric.datiDimissione.repartoDimissione ):"";
				dataRicovero.valueDiagnosiDimi		= dataDimi ? Utils.getDescrAndCod( ric.datiDimissione.diagnosiPrincipaleDimissione ):"";
				 
				var dataPGDg:ArrayCollection		= dataDimi ? getDataProviderDiagnosi(ric.datiDimissione.elencoDiagnosi) : null;
				if(dataPGDg!=null)
				{
					dataRicovero.dataProviderGridDiag	= dataPGDg;
					dataRicovero.rowCountDataGridDiag	= (dataPGDg.length > 5) ? 5 : dataPGDg.length;
				}
				
				var dataPEInt:ArrayCollection		= dataDimi ? getDataProviderInterventi(ric.datiDimissione.elencoInterventi) : null;
				if(dataPEInt!=null)
				{
					dataRicovero.dataProviderGridInterventi	= dataPEInt;
					dataRicovero.rowCountDataGridInterventi	= (dataPEInt.length > 5) ? 5 : dataPEInt.length;
				}
				
				var dataTrasf:ArrayCollection		= getDataProviderTrasferimenti(ric.elencoTrasferimenti)
				
				if(dataTrasf!=null && dataTrasf.length>0)
				{
					dataRicovero.dataProviderGridTrasf	= dataTrasf;
					dataRicovero.rowCountDataGridTrasf	= (dataTrasf.length > 5) ? 5 : dataTrasf.length;
				}
				return dataRicovero;
			}
			return null;
		}
	}
}















