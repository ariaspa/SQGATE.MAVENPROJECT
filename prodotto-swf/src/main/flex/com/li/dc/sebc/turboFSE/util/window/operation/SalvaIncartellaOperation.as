package com.li.dc.sebc.turboFSE.util.window.operation
{
	import com.li.dc.sebc.turboFSE.controller.ConstCommand;
	import com.li.dc.sebc.turboFSE.fseTurbo;
	import com.li.dc.sebc.turboFSE.model.vo.DataAgregazione;
	import com.li.dc.sebc.turboFSE.util.window.ListenerWindow;
	
	import it.lispa.siss.sebc.flex.mvc.controller.Controller;
	import it.lispa.siss.sebc.middleground.entity.Documento;
	import it.lispa.siss.sebc.middleground.entity.SetDocumentale;
	
	use namespace fseTurbo
	public class SalvaIncartellaOperation
	{
		private var reference:ListenerWindow;
		public function SalvaIncartellaOperation(reference:ListenerWindow)
		{
			this.reference = reference;
		}
		
		public function execute(param:Array):void
		{
			var uri:String 			= param[0];
			var type:String 		= param[1];
			var agre:Array	 		= (param[2] as DataAgregazione).agregazione;
			var paramSalva:Object	= getParamSalva(uri,type,agre);
			Controller.getInstance().executeCommand(ConstCommand.OTTIENI_DOCUMENTO,paramSalva);
		}
		private function getDoc(dce:SetDocumentale,type:String):Documento
		{
			if((type.toUpperCase() == "TESTUALE"))
			{
				return dce.documentoTestuale;
			}else
			{
				return dce.documentoStrutturato;	
			}
			return null;
		}
		private function getParamSalva(uri:String,type:String,agre:Array):Object
		{
			var param:Object = new Object();
			var dce:SetDocumentale;
			var doc:Documento;
			for(var i:uint = 0;i<agre.length;i++)
			{
				dce = agre[i] as SetDocumentale;
				doc = getDoc(dce,type);
				if(doc!=null && doc.uri == uri)
				{
					break;
				}	
			}
			param.currDocEntry 			= dce;
			param.currDocument			= doc;
			param.docVisualizzato 		= (type.toUpperCase() == "TESTUALE") ? 1 : 2;
			param.base64 				= VisualizzaTestoRefertoOperation.dict64[uri] ;
			param.note					= dce.noteReperibilita;
			return param;
		}
		fseTurbo function callBackOttieniDoc(message:String):void
		{
			 reference.send( ["responseSalva",message] );
		}
	}
}