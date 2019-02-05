package com.li.dc.sebc.turboFSE.controller.commands.init
{
	import com.li.dc.sebc.turboFSE.model.ConstDataProxy;
	import com.li.dc.sebc.turboFSE.model.FSEModel;
	import com.li.dc.sebc.turboFSE.model.vo.Configuration;
	import com.li.dc.sebc.turboFSE.model.vo.DebugConfig;
	import com.li.dc.sebc.turboFSE.util.LocalConnectionConsole;
	
	import it.lispa.siss.sebc.flex.debug.AgentConsole;
	import it.lispa.siss.sebc.flex.debug.Debug;
	import it.lispa.siss.sebc.flex.debug.IConsole;
	import it.lispa.siss.sebc.flex.mvc.controller.Command;
	import it.lispa.siss.sebc.flex.mvc.controller.ISequenceReference;

	public class ConfigDebugCommand extends Command
	{
		private var reference:ISequenceReference;
		public function ConfigDebugCommand()
		{
			super();
		}
		override public function execute( data:Object = null ):void
		{
			if(data is ISequenceReference)
			{
				Debug.logDebug( "ConfigDebugCommand.execute START setting config debug" );
				reference 				= data as ISequenceReference;
				var conf:Configuration 	= FSEModel.getInstance().retrieveProxy(ConstDataProxy.DATA_CONFIGURATION).getData() as Configuration;
				debugConfiguration( conf.debug );
				/*var ac:IConsole	= new AgentConsole("panel","app#panel:ope_fse");
				Debug.addConsole("panel",ac);*/
				Debug.logDebug( "ConfigDebugCommand.execute STOP setting config debug"); 
				reference.nextCommand();	
			}
		}
		/*<nomeConsole>consoleDebug</nomeConsole> 175821
		<nomeDebug>panelDebug</nomeDebug>*/
		private function debugConfiguration( deb:DebugConfig ):void
		{
			if(deb==null)return;
			if(deb.openDebug)
			{
				var nomeDebug:String			= deb.nomeDebug;
				var nomeConsole:String			= deb.nomeConsole;
					
				var console:IConsole 			= new LocalConnectionConsole(nomeDebug,nomeConsole);
				
				Debug.addConsole(nomeDebug , console );
				
				if(deb.livello>=0)
				{
					Debug.level	= deb.livello;
				}
				if(deb.urlConsole!=null && deb.urlConsole.length>0)
				{
					//openURL(deb.urlConsole,Debug.level,nomeConsole);
				}
			} 
		}
		private function openURL(nomeConsole:String,livello:int,urlConsole:String):String
		{
			var exist:Boolean 		= (urlConsole.lastIndexOf("?") >=0);
			var sep:String	 		= exist ? "&" : "?";
			var and:String			= "&";
			return urlConsole + sep + "nameConsole="+nomeConsole + and + "level="+livello;
		} 
	}
}