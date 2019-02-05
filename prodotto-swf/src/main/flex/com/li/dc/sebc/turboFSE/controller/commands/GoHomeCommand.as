package com.li.dc.sebc.turboFSE.controller.commands
{
	import com.li.dc.sebc.turboFSE.model.ConstDataProxy;
	import com.li.dc.sebc.turboFSE.model.FSEModel;
	
	import it.lispa.siss.sebc.flex.debug.Debug;
	import it.lispa.siss.sebc.flex.mvc.controller.Command;
	
	import mx.events.CloseEvent;
	
	public class GoHomeCommand extends Command
	{
		public function GoHomeCommand()
		{
			super();
		}
		private function myCloseTest(e:CloseEvent):void
		{
			Debug.logDebug("Ci stiamo dentro ::: " + e.target);
		}
		override public function execute(data:Object = null ):void
		{
			var model:FSEModel		= FSEModel.getInstance();
			model.retrieveProxy( ConstDataProxy.STATE_STACK ).update( "attesa" );
			
			
			//Alert.yesLabel = "SI ACCETTO";
			//Alert.noLabel  = "NO NON ACCETTO";
			//ViewMessageManager.getInstance().showAlert("questo è un test","test",Alert.NO | Alert.YES,myCloseTest);
			// Alert.show("CIOCCIOCICOICOCI","prova",Alert.OK);
			//addPopUp
			/*var url:String = FSEModel.getInstance().urlHome;
			var request:URLRequest = new URLRequest( url );
			navigateToURL( request , "_self" ); 
			
			
			 
			var model:FSEModel		= FSEModel.getInstance();
			var conf:Configuration 	= model.retrieveProxy(ConstDataProxy.DATA_CONFIGURATION).getData() as Configuration;
			var local:Boolean = (conf.host == Costanti.HOST_LOCAL);
			if(local)
			{
				FSEModel.getInstance().testArea =!FSEModel.getInstance().testArea; 
				if(FSEModel.getInstance().testArea)
				{
					FSEModel.getInstance().retrieveProxy(ConstDataProxy.STATE_AREA_LAVORO).update(AreaLavoro.ACTIVE);
				}else
				{
					FSEModel.getInstance().retrieveProxy(ConstDataProxy.STATE_AREA_LAVORO).update(AreaLavoro.WAIT);
				}
			}else
			{
				var cod:String = model.queryParams[Costanti.CODICEFISCALE];
				if(cod!=null && cod.length>0)
				{
					// aperto non dal menù 
					// TODO Chiedere cosa fare al posto di tornarte alla home
					Debug.logWarning("TODO Chiedere cosa fare al posto di tornarte alla home");
				}else
				{
					var url:String = FSEModel.getInstance().urlHome;
					var request:URLRequest = new URLRequest( url );
					navigateToURL( request , "_self" );
				}
			}
			*/
 		}
	}
}