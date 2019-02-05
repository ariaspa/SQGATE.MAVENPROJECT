package com.li.dc.sebc.turboFSE.business
{
	import com.li.dc.sebc.turboFSE.business.cache.CittadinoCacheService;
	import com.li.dc.sebc.turboFSE.business.remoteService.ComuniRemoteService;
	import com.li.dc.sebc.turboFSE.business.remoteService.ConsoleService;
	import com.li.dc.sebc.turboFSE.business.remoteService.ContentFolderService;
	import com.li.dc.sebc.turboFSE.business.remoteService.EventiCittadinoService;
	import com.li.dc.sebc.turboFSE.business.remoteService.IdentificaCittadinoService;
	import com.li.dc.sebc.turboFSE.business.remoteService.OperatoreOnDemand;
	import com.li.dc.sebc.turboFSE.business.remoteService.ParametriVariabiliRemoteService;
	import com.li.dc.sebc.turboFSE.business.remoteService.ProvinceRemoteService;
	import com.li.dc.sebc.turboFSE.business.remoteService.TimelineService;
	import com.li.dc.sebc.turboFSE.business.remoteService.TreeService;
	import com.li.dc.sebc.turboFSE.business.remoteService.UrlFsepsService;
	import com.li.dc.sebc.turboFSE.business.soapPdlService.coop.OperatoreService;
	import com.li.dc.sebc.turboFSE.business.soapPdlService.crm.RichiediUrlImmagine;
	import com.li.dc.sebc.turboFSE.business.soapPdlService.crm.VisualizzaTestoReferto;
	import com.li.dc.sebc.turboFSE.business.soapPdlService.fse.ApriPDTService;
	import com.li.dc.sebc.turboFSE.business.soapPdlService.fse.AutorizzaDCEService;
	import com.li.dc.sebc.turboFSE.business.soapPdlService.fse.CancellaDCEService;
	import com.li.dc.sebc.turboFSE.business.soapPdlService.fse.ChiudiPDTService;
	import com.li.dc.sebc.turboFSE.business.soapPdlService.fse.CopiaDCEService;
	import com.li.dc.sebc.turboFSE.business.soapPdlService.fse.OttieniDocumentoService;
	import com.li.dc.sebc.turboFSE.business.soapPdlService.fse.RichiediUrlTestoRefertoService;
	import com.li.dc.sebc.turboFSE.business.soapPdlService.icce.IdentificaCittadinoSmartCard;
	import com.li.dc.sebc.turboFSE.business.soapPdlService.sa.InterrogaAscoltatoriService;
	import com.li.dc.sebc.turboFSE.business.soapPdlService.util.ContentVisualizerPluginService;
	import com.li.dc.sebc.turboFSE.business.soapPdlService.util.LeggiSmartCard;
	import com.li.dc.sebc.turboFSE.business.xmlService.LoadXmlService;
	import com.li.dc.sebc.turboFSE.model.ConstDataProxy;
	import com.li.dc.sebc.turboFSE.model.FSEModel;
	import com.li.dc.sebc.turboFSE.model.vo.VoInputTimeLine;

	import it.lispa.siss.sebc.flex.debug.Debug;
	import it.lispa.siss.sebc.middleground.entity.Cittadino;
	import it.lispa.siss.sebc.middleground.entity.Documento;
	import it.lispa.siss.sebc.middleground.entity.Folder;
	import it.lispa.siss.sebc.middleground.entity.Operatore;
	import it.lispa.siss.sebc.middleground.entity.PercorsoDiagnosticoTerapeutico;
	import it.lispa.siss.sebc.middleground.entity.SetDocumentale;

	import mx.rpc.IResponder;

	public class FactoryService
	{
		private static var instance:FactoryService;
		public static function getInstance():FactoryService
		{
			if(instance == null)
			{
				instance = new FactoryService( new HideClass() );
			}
			return instance;
		}

		public function FactoryService(hide:HideClass)
		{
		}
		public function getLoadXml(responder:IResponder, url:String ):TurboService
		{
			// fatto
			var service : LoadXmlService = new LoadXmlService();
			service.responder	= responder;
			service.url			= url;
		 	return service as TurboService;
		}

		public function getOpeConsole(message:String, level:uint, levelDebug:uint=0):TurboService
		{
			var service : ConsoleService = new ConsoleService();
			service.message = message;
			service.level 	= level;
			service.destination	= FSEModel.getInstance().destination;
			return service;
		}

		public function getContentFolder(responder:IResponder,id:String):TurboService
		{
			// fatto
			Debug.logDebug( "getContentFolder   "+responder +", id : "+id);
			var service : ContentFolderService = new ContentFolderService();
			service.destination	= FSEModel.getInstance().destination;
			service.cittadino	= FSEModel.getInstance().retrieveProxy(ConstDataProxy.DATA_CITTADINO).getData() as Cittadino;
			service.operatore	= FSEModel.getInstance().retrieveProxy(ConstDataProxy.DATA_OPERATORE).getData() as Operatore;
			service.responder	= responder;
			service.idFolder	= id;
			return service as TurboService;
		}

		public function getInterrogaAscoltatori(responder:IResponder,nomeMetodo:String,nameSpace:String):TurboService
		{
			// fatto
			var service : InterrogaAscoltatoriService = new InterrogaAscoltatoriService();
			service.responder 	= responder;
			service.factory		= FSEModel.getInstance().factorySA;
			service.nomeMetodo	= nomeMetodo;
			service.nameSpace	= nameSpace;
			return service as TurboService;
		}
		public function getStatoServiceImportaDoc():TurboService
		{
			Debug.logWarning("getStatoServiceImportaDoc da implementare");
			return null;
		}
		// remoto
		public function getListaCittadini(responder:IResponder,
							cittadino:Cittadino,
							maxRecord:String=null,
							numPagine:String=null,
							useWildCard:String=null,
							omettiEsenzioni:String=null
							):TurboService
		{
			var service : IdentificaCittadinoService = new IdentificaCittadinoService();
			service.cittadino			= cittadino;
			service.operatore			= FSEModel.getInstance().retrieveProxy(ConstDataProxy.DATA_OPERATORE).getData() as Operatore;
			service.destination			= FSEModel.getInstance().destination;
			service.responder 			= responder;

			service.maxRecord			= maxRecord;
			service.numPagine			= numPagine;
			service.useWildCard			= useWildCard;
			service.omettiEsenzioni		= omettiEsenzioni;
			return service as TurboService;
		}
		public function getOttieniSmartCard(responder:IResponder):TurboService
		{
			var service : LeggiSmartCard 	= new LeggiSmartCard();
			service.factory					= FSEModel.getInstance().factoryUtil;
			service.responder 				= responder;
			return service as TurboService;
		}
		public function getCittadinoSmartCard(responder:IResponder):TurboService
		{
			var service : IdentificaCittadinoSmartCard = new IdentificaCittadinoSmartCard();
			service.factoryIcce	= FSEModel.getInstance().factoryICCE;
			service.responder 	= responder;
			return service as TurboService;
		}
		// remoto
		/*
		public function getCittadino(responder:IResponder,identificativo:String,type:String):TurboService
		{
			var service : IdentificaCittadinoService = new IdentificaCittadinoService();
			service.destination			= FSEModel.getInstance().destination;
			var cittadino :Cittadino	= new Cittadino();
			cittadino.codiceFiscale		= identificativo;
			service.cittadino			= cittadino;
			service.operatore			= FSEModel.getInstance().retrieveProxy(ConstDataProxy.DATA_OPERATORE).getData() as Operatore;
			service.responder			= responder;
			return service as TurboService;
		}*/
		///////////////////////////////////////
		///////////////////////////////////////
		///////////////////////////////////////

		public function getCittadinoCache(responder:IResponder):TurboService
		{
			var service : CittadinoCacheService = new CittadinoCacheService();
			service.responder = responder;
			return service as TurboService;
		}
		/*  il nuovo service per ricavare l'operatore va diretto su FSEOperatore java in Blazeds*/
		public function getOperatoreOnDemand(responder:IResponder):TurboService
		{
			var service : OperatoreOnDemand = new OperatoreOnDemand( responder, FSEModel.getInstance().destination );
			return service;
		}
		/*  il vecchio service per ricavare l'operatore */
		public function getOperatore(responder:IResponder):TurboService
		{
			var service : OperatoreService = new OperatoreService();
			service.factoryCoop	= FSEModel.getInstance().factoryCOOP;
			service.responder	= responder;
			Debug.logDebug( "FactoryService . getOperatore" );
			return service as TurboService;
		}

		public function getClassificazioni(responder:IResponder):TurboService
		{
			return getContentFolder(responder,"70");
		}

		public function getTimeline(responder:IResponder,input:VoInputTimeLine):TurboService
		{
			// fatto
			var service : TimelineService = new TimelineService();
			service.responder	= responder;
			service.destination	= FSEModel.getInstance().destination;
			service.cittadino	= FSEModel.getInstance().retrieveProxy(ConstDataProxy.DATA_CITTADINO).getData() as Cittadino;
			service.operatore	= FSEModel.getInstance().retrieveProxy(ConstDataProxy.DATA_OPERATORE).getData() as Operatore;
			service.input		= input;
			 //
			return service as TurboService;
		}
		public function getTree(responder:IResponder,order:uint=0, conSetDocumentali:Boolean=false):TurboService
		{
			// fatto
			var service : TreeService = new TreeService();
			service.destination	= FSEModel.getInstance().destination;
			service.cittadino	= FSEModel.getInstance().retrieveProxy(ConstDataProxy.DATA_CITTADINO).getData() as Cittadino;
			service.operatore	= FSEModel.getInstance().retrieveProxy(ConstDataProxy.DATA_OPERATORE).getData() as Operatore;
			service.responder	= responder;
			service.order		= order;
			service.conSetDocumentali = conSetDocumentali;
			return service as TurboService;
		}
		public function getUrlFseps(responder:IResponder, uri:String):TurboService
		{
			var service : UrlFsepsService = new UrlFsepsService();
			service.destination	= FSEModel.getInstance().destination;
			service.cittadino	= FSEModel.getInstance().retrieveProxy(ConstDataProxy.DATA_CITTADINO).getData() as Cittadino;
			service.operatore	= FSEModel.getInstance().retrieveProxy(ConstDataProxy.DATA_OPERATORE).getData() as Operatore;
			service.responder	= responder;
			service.uri		= uri;
			return service as TurboService;
		}
		
		public function getEventiCittadino(responder:IResponder, dataInizio:String, dataFine:String,idTipoEvento:String=null):TurboService
		{
			var service:EventiCittadinoService = new EventiCittadinoService();
			service.destination			= FSEModel.getInstance().destination;
			service.cittadino			= FSEModel.getInstance().retrieveProxy(ConstDataProxy.DATA_CITTADINO).getData() as Cittadino;
			service.operatore			= FSEModel.getInstance().retrieveProxy(ConstDataProxy.DATA_OPERATORE).getData() as Operatore;
			service.responder			= responder;
			service.idTipoEvento		= idTipoEvento;
			service.dataInizio			= dataInizio;
			service.dataFine			= dataFine;
			return service as TurboService;
		}
		public function getApriPDT(responder:IResponder, pdt:PercorsoDiagnosticoTerapeutico ):TurboService
		{
			var service : ApriPDTService = new ApriPDTService();
			service.cittadino	= FSEModel.getInstance().retrieveProxy(ConstDataProxy.DATA_CITTADINO).getData() as Cittadino;
			service.responder	= responder;
			service.factory		= FSEModel.getInstance().factoryFSE;
			service.pdt			= pdt;
			return service as TurboService;
		}
		  public function getChiudiPDT(responder:IResponder, pdt:PercorsoDiagnosticoTerapeutico, note:String ):TurboService
		{
			var service : ChiudiPDTService = new ChiudiPDTService();
			service.cittadino	= FSEModel.getInstance().retrieveProxy(ConstDataProxy.DATA_CITTADINO).getData() as Cittadino;
			service.responder	= responder;
			service.factory		= FSEModel.getInstance().factoryFSE;
			service.pdt			= pdt;
			service.note		= note;
			return service as TurboService;
		}


		public function getCopiaDCE(responder:IResponder, folderDest:Folder, dce:SetDocumentale ):TurboService
		{
			var service : CopiaDCEService = new CopiaDCEService();
			service.cittadino	= FSEModel.getInstance().retrieveProxy(ConstDataProxy.DATA_CITTADINO).getData() as Cittadino;
			service.responder	= responder;
			service.factory		= FSEModel.getInstance().factoryFSE;
			service.dce			= dce;
			service.folderDest	= folderDest;
			return service as TurboService;
		}
		public function getCancellaDCE(responder:IResponder, folderDest:Folder, dce:SetDocumentale):TurboService
		{
			var service : CancellaDCEService = new CancellaDCEService();
			service.cittadino	= FSEModel.getInstance().retrieveProxy(ConstDataProxy.DATA_CITTADINO).getData() as Cittadino;
			service.responder	= responder;
			service.factory		= FSEModel.getInstance().factoryFSE;
			service.dce			= dce;
			service.folderDest	= folderDest;
			return service as TurboService;
		}
		public function getAutorizzaDCE(responder:IResponder, note:String, agregazione:Array):TurboService
		{
			var service : AutorizzaDCEService = new AutorizzaDCEService();
			service.cittadino	= FSEModel.getInstance().retrieveProxy(ConstDataProxy.DATA_CITTADINO).getData() as Cittadino;
			service.operatore   = FSEModel.getInstance().retrieveProxy(ConstDataProxy.DATA_OPERATORE).getData() as Operatore;
			service.responder	= responder;
			service.factory		= FSEModel.getInstance().factoryFSE;
			service.note		= note;
			service.agregazione	= agregazione;
			return service as TurboService;
		}
		public function getOttieniDocumento(responder:IResponder, statoDocVisualizzato:uint,
											currDocEntry:SetDocumentale, currDoc:Documento,
											contenutoB64:String, noteReperibilta:String):TurboService
		{
			var service : OttieniDocumentoService = new OttieniDocumentoService();
			service.cittadino	= FSEModel.getInstance().retrieveProxy(ConstDataProxy.DATA_CITTADINO).getData() as Cittadino;
			service.responder	= responder;
			service.factory		= FSEModel.getInstance().factoryFSE;
			service.statoDocVisualizzato	= statoDocVisualizzato;
			service.currDocEntry	= currDocEntry;
			service.currDoc			= currDoc;
			service.contenutoB64	= contenutoB64;
			service.noteReperibilta	= noteReperibilta;
			return service as TurboService;
		}
		public function getElencoProvince(responder:IResponder):TurboService
		{
			var serviceRem:ProvinceRemoteService	= new ProvinceRemoteService();
			serviceRem.responder					= responder;
			serviceRem.destination					= FSEModel.getInstance().destination;
			return serviceRem as TurboService;
		}
		public function getElencoComuni(responder:IResponder, codiceProvincia:String ):TurboService
		{
			var serviceRem:ComuniRemoteService	= new ComuniRemoteService();
			serviceRem.responder				= responder;
			serviceRem.destination				= FSEModel.getInstance().destination;
			serviceRem.codiceProvincia			= codiceProvincia;
			return serviceRem as TurboService;
		}
		public function getVisualizzaTestoReferto(responder:IResponder,uri:String,codicefiscale:String):TurboService
		{
			var service:VisualizzaTestoReferto	= new VisualizzaTestoReferto();
			service.responder					= responder;
			service.factory						= FSEModel.getInstance().factoryCRM;
			service.codiceFiscale				= codicefiscale;
			service.uri							= uri;
			return service as TurboService;
		}
		public function getContentVisualizerPlugin(responder:IResponder,data:Object):TurboService
		{
			Debug.logDebug("FactoryService getContentVisualizerPlugin ");
			var service:ContentVisualizerPluginService	= new ContentVisualizerPluginService();
			service.responder							= responder;
			service.factory								= FSEModel.getInstance().factoryUtil;
			service.data								= data;
			return service as TurboService;
		}
		public function geRichiediUrlImmagine(responder:IResponder,data:Object):TurboService
		{
			var service:RichiediUrlImmagine = new RichiediUrlImmagine();
			service.factory					= FSEModel.getInstance().factoryCRM;
			service.responder				= responder;
			service.data					= data;
			service.codiceFiscale			= (FSEModel.getInstance().retrieveProxy(ConstDataProxy.DATA_CITTADINO).getData() as Cittadino).codiceFiscale;
			return service as TurboService;
		}

		public function getRichiediUrlTestoReferto(responder:IResponder, setDoc:SetDocumentale):TurboService
		{
			var service:RichiediUrlTestoRefertoService = new RichiediUrlTestoRefertoService();
			service.cittadino = FSEModel.getInstance().retrieveProxy(ConstDataProxy.DATA_CITTADINO).getData() as Cittadino;
			service.factory = FSEModel.getInstance().factoryFSE;
			service.responder = responder;
			service.setDoc = setDoc;
			return service as TurboService;
		}

		public function getParametriVariabili(responder:IResponder):TurboService
		{
			var serviceRem:ParametriVariabiliRemoteService = new ParametriVariabiliRemoteService();
			serviceRem.responder = responder;
			serviceRem.destination = FSEModel.getInstance().destination;
			return serviceRem as TurboService;
		}
	}
}
class HideClass{}