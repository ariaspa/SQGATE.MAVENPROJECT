package com.li.dc.sebc.turboFSE.controller.commands
{
	import com.li.dc.sebc.turboFSE.model.ConstDataProxy;
	import com.li.dc.sebc.turboFSE.model.FSEModel;
	import com.li.dc.sebc.turboFSE.model.vo.Configuration;
	import com.li.dc.sebc.turboFSE.util.JSManager;
	import com.li.dc.sebc.turboFSE.util.UtilDate;
	
	import it.lispa.siss.sebc.flex.mvc.controller.Command;
	import it.lispa.siss.sebc.middleground.entity.Cittadino;

	public class GoTemporaleCommand extends Command
	{
		public function GoTemporaleCommand()
		{
			super();
		}
		override public function execute(data:Object = null):void
		{
			try{
				if(!JSManager.getInstance().pedranziniAperto)
				{
					var model:FSEModel			= FSEModel.getInstance();
					
					// Apertura url in base al url presente nei parametri_variabili
					
					//var conf:Configuration		= model.retrieveProxy(ConstDataProxy.DATA_CONFIGURATION).getData() as Configuration;
					var parametriVariabili:Object = model.parametriVariabili;
					var url:String = (parametriVariabili["fse.url.vistatemporale"] as String);
					var nwUrl:String			= "temporale.html?temporale="+url;
					var cittadino:Cittadino		= model.retrieveProxy(ConstDataProxy.DATA_CITTADINO).getData() as Cittadino;
					nwUrl += "&cdFiscale=" + cittadino.codiceFiscale;
					
					if(nwUrl!=null && nwUrl.length>0)
					{
						JSManager.getInstance().openPedranzini( nwUrl );
					}
					
				}
			}catch(e:Error){}
		}
	}
}