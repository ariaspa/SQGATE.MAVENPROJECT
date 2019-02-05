package com.li.dc.sebc.turboFSE.business.remoteService
{
	import com.li.dc.sebc.turboFSE.model.ConstDataProxy;
	import com.li.dc.sebc.turboFSE.model.Costanti;
	import com.li.dc.sebc.turboFSE.model.FSEModel;
	import com.li.dc.sebc.turboFSE.model.vo.Configuration;
	
	import it.lispa.siss.sebc.middleground.entity.Cittadino;
	import it.lispa.siss.sebc.middleground.entity.Operatore;
	
	import mx.rpc.IResponder;
	import mx.rpc.remoting.RemoteObject;
	
	public class UrlFsepsService extends RemoteService
	{
		 public var cittadino:Cittadino;
		 public var operatore:Operatore;
		 public var uri:String;
		 
		public function UrlFsepsService(responder:IResponder = null,destination:String=null, cittadino:Cittadino=null,operatore:Operatore=null,uri:String=null)
		{
			super(responder,destination);
			this.cittadino 			= cittadino;
			this.operatore 			= operatore;
			this.uri 				= uri;
		}
		override public function execute():void
		{
			var rem:RemoteObject  = getRemote();
			if(cittadino!=null && operatore!=null)
			{	
				rem.getUrlFseps(cittadino , operatore, uri);
			}else
			{
				callInternalFault("Uno dei parametri risulta null");
			}
		}
	}
}