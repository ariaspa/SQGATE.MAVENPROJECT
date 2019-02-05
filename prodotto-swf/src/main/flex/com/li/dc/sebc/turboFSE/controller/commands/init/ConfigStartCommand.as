package com.li.dc.sebc.turboFSE.controller.commands.init
{
	import com.li.dc.sebc.turboFSE.model.ConstDataProxy;
	import com.li.dc.sebc.turboFSE.model.FSEModel;
	import com.li.dc.sebc.turboFSE.model.vo.Configuration;
	import com.li.dc.sebc.turboFSE.util.ManagerKey;
	import com.li.dc.sebc.turboFSE.util.TurboReader;
	import com.li.dc.sebc.turboFSE.util.ViewMessageManager;
	import com.li.dc.sebc.turboFSE.view.mediator.ConstMediator;
	import com.li.dc.sebc.turboFSE.view.mediator.TurboView;
	import com.li.dc.sebc.turboFSE.view.nodeView.AreaLavoro;
	import com.li.dc.sebc.turboFSE.view.nodeView.Header;
	
	import it.lisit.siss.flex.communication.impl.soap.HTTPCommunicator;
	import it.lisit.siss.flex.communication.impl.soap.ICommunicatorSoap;
	import it.lisit.siss.flex.communication.impl.soap.coop.FactoryCoopSoap;
	import it.lisit.siss.flex.communication.impl.soap.crm.FactoryCRM;
	import it.lisit.siss.flex.communication.impl.soap.fse.FactorySoapFSE04;
	import it.lisit.siss.flex.communication.impl.soap.icce.FactoryIcce;
	import it.lisit.siss.flex.communication.impl.soap.sa.FactorySoapSA;
	import it.lisit.siss.flex.communication.impl.soap.util.FactorySoapUtil;
	import it.lispa.siss.library.ui.menustandard.Footer;
	import it.lispa.siss.sebc.flex.debug.Debug;
	import it.lispa.siss.sebc.flex.help.HelpManager;
	import it.lispa.siss.sebc.flex.memento.ManagerMemento;
	import it.lispa.siss.sebc.flex.messages.IUserMessage;
	import it.lispa.siss.sebc.flex.messages.MessageManager;
	import it.lispa.siss.sebc.flex.mvc.controller.Command;
	import it.lispa.siss.sebc.flex.mvc.controller.ISequenceReference;
	/**
	 * Inizializzo  i valori iniziali dell'applicazione  
	 * @author Marco Salonia
	 * 
	 */	
	public class ConfigStartCommand extends Command
	{
		private var reference:ISequenceReference;
		public function ConfigStartCommand()
		{
			super();
		}
		override public function execute( data:Object = null ):void
		{
			if(data is ISequenceReference)
			{
				Debug.logDebug( "ConfigStartCommand.execute START setting destination, listaCodiciPDT, HTTPCommunicator per le chiamate pdl, setting dei factory " );
				reference = data as ISequenceReference;
				var model:FSEModel		= FSEModel.getInstance();
				var conf:Configuration 	= model.retrieveProxy(ConstDataProxy.DATA_CONFIGURATION).getData() as Configuration;
				model.destination		= conf.destination;
				model.retrieveProxy(ConstDataProxy.DATA_PDT_OPEN).update( conf.listaCodiciPDT.toArray() );
 				model.retrieveProxy(ConstDataProxy.DATA_PDT_CLOSE).update( new Array() );
 				
				// il comunicatore soap	(pdl)		
				// commentare quando siamo nella situazione reale
				// non viene più usato nemmeno nel fake
				//var communicator:ICommunicatorSoap = new URLLoaderCommunicator( getLocalServices() );
				// scommentare quando siamo nella situazione reale
				var communicator:ICommunicatorSoap =  new HTTPCommunicator();
				 
				////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
				model.factoryFSE		= new FactorySoapFSE04(communicator);
				model.factoryCOOP		= new FactoryCoopSoap(communicator);
				model.factoryICCE		= new FactoryIcce(communicator);
				model.factoryCRM		= new FactoryCRM(communicator);
				model.factorySA		 	= new FactorySoapSA(communicator);
				model.factoryUtil 		= new FactorySoapUtil(communicator);
				////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
				ManagerMemento.getInstance().setMaxSize( FSEModel.getInstance().maxSizeMemento );
				ManagerKey.init( FSEModel.getInstance().turboApp );
				///////////////
				var view:TurboView = TurboView.getInstance();
				//var header:Header = view.retriveMediator(ConstMediator.HEADER).getView() as Header;
				//header.callLater(setHelpManager,[header]);
				///////////////
				ViewMessageManager.getInstance().setPopUp( view.retriveMediator(ConstMediator.AREA_LAVORO).getView() as AreaLavoro );
				//ViewMessageManager.getInstance().showDisplayer(
				///////////////
				/* il vecchio footer */
				//var footer:Footer = view.retriveMediator(ConstMediator.FOOTER).getView() as Footer;
				//footer.displayerMessage	= ViewMessageManager.getInstance() as IDisplayerMessage;
				/////////////// ora c'è una gestione mista.
				// TurboReader usa il footer di gabriele per i warning e le eccezioni delle chiamate ai servizi
				// 
				MessageManager.getInstance().reader	= new TurboReader(view.retriveMediator(ConstMediator.FOOTER).getView() as Footer);
				MessageManager.getInstance().addUser(  view.retriveMediator(ConstMediator.FOOTER) as IUserMessage );
				Debug.logDebug( "ConfigStartCommand.execute STOP setting destination, listaCodiciPDT, HTTPCommunicator per le chiamate pdl, setting dei factory " );
				reference.nextCommand( );
			}
		}
		
		/* private function setHelpManager(header:Header):void
		{
			if(header.dragInfo!=null)
			{
				HelpManager.getInstance().setButtonHelp(header.dragInfo);
			} 
		}  */
		private function getLocalServices():Array
		{
			//new LocalService("FSE.consultaFascicolo","xml/consultaFascicolo2009.xml")
			//new LocalService("FSE.ottieniIndiceFascicolo","xml/indice05052010.xml")
			//new LocalService("ICCE.identificaCittadinoCarta","xml/rispostaSingolaIdentificaCitt.xml"),
			return [new LocalService("FSE.autorizzaDCE","xml/autorizzaDce.xml"),
					new LocalService("provinceDiNascita","xml/ldbResponseprovince.xml"),
					new LocalService("comuniDiNascita","xml/ldbResponseComuni.xml"),
					new LocalService("ICCE.identificaCittadinoEsteso","xml/rispostaSingolaIdentificaCitt.xml"),
					new LocalService("FSE.apriPDT","xml/apri_pdt.xml"),
					new LocalService("FSE.chiudiPDT","xml/chiudi_pdt.xml"),
					new LocalService("FSE.consultaEventiDaFlussi","xml/FSEconsultaeventi_3.xml"),
					new LocalService("CRM.visualizzaTestoReferto","xml/visualizzaTestoReferto_error.xml"),
					new LocalService("SA.interrogaAscoltatori","xml/interrogaAscoltatori.xml"),
					new LocalService("FSE.ottieniDocumentoTestuale","xml/interrogaAscoltatori.xml"),
					new LocalService("UTIL.contentVisualizerPlugin","xml/visualizerPlugIn.xml"),
					new LocalService("FSE.copiaDCEInFolder","xml/copiaDCEInFolder.xml"),
					new LocalService("LeggiCredenziali","xml/leggiCredenziali.xml"),
					new LocalService("FSE.cancellaDCEDaFolder","xml/cancellaDCEDaFolder.xml")];
		}
	}
}



class LocalService 
{
	private var _name:String;
	private var _url:String;
	//
	public function LocalService(serv:String,indirizzo:String)
	{
		_name	= serv;
		_url 	= indirizzo;
	}
	public function get servizio():String{return _name;}
	public function get url():String{return _url;}
}