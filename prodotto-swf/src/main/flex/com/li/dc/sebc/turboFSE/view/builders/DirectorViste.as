package com.li.dc.sebc.turboFSE.view.builders
{
	import com.li.dc.sebc.turboFSE.model.Costanti;
	import com.li.dc.sebc.turboFSE.model.FSEModel;
	import com.li.dc.sebc.turboFSE.model.vo.ConstAttributiFolder;
	import com.li.dc.sebc.turboFSE.model.vo.DataLabelTree;
	import com.li.dc.sebc.turboFSE.model.vo.EventoTree;
	import com.li.dc.sebc.turboFSE.model.vo.FolderTree;
	import com.li.dc.sebc.turboFSE.model.vo.WrapData;
	import com.li.dc.sebc.turboFSE.view.mediator.TurboView;
	import com.li.dc.sebc.turboFSE.view.viste.Vista;
	
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.ConstTipiEventi;
	import it.lispa.siss.sebc.flex.collection.ArrayIterator;
	import it.lispa.siss.sebc.flex.collection.HashEntry;
	import it.lispa.siss.sebc.flex.collection.IIterator;
	import it.lispa.siss.sebc.flex.mvc.view.Mediator;
	import it.lispa.siss.sebc.middleground.entity.DatoCodificato;
	
	public class DirectorViste
	{
		private static var instance:DirectorViste;
		public static function getInstance():DirectorViste
		{
			if(instance==null)
			{
				instance = new DirectorViste();
			}
			return instance;
		}
		/////////////////////////////////////////////////
		private var builder:Builder;
		private var temporalebuilder:TemporaleBuilder;
		private var farmaceuticoEvBuilderWrap:FarmaceuticoEventBuilderWrap;
		private var farmaceuticoEvBuilder:FarmaceuticoEventBuilder;
		private var farmaceuticoBuilder:FarmaceuticoFolderBuilder;
		private var prericoveroBuilder:PrericoveroFolderBuilder;
		private var pattientsummaryBuilder:PattientSummaryFolderBuilder;
		private var specialisticoBuilder:SpecialisticoFolderBuilder;
		private var specialisticoEvBuilder:SpecialisticoEventBuilder;
		private var specialisticoEvBuilderWrap:SpecialisticoEventBuilderWrap;
		private var ricoveroBuilder:RicoveroFolderBuilder;
		private var ricoveroEvBuilder:RicoveroEventBuilder;
		private var ricoveroEvBuilderWrap:RicoveroEventBuilderWrap;
		private var psBuilder:PSoccorsoFolderBuilder;
		private var psEvBuilder:PSoccorsoEventBuilder;
		private var psEvBuilderWrap:PSoccorsoEventBuilderWrap;
		private var containerFolderBuilder:ContainerFolderBuilder;
		private var vaccinazioniFolderBuilder:VaccinazioniFolderBuilder;
		private var pdtBuilder:PDTBuilder;
		private var documentiBuilder:DocumentiBuilder;
		private var cronologicoBuilder:CronologicoBuilder;
		private var disciplinaBuilder:DisciplinaBuilder;
		
		public function DirectorViste()
		{
			if(instance!=null)throw new Error("Only one instance");
			instance = this;
		}
		public function createVista(obj:Object):Vista
		{
			return getBuilder(obj).createVista();
		}
		public function clear():void
		{
			 var entries:Array	= FSEModel.getInstance().hashViste.getEntries();
			 var iter:IIterator	= new ArrayIterator(entries);
			 while(iter.hasNext())
			 {
			 	var next:HashEntry	= iter.next() as HashEntry;
			 	if(next.value is Mediator)
			 	{
			 		TurboView.getInstance().destroyMediator( (next.value as Mediator).name );
			 	}
			 }
			 FSEModel.getInstance().hashViste.clear();
		}
		/////////////////////////////////////////////////////////////
		private function getBuilder(obj:Object):Builder
		{
			if(obj is FolderTree)
			{
				return selectBuilderFolder(obj as FolderTree);
			}else if(obj is EventoTree)
			{
				return selectBuilderEvento(obj as EventoTree);
			}else if(obj is WrapData)
			{
				return selectBuilderWrap(obj as WrapData);
			}else if(obj is DataLabelTree)
			{
				return selectBuilderObject(obj as DataLabelTree);
			}	
			return getGenericBuilder(obj);
		}
		private function selectBuilderWrap(obj:WrapData):Builder
		{
			var data:Object	= obj.data;
			if(data is EventoTree)
			{
				return selectBuilderWrapEvento(obj);	
			}
			return getGenericBuilder(data);
		} 
		private function selectBuilderWrapEvento(obj:WrapData):Builder 
		{
			var evento:EventoTree = obj.data as EventoTree;
			if(evento.children!=null && evento.children.length>0 || evento.isRoot)
			{
				return null;
			}else
			{
				var dtcod:DatoCodificato = evento.tipoEvento;
				if(dtcod!=null)
				{
					var cod:String = dtcod.codice;
					switch(cod)
					{
						 case ConstTipiEventi.EVENTO_FARMACEUTICO:
							 return getFarmaceuticoEventBuilderWrap( obj );
						 case ConstTipiEventi.EVENTO_PSOCCORSO:
						 	return getPSEventBuilderWrap( obj );
						 case ConstTipiEventi.EVENTO_RICOVERO:
							 return getRicoveroEventBuilderWrap( obj );
						 case ConstTipiEventi.EVENTO_SPECIALISTICO:
						 	return getSpecialisticoEventBuilderWrap( obj );
					}
				}
			}
			return getGenericBuilder(obj);
		}
		private function selectBuilderEvento(evento:EventoTree):Builder 
		{
			if(evento.children!=null && evento.children.length>0)
			{
				return getContainerFolderBuilder(evento);
			}else if(evento.isRoot)
			{
				return getGenericBuilder(evento);		
			}else
			{
				var dtcod:DatoCodificato = evento.tipoEvento;
				if(dtcod!=null)
				{
					var cod:String = dtcod.codice;
					switch(cod)
					{
						 case ConstTipiEventi.EVENTO_FARMACEUTICO:
							 return getFarmaceuticoEventBuilder( evento );
						 case ConstTipiEventi.EVENTO_PSOCCORSO:
						 	return getPSEventBuilder( evento );
						 case ConstTipiEventi.EVENTO_RICOVERO:
							 return getRicoveroEventBuilder( evento );
						 case ConstTipiEventi.EVENTO_SPECIALISTICO:
						 	return getSpecialisticoEventBuilder( evento );
					}
				}
			}
			return getGenericBuilder(evento);
		}
		private function selectBuilderObject(obj:DataLabelTree):Builder 
		{
			// TODO :  da implementare
			switch(obj.value)
			{
				case Costanti.DOCUMENTI:	
					return getDocumenti( obj );	
				case Costanti.CRONOLOGICO:
					/* Eventi da flusso  */
					return getCronologico( obj );
				case Costanti.DISCIPLINA:	
					return getDisciplina( obj );
				case Costanti.TEMPORALE2:	
					return getTemporale( obj );		
			}
			return  getGenericBuilder(obj);
		}
		
		private function  getCronologico(obj:DataLabelTree):Builder
		{
			if(cronologicoBuilder==null)cronologicoBuilder = new CronologicoBuilder();
			cronologicoBuilder.setParam( obj );
			return cronologicoBuilder;
		}
		private function  getDocumenti(obj:DataLabelTree):Builder
		{
			if(documentiBuilder==null)documentiBuilder = new DocumentiBuilder();
			documentiBuilder.setParam( obj );
			return documentiBuilder;
		} 
		private function  getDisciplina(obj:DataLabelTree):Builder
		{
			if(disciplinaBuilder==null)disciplinaBuilder = new DisciplinaBuilder();
			disciplinaBuilder.setParam( obj );
			return disciplinaBuilder;
		} 
		
		private function  getTemporale(obj:DataLabelTree):Builder
		{
			if(temporalebuilder==null)temporalebuilder = new TemporaleBuilder();
			temporalebuilder.setParam( obj );
			return temporalebuilder;
		} 
		/** 
		 * Lazy instantation
		 * @param folder
		 * @return 
		 * 
		 */		
		
		private function selectBuilderFolder(folder:FolderTree):Builder 
		{
			// ha figli quindi è un folder contenitore
			if(folder.children!=null && folder.children.length>0)
			{
				return getContainerFolderBuilder(folder);
			}
			// folder foglia
			var typeFolder:String = folder.idTipoFolder;
			switch(typeFolder)
			{
				/* VACCINAZIONI*/  
				case ConstAttributiFolder.TIPO_VACCINAZIONI:
					return getVaccinazioniFolderBuilder( folder );
				/* PDT */	
				case ConstAttributiFolder.TIPO_PDT:
					return getPDTFolderBuilder( folder );
				/* PRONTO SOCCORSO */
				case ConstAttributiFolder.TIPO_PSOCCORSO:
				case ConstAttributiFolder.TIPO_ALTRI_DOCUMENTI_PS:
					return getPSFolderBuilder( folder );
				case ConstAttributiFolder.TIPO_RICOVERO:
				case ConstAttributiFolder.TIPO_ALTRI_DOCUMENTI_NOSO:
					return getRicoveroFolderBuilder( folder );
				/* SPECIALISTICO */
				case ConstAttributiFolder.TIPO_IUP:
				case ConstAttributiFolder.TIPO_ALTRI_DOCUMENTI_IUP:
				case ConstAttributiFolder.TIPO_IUP_IN_CARTELLA_AMBULATORIALE:
					return getSpecialisticoFolderBuilder( folder );
				/* PATIENTSUMMARY */
				case ConstAttributiFolder.TIPO_PATIENTSUMMARY:
					return getPattientSummaryFolderBuilder( folder );
				/* PRERICOVERO */	
				case ConstAttributiFolder.TIPO_PRERICOVERI:
					return getPrericoveroFolderBuilder( folder );
				/* FARMACEUTICO */
				case ConstAttributiFolder.TIPO_FARMACEUTICO:
					return getFarmaceuticoFolderBuilder( folder );
			}
			/* DEFAULT */
			return getRetiFolderBuilder( folder );
		}
		//////////////////////////////////////////////////////////////////
		//////////////////////////////////////////////////////////////////
		
		//ok
		private function getGenericBuilder(obj:Object):Builder
		{
			if(builder==null)builder = new Builder();
			builder.setParam(obj);
			return builder;    
		} 
		/* questo get è diverso perchè non so quanti casi diversi usano reti */
		private function getRetiFolderBuilder(obj:Object):Builder
		{
			var retiBuilder:RetiFolderBuilder  = new RetiFolderBuilder();
			retiBuilder.setParam( obj );
			return retiBuilder;
		}
		//ok
		private function getFarmaceuticoEventBuilder(obj:Object):Builder
		{
			if(farmaceuticoEvBuilder==null)farmaceuticoEvBuilder = new FarmaceuticoEventBuilder();
			farmaceuticoEvBuilder.setParam( obj );
			return farmaceuticoEvBuilder;
		}
		private function getFarmaceuticoEventBuilderWrap(obj:Object):Builder
		{
			if(farmaceuticoEvBuilderWrap==null)farmaceuticoEvBuilderWrap = new FarmaceuticoEventBuilderWrap();
			farmaceuticoEvBuilderWrap.setParam( obj );
			return farmaceuticoEvBuilderWrap;
		}
		private function getFarmaceuticoFolderBuilder(obj:Object):Builder
		{
			if(farmaceuticoBuilder==null)farmaceuticoBuilder = new FarmaceuticoFolderBuilder();
			farmaceuticoBuilder.setParam( obj );
			return farmaceuticoBuilder;
		}
		//ok
		private function getPrericoveroFolderBuilder(obj:Object):Builder
		{
			if(prericoveroBuilder==null)prericoveroBuilder = new PrericoveroFolderBuilder();
			prericoveroBuilder.setParam( obj );
			return prericoveroBuilder;
		}
		//ok
		private function getPattientSummaryFolderBuilder(obj:Object):Builder
		{
			if(pattientsummaryBuilder==null)pattientsummaryBuilder = new PattientSummaryFolderBuilder();
			pattientsummaryBuilder.setParam( obj );
			return pattientsummaryBuilder;
		}
		//ok
		private function getSpecialisticoFolderBuilder(obj:Object):Builder
		{
			if(specialisticoBuilder==null)specialisticoBuilder = new SpecialisticoFolderBuilder();
			specialisticoBuilder.setParam( obj );
			return specialisticoBuilder;
		}
		private function getSpecialisticoEventBuilderWrap(obj:Object):Builder
		{
			if(specialisticoEvBuilderWrap==null)specialisticoEvBuilderWrap = new SpecialisticoEventBuilderWrap();
			specialisticoEvBuilderWrap.setParam( obj );
			return specialisticoEvBuilderWrap;
		}
		private function getSpecialisticoEventBuilder(obj:Object):Builder
		{
			if(specialisticoEvBuilder==null)specialisticoEvBuilder = new SpecialisticoEventBuilder();
			specialisticoEvBuilder.setParam( obj );
			return specialisticoEvBuilder;
		}
		//ok
		private function getRicoveroFolderBuilder(obj:Object):Builder
		{
			if(ricoveroBuilder==null)ricoveroBuilder = new RicoveroFolderBuilder();
			ricoveroBuilder.setParam( obj );
			return ricoveroBuilder;
		}
		private function getRicoveroEventBuilderWrap(obj:Object):Builder
		{
			if(ricoveroEvBuilderWrap==null)ricoveroEvBuilderWrap = new RicoveroEventBuilderWrap();
			ricoveroEvBuilderWrap.setParam( obj );
			return ricoveroEvBuilderWrap;
		}
		private function getRicoveroEventBuilder(obj:Object):Builder
		{
			if(ricoveroEvBuilder==null)ricoveroEvBuilder = new RicoveroEventBuilder();
			ricoveroEvBuilder.setParam( obj );
			return ricoveroEvBuilder;
		}
		//ok
		private function getPSFolderBuilder(obj:Object):Builder
		{
 			if(psBuilder==null)psBuilder = new PSoccorsoFolderBuilder();
			psBuilder.setParam( obj );
			return psBuilder;
		}
		private function getPSEventBuilderWrap(obj:Object):Builder
		{
 			if(psEvBuilderWrap==null)psEvBuilderWrap = new PSoccorsoEventBuilderWrap();
			psEvBuilderWrap.setParam( obj );
			return psEvBuilderWrap;
		}
		private function getPSEventBuilder(obj:Object):Builder
		{
 			if(psEvBuilder==null)psEvBuilder = new PSoccorsoEventBuilder();
			psEvBuilder.setParam( obj );
			return psEvBuilder;
		}
		//ok
		private function getPDTFolderBuilder(obj:Object):Builder
		{
			if(pdtBuilder==null)pdtBuilder = new PDTBuilder();
			pdtBuilder.setParam( obj );
			return pdtBuilder;
		}
		//ok
		private function getVaccinazioniFolderBuilder(obj:Object):Builder
		{
			if(vaccinazioniFolderBuilder==null)vaccinazioniFolderBuilder = new VaccinazioniFolderBuilder();
			vaccinazioniFolderBuilder.setParam( obj );
			return vaccinazioniFolderBuilder;
		}
		//ok
		private function getContainerFolderBuilder(obj:Object):Builder
		{
			if(containerFolderBuilder==null)containerFolderBuilder = new ContainerFolderBuilder();
			containerFolderBuilder.setParam( obj );
			return containerFolderBuilder;
		}
		//////////////////////
	}
}
