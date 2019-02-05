package com.li.dc.sebc.turboFSE.util.window.operation
{
	import com.li.dc.sebc.turboFSE.controller.ConstCommand;
	import com.li.dc.sebc.turboFSE.fseTurbo;
	import com.li.dc.sebc.turboFSE.util.window.ListenerWindow;
	
	import it.lispa.siss.sebc.flex.mvc.controller.Controller;
	use namespace fseTurbo
	public class LoadAllegatoOperation
	{
		private var reference:ListenerWindow;
		public function LoadAllegatoOperation(reference:ListenerWindow)
		{
			this.reference = reference;
		}
		public function execute(param:Array):void
		{
			var linkReferto:String 	= param[0];
			var linkImmagine:String = param[1];
			var tipo:String 		= param[2];
			if (tipo != null && tipo == "01")
			{
				//RichiediURLImmagineCommand
				var prm:Object 			= new Object();
				prm.callback			= callBackRichiediURL;
				prm.linkReferto 		= linkReferto;
				prm.linkImmagine 		= linkImmagine;
				prm.tipoImmagine 		= tipo;
				Controller.getInstance().executeCommand(ConstCommand.RICHIEDI_URL_IMMAGINE,prm);
			} else 
			{
				var visualizza:VisualizzaTestoRefertoOperation = new VisualizzaTestoRefertoOperation( reference );  
				visualizza.execute( [linkImmagine,tipo] );
			} 
		}
		private function callBackRichiediURL(url:String):void
		{
			reference.send( ["responseLoadAllegato",url] );
		}
	}
}