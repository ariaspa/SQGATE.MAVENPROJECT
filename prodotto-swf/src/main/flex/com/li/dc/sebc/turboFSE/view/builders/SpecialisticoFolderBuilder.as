package com.li.dc.sebc.turboFSE.view.builders
{
	import com.li.dc.sebc.turboFSE.model.vo.DataSpecialistico;
	import com.li.dc.sebc.turboFSE.util.ArrayCollectionIterator;
	import com.li.dc.sebc.turboFSE.util.UtilDate;
	import com.li.dc.sebc.turboFSE.view.viste.headVista.HeadSpecialistico;
	
	import it.lispa.siss.sebc.middleground.entity.Ambulatoriale;
	import it.lispa.siss.sebc.middleground.entity.AttributiFolderAmbulatoriale;
	import it.lispa.siss.sebc.middleground.entity.DatoCodificato;
	import it.lispa.siss.sebc.middleground.entity.Prestazione;
	
	import mx.collections.ArrayCollection;
	
	public class SpecialisticoFolderBuilder extends OpenableBuilder
	{
		public function SpecialisticoFolderBuilder()
		{
			super();
		}
		override protected function getHeadVistaClass():Class
		{
			return HeadSpecialistico;
		}
		/*
		 *<mx:DataGridColumn headerText="Descrizione Prestazione"  dataField="descrizione"/>
		<mx:DataGridColumn width="120" headerText="Quantità Erogata" dataField="quantita"/> 
		<mx:DataGridColumn headerText="Prestazione Aggiuntiva" dataField="flagAggiuntiva"/>  
		 */
		protected function getListPrestazioni(prestazioniAssociate:ArrayCollection):ArrayCollection
		{
			var iter:ArrayCollectionIterator = new ArrayCollectionIterator(prestazioniAssociate);
			var result:ArrayCollection		= new ArrayCollection();
			while(iter.hasNext())
			{
				var prest:Prestazione	= iter.next() as Prestazione;
				result.addItem( {descrizione:prest.descrizione,quantita:prest.quantita,flagAggiuntiva:prest.flagAggiuntiva} );
			}
			return result;
		}
		override protected function getDataHeader( data:Object ):Object
		{
			var dt:Object = super.getDataHeader( data );
			if(dt is AttributiFolderAmbulatoriale)
			{
				var afspecc:AttributiFolderAmbulatoriale = dt as AttributiFolderAmbulatoriale;
				var ambulatoriale:Ambulatoriale =  afspecc.attributiAmbulatoriale;
				if(ambulatoriale!=null)
				{	
					var result:DataSpecialistico 	= new DataSpecialistico();
					result.labDataOraIngresso		= UtilDate.getStringDataAndOra( ambulatoriale.dataAccettazione );  
					result.labDataPrenotazione		= UtilDate.getStringDataAndOra( ambulatoriale.dataPrenotazione );
					result.labDataPrescrizione		= UtilDate.getStringDataAndOra( ambulatoriale.dataPrescrizione );
					result.labQuesitoDiagnostico	= (ambulatoriale.quesitoDiagnostico==null) ? "":ambulatoriale.quesitoDiagnostico;	
					if(ambulatoriale.diagnosi!=null)
					{
						var diagnosi:DatoCodificato	= ambulatoriale.diagnosi;
						var cod:String 		= diagnosi.codice;
						var codExe:String	= (cod!=null && cod.length > 0) ? " ( "+cod+" )":"";
						var desc:String		= (diagnosi.descrizione!=null && diagnosi.descrizione.length>0) ? diagnosi.descrizione + codExe:"";
						result.labDiagnosi	= desc;
					}
					if(ambulatoriale.prestazioniAssociate!=null && ambulatoriale.prestazioniAssociate.length>0)
					{
						result.dataProviderPrestazioni 	= getListPrestazioni(ambulatoriale.prestazioniAssociate);
						result.rowCountPrestazioni		= (ambulatoriale.prestazioniAssociate.length>5) ? 5 : ambulatoriale.prestazioniAssociate.length;
					}
					if(ambulatoriale.esenzione!=null && ambulatoriale.esenzione.descrizione!=null)
					{
						result.labEsenzione		= ambulatoriale.esenzione.descrizione;	
					}
					if(ambulatoriale.classePriorita!=null && ambulatoriale.classePriorita.descrizione!=null)
					{
						result.labPriorita = ambulatoriale.classePriorita.descrizione; 
					} 
					if(ambulatoriale.provenienzaPaziente!=null && ambulatoriale.provenienzaPaziente.descrizione!=null)
					{
						result.labProvenienza = ambulatoriale.provenienzaPaziente.descrizione;
					}
					if(ambulatoriale.regimeErogazione!=null && ambulatoriale.regimeErogazione.descrizione!=null)
					{
						result.labErogazione = ambulatoriale.regimeErogazione.descrizione;
					}
					return result; 
				}
			}
			return null;
		}
	}
}








