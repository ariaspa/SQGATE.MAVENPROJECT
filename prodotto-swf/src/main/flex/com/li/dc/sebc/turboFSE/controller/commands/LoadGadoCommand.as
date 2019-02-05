package com.li.dc.sebc.turboFSE.controller.commands
{
	import com.li.dc.sebc.turboFSE.controller.ConstCommand;
	import com.li.dc.sebc.turboFSE.model.ConstDataProxy;
	import com.li.dc.sebc.turboFSE.model.Costanti;
	import com.li.dc.sebc.turboFSE.model.FSEModel;
	import com.li.dc.sebc.turboFSE.model.vo.Configuration;
	import com.li.dc.sebc.turboFSE.util.JSManager;
	import com.li.dc.sebc.turboFSE.util.ViewMessageManager;
	import com.li.dc.sebc.turboFSE.util.window.GestWindows;
	
	import it.lispa.siss.sebc.flex.mvc.controller.Command;
	import it.lispa.siss.sebc.flex.mvc.controller.Controller;
	import it.lispa.siss.sebc.middleground.entity.Cittadino;

	public class LoadGadoCommand extends Command
	{
		private var gadoUrl:String;
		private var codFiscale:String;
		private var param:Object;
		public function LoadGadoCommand()
		{
			super();
		}
		override public function execute(data:Object = null):void
		{
			if(data !=null)
			{
				param 				= data;
				var idEntry:String 	= (param.idEntry ==null) ? "" : param.idEntry;
				var uri:String 		= (param.uri == null ) ? "" : param.uri;
				var action:String 	= (param.action == null) ? "" : param.action;
				  
				if(action=="finestra" || action=="oscura" || action=="deoscura")
				{
					var codFiscale:String	= (FSEModel.getInstance().retrieveProxy(ConstDataProxy.DATA_CITTADINO).getData() as Cittadino).codiceFiscale;	 
					// questa stringa sarebbe da prendere da fuori
					//var urlFinVis:String	= "temporale=https://was.cgi.crs.lombardia.it/SebsGate/gado_flex/indexExternal.html";
					var urlFinVis:String	= "temporale=https://dcss.cgi.crs.lombardia.it/ope_gado/";
					var codFisc:String		= "codiceFiscale=" + codFiscale;
					var act:String			= "action=" +action.toUpperCase();
					var idEnt:String		= "idEntry="+idEntry;
					var link:String			= "linkDCE="+uri; 
					var newUrl:String		= "temporale.html?"+urlFinVis + "&" + codFisc + "&" + act + "&" + idEnt + "&" + link;
					
					JSManager.getInstance().creaNuovaFinestraGado( newUrl ,unloadGado);
					//GlobalModel.getInstance().isFreeze = true;
					//ViewMessageManager.getInstance().freezeApplication(true,"Attendere... Apertura applicazione esterna");
					//GestWindows.getInstance().freezeAll(true);
				}
			}
		}
		///////////////////////////////////////////////
		private function unloadGado(tabAbilitazione:String, tabOscuraDeoscura:String):void
		{
			//GlobalModel.getInstance().isFreeze = false;
			//GestWindows.getInstance().freezeAll(false);
			if ((tabAbilitazione != null && tabAbilitazione != "null") || (tabOscuraDeoscura != null && tabOscuraDeoscura != "null" )) 
			{
				//ViewMessageManager.getInstance().freezeApplication(false);
				// non so perchè di questo comportamento
				GestWindows.getInstance().clearAll();
				Controller.getInstance().executeCommand(ConstCommand.AGGIORNA_FASCICOLO);
			}
		} 
	}
}