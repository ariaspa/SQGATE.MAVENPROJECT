package com.li.dc.sebc.turboFSE.util.window
{
	import com.li.dc.sebc.turboFSE.fseTurbo;
	import com.li.dc.sebc.turboFSE.model.vo.DataAgregazione;
	import com.li.dc.sebc.turboFSE.util.window.operation.AutorizzaOperation;
	import com.li.dc.sebc.turboFSE.util.window.operation.GadoOperation;
	import com.li.dc.sebc.turboFSE.util.window.operation.LoadAllegatoOperation;
	import com.li.dc.sebc.turboFSE.util.window.operation.SalvaIncartellaOperation;
	import com.li.dc.sebc.turboFSE.util.window.operation.VisualizzaTestoRefertoOperation;
	
	import it.lispa.siss.sebc.flex.debug.Debug;
	
	use namespace fseTurbo
	
	public class ListenerWindow
	{
		private var _data:DataAgregazione;
		private var reference:WindowReference;
		public function getDataAgregazione():DataAgregazione
		{
			return _data;
		}
		public function ListenerWindow(reference:WindowReference,data:DataAgregazione)
		{
			_data = data;
			this.reference	= reference;
		}
		/**
		 * qui mi arrivano le richieste della finestra, 
		 * o meglio del modulo dentro alla finestra 
		 * @param e
		 * 
		 */	
		internal function receptionData(param:Array):void
		{
			Debug.logDebug("ListenerWindow.receptionData param : "+param);
			if(param !=null && param.length>=1)
			{
				var command:String	= param.shift() as String;
				switch(command)
				{
					case "sendAgregazione":
						sendAgregazione();
					break;
					case "sendTitle":
						sendTitle();
					break;
					case "visualizzaTestoReferto":
						visualizzaTestoReferto(param);
					break;
					case "autorizza":
						autorizzaFun(param);	
					break;
					case "reqSalvaInCartella":
						reqSalvaInCartella(param);
					break;
					case "oscura":
						oscuraFun(param);
					break;
					case "deoscura":
						deoscuraFun(param);
					break;
					case "loadAllegato":
						loadAllegato(param);
					break; 
				}
			}
		}
		private function loadAllegato(param:Array):void
		{
			var loadAllegato:LoadAllegatoOperation = new LoadAllegatoOperation( this );
			loadAllegato.execute(param);
		}
		private function deoscuraFun(param:Array):void
		{
			var gado:GadoOperation = new GadoOperation();
			param.push("deoscura");
			gado.execute(param);
		}
		private function oscuraFun(param:Array):void
		{
			var gado:GadoOperation = new GadoOperation();
			param.push("oscura");
			gado.execute(param);
		}
		private function reqSalvaInCartella(param:Array):void
		{
			var salvaInCartella:SalvaIncartellaOperation = new SalvaIncartellaOperation(this);
			param.push( getDataAgregazione() );
			salvaInCartella.execute(param);
		}
		private function autorizzaFun(param:Array):void
		{
			Debug.logDebug("ListenerWindow.autorizzaFun param : "+param);
			var autorizza:AutorizzaOperation = new AutorizzaOperation(this);
			autorizza.execute( param[0], getDataAgregazione().agregazione ); 
		}
		private function visualizzaTestoReferto(param:Array):void
		{
			var visualizza:VisualizzaTestoRefertoOperation = new VisualizzaTestoRefertoOperation( this );  
			visualizza.execute( param );
		}
		private function sendAgregazione():void
		{
			/* recupero l'agregazione e la spedisco */
			var objAg:Object		= TransformAgregazione.transform( _data.agregazione );
			send( ["setAgregazione",  objAg ] );
		}
		private function sendTitle():void
		{
			var title:String	= getDataAgregazione().labelAgregazione;
			send([TurboFSEAgent.COMMAND,TurboFSEAgent.CHANGE_TITLE,title]);
		}
		fseTurbo function send(param:Array):void
		{
			reference.send( param );
		}
	}
}