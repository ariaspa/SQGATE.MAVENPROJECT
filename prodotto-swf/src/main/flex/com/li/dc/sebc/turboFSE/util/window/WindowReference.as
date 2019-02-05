package com.li.dc.sebc.turboFSE.util.window
{
	import com.li.dc.sebc.turboFSE.controller.ConstCommand;
	import com.li.dc.sebc.turboFSE.events.WindowEvent;
	import com.li.dc.sebc.turboFSE.model.ConstDataProxy;
	import com.li.dc.sebc.turboFSE.model.FSEModel;
	import com.li.dc.sebc.turboFSE.model.vo.Configuration;
	import com.li.dc.sebc.turboFSE.model.vo.DataAgregazione;
	import com.li.dc.sebc.turboFSE.model.vo.PopupConfig;
	
	import flash.events.EventDispatcher;
	
	import it.lispa.siss.sebc.flex.debug.Debug;
	import it.lispa.siss.sebc.flex.mvc.controller.Controller;

	public class WindowReference extends EventDispatcher
	{
		private var agent:AgentWindow;
		private var jsWindow:JSWindow;
		private var listener:ListenerWindow;
		private var urlVis:String;
		public function WindowReference(data:DataAgregazione)
		{
			super(this);
			listener = new ListenerWindow(this,data);
		}
		public function getDataAgregazione():DataAgregazione
		{
			return listener.getDataAgregazione();
		}
		public function start():void
		{
			Debug.logDebug("WindowReference start getDataAgregazione : " +getDataAgregazione());
			if(agent==null &&  getDataAgregazione()!=null)
			{
				/*var conf:Configuration	= FSEModel.getInstance().retrieveProxy(ConstDataProxy.DATA_CONFIGURATION).getData() as Configuration;
				var pop:PopupConfig  	= conf.popup;
				if(pop!=null)
				{
					var idWindow:String	= getDataAgregazione().idWindow;
					// disabilito il bottone, così da non produrre click fino a quando non ho una risposta dalla finestrella
					// 
					getDataAgregazione().enable	= false;
					urlVis				= pop.urlModuloVisualizer;
					jsWindow			= new JSWindow(pop,idWindow);
					agent 				= new AgentWindow(idWindow);
					addListener( );
				}
				*/
				Controller.getInstance().executeCommand( ConstCommand.DAMMI_FSEPS, "momomom" );
			}
		}
		private function addListener():void
		{
			Debug.logDebug("WindowReference addListener " );
			// eventi che arrivano dalla popup attraverso il localconection
			agent.addEventListener(WindowEvent.CLOSE_WINDOW,onCloseAgentWindow);
			agent.addEventListener(WindowEvent.MOVE_WINDOW,onMoveAgentWindow);
			agent.addEventListener(WindowEvent.RESIZE_WINDOW,onResizeAgentWindow);
			agent.addEventListener(WindowEvent.FOCUS_WINDOW,onFocusAgentWindow);
			agent.addEventListener(WindowEvent.LOAD_WINDOW,onLoadWindowAgentWindow);
			agent.addEventListener(WindowEvent.LOAD_MODULE,onLoadModuleAgentWindow);
			agent.addEventListener(WindowEvent.RECEPTION_DATA,onReceptionDataAgentWindow);
			// 
		}
		private function removeListener():void
		{
			agent.removeEventListener(WindowEvent.CLOSE_WINDOW,onCloseAgentWindow);
			agent.removeEventListener(WindowEvent.MOVE_WINDOW,onMoveAgentWindow);
			agent.removeEventListener(WindowEvent.RESIZE_WINDOW,onResizeAgentWindow);
			agent.removeEventListener(WindowEvent.FOCUS_WINDOW,onFocusAgentWindow);
			agent.removeEventListener(WindowEvent.LOAD_WINDOW,onLoadWindowAgentWindow);
			agent.removeEventListener(WindowEvent.LOAD_MODULE,onLoadModuleAgentWindow);
			agent.removeEventListener(WindowEvent.RECEPTION_DATA,onReceptionDataAgentWindow);
		}
		/* Mi arriva dall'agent, dalla finestrella */
		private function onLoadModuleAgentWindow(e:WindowEvent):void 
		{
			/* Controllo se c'è il salva in cartella e poi spedisco */
			var cda2:Boolean 		= FSEModel.getInstance().documentoCDA2;
			var test:Boolean		= FSEModel.getInstance().documentoTestuale;
			send( ["setListButton",cda2,test] );
			listener.receptionData( ["sendAgregazione"] );
		}
		// la finestra mi ha appena detto che è stata caricata
		private function onLoadWindowAgentWindow(e:WindowEvent):void 
		{
			listener.receptionData( ["sendTitle"] );
			var title:String	= getDataAgregazione().labelAgregazione; 
			send( [TurboFSEAgent.COMMAND,TurboFSEAgent.CHANGE_TITLE,title] );
			send( [TurboFSEAgent.COMMAND,TurboFSEAgent.LOAD_MODULE, urlVis] );
			// riabilito il bottone
			getDataAgregazione().enable		= true;
			getDataAgregazione().inFocus	= true;
		}
		internal function send(param:Array):void
		{
			agent.send( param );
		}
		private function onReceptionDataAgentWindow(e:WindowEvent):void
		{
			listener.receptionData( e.data );
		} 
		private function onFocusAgentWindow(e:WindowEvent):void 
		{
			//Debug.logDebug("WindowReference onFocusAgentWindow : " );
		}
		private function onResizeAgentWindow(e:WindowEvent):void 
		{
			resizeWindow(e.data[0],e.data[1]);
		}
		private function onMoveAgentWindow(e:WindowEvent):void  
		{
			moveWindow( e.data[0], e.data[1]);
		}
		public function focusWindow(data:DataAgregazione):void
		{
			Debug.logDebug("WindowReference focusWindow "+data.idWindow+", -focus-> "+data.inFocus);
			agent.focus(data.inFocus);
		}
		public function resizeWindow(w:Number,h:Number):void
		{
			jsWindow.resizeWindow(w,h);
		}
		public function moveWindow(x:Number,y:Number):void
		{
			jsWindow.moveWindow( x, y );
		}
		private function onCloseAgentWindow(e:WindowEvent):void  
		{
			// mi arriva dalla popup
			//getDataAgregazione().isSelect	= false;	
		}
		public function freeze(flag:Boolean):void
		{
			if(flag)
			{
				agent.send(["freezerWindow"]);
			}else
			{
				agent.send(["defreezerWindow"]);
			}
		}
		public function close():void
		{
			if(agent!=null && jsWindow!=null)
			{
				Debug.logDebug("WindowReference close idWindow: "+this.getDataAgregazione().idWindow);
				// rimuovo gli eventi dalla popup
				removeListener();
				// per ora metodi vuoti in previsione di quando si spostera la logica delle finestre js
				jsWindow.close();
				jsWindow.clearReference();
				// mando un messaggio di chiusura alla popup, se la popup è già chiusa torna indietro un evento, 
				agent.close();
				agent    		= null; 
				jsWindow 		= null;
				 
			}
		}
	}
}