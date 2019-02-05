package com.li.dc.sebc.turboFSE.view.mediator.mediatorView
{
	import com.li.dc.sebc.turboFSE.controller.ConstCommand;
	import com.li.dc.sebc.turboFSE.events.TurboEvent;
	import com.li.dc.sebc.turboFSE.model.Costanti;
	import com.li.dc.sebc.turboFSE.model.FSEModel;
	import com.li.dc.sebc.turboFSE.model.vo.DataAgregazione;
	import com.li.dc.sebc.turboFSE.util.window.GestWindows;
	import com.li.dc.sebc.turboFSE.view.component.BarraAgregazione;
	import com.li.dc.sebc.turboFSE.view.viste.OpenableVista;
	import com.li.dc.sebc.turboFSE.view.viste.VistaBodyAgregazione;

	import flash.events.Event;
	import flash.net.FileReference;
	import flash.net.URLRequest;

	import it.lispa.siss.sebc.flex.debug.Debug;
	import it.lispa.siss.sebc.flex.mvc.controller.Controller;
	import it.lispa.siss.sebc.flex.mvc.view.Mediator;
	import it.lispa.siss.sebc.flex.utils.Later;
	import it.lispa.siss.sebc.middleground.entity.SetDocumentale;

	import mx.controls.Alert;

	public class OpenableVistaMediator extends Mediator
	{
		private var vista:OpenableVista;

		public function OpenableVistaMediator()
		{
			super();
		}

		override protected function finalize():void
		{
			vista.removeEventListener(Event.ADDED_TO_STAGE,onAddedStage);
			vista.removeEventListener(Event.REMOVED_FROM_STAGE,onRemoveStage);
			removeAll();
		}
		private function setButtons(listButtons:Array):void
		{
			refresh(listButtons);
			for(var i:uint = 0;i<listButtons.length;i++)
			{
				var btn:BarraAgregazione = listButtons[i];
				if(btn!=null && btn.dataAgregazione!=null)
				{
					btn.addEventListener(TurboEvent.CLICK_ICON_DCE,onClickIcon);
					btn.dataAgregazione.addEventListener(TurboEvent.DATA_AGREGAZIONE_CHANGE_FOCUS,onDceFocus);
					btn.dataAgregazione.addEventListener(TurboEvent.DATA_AGREGAZIONE_CHANGE_SELECT,onClickDce);
				}
			}
		}
		private function removeAll():void
		{
			if(vista.bodyVista !=null)
			{
				var vistaAgregazione:VistaBodyAgregazione = vista.bodyVista as VistaBodyAgregazione;
				var listButtons:Array	= vistaAgregazione.getListButton();
				for(var i:uint = 0;i<listButtons.length;i++)
				{
					var btn:BarraAgregazione = listButtons[i];
					if(btn!=null && btn.dataAgregazione!=null)
					{
						btn.removeEventListener(TurboEvent.CLICK_ICON_DCE,onClickIcon);
						btn.dataAgregazione.removeEventListener(TurboEvent.DATA_AGREGAZIONE_CHANGE_FOCUS,onDceFocus);
						btn.dataAgregazione.removeEventListener(TurboEvent.DATA_AGREGAZIONE_CHANGE_SELECT,onClickDce);
					}
				}
			}
		}

		/**
		 * il dataAgregazione è select
		 * @param e
		 *
		 */
		private function onClickDce(e:TurboEvent):void
		{
			e.stopImmediatePropagation();
			Debug.logWarning("OpenableVistaMediator onClickDce");
			var parametriVariabili:Object = FSEModel.getInstance().parametriVariabili;
			var switchBigDoc:Boolean = ((parametriVariabili["switchBigDocument"] as String) == "true");
			var data:DataAgregazione = e.target as DataAgregazione;

			var setDoc:SetDocumentale  = data.agregazione[0] as SetDocumentale;
			data.dispatchEvent(new TurboEvent(TurboEvent.REFRESH));
			//if (switchBigDoc && (setDoc.tipoDocumento.codice == Costanti.TIPO_DOC_TACUINO || setDoc.tipoDocumento.codice == Costanti.TIPO_DOC_CARTELLA_CLINICA)) {

				//Fase 1
				//Controller.getInstance().executeCommand(ConstCommand.OTTIENI_TESTO_REFERTO, setDoc);
				//Fase 1-end

				//Fase 2
			//	Controller.getInstance().executeCommand(ConstCommand.RICHIEDI_URL_TESTO_REFERTO, setDoc);
				//Fase 2-end
				//data.enable	= false;
				//data.isSelect = false;
			//}
			//else {
				//data.dispatchEvent(new TurboEvent(TurboEvent.REFRESH));
				//GestWindows.getInstance().manageAgregazione( data );
				Controller.getInstance().executeCommand( ConstCommand.DAMMI_FSEPS, setDoc.documentoTestuale.uri );
			//}
		}

		private function onDceFocus(e:TurboEvent):void
		{
			e.stopImmediatePropagation();
			Debug.logWarning("OpenableVistaMediator onDceFocus");
			var data:DataAgregazione = e.target as DataAgregazione;
			data.dispatchEvent(new TurboEvent(TurboEvent.REFRESH));
			GestWindows.getInstance().changeFocus( data );
		}
		private function onClickIcon(e:TurboEvent):void
		{

		}
		override protected function initialize():void
		{
			vista = this.view as OpenableVista;
			initializeView();
		}
		private function onRemoveStage(e:Event):void
		{
			removeAll();
		}
		private function onAddedStage(e:Event):void
		{
			 if(vista.bodyVista!=null &&  vista.bodyVista.dataVista!=null)
			 {
			 	onCompleteVista();
			 }
		}
		private function initializeView():void
		{
			vista.addEventListener(Event.ADDED_TO_STAGE,onAddedStage);
			vista.addEventListener(Event.REMOVED_FROM_STAGE,onRemoveStage);

			if(vista.bodyVista==null)
			{
				// avviene una sola volta da quando viene creata la vista
				vista.addEventListener(TurboEvent.COMPLETE_EVENT,onCompleteVista);
			}else
			{
				onCompleteVista();
			}
		}
		/**
		 * raccologo la lista dei bottoni
		 * @param e
		 *
		 */
		private function  onCompleteVista(e:Event = null):void
		{
			Debug.logDebug("OpenableVistaMediator onCompleteVista ");
			if(vista.bodyVista!=null &&  vista.bodyVista.dataVista!=null)
			{
				var data:Object = vista.bodyVista.dataVista;
				if(data!=null && data is Array)
				{
					var vistaAgregazione:VistaBodyAgregazione = vista.bodyVista as VistaBodyAgregazione;
					var listButtons:Array	= vistaAgregazione.getListButton();
					if(listButtons!=null )
					{
						setButtons( listButtons );
					}else
					{
						Later.doLater( onCompleteVista );
					}
				}else
				{
					Later.doLater( onCompleteVista );
				}
			}
		}
		protected function refresh(listButtons:Array):void
		{
			for(var i:uint = 0;i<listButtons.length;i++)
			{
				var btn:BarraAgregazione = listButtons[i];
				if(btn!=null)
				{
					btn.refresh();
				}
			}
		}
		////////////////////////////////////////////////


		/* Array di Array */
		private function getDataAgregazione(listAgregazione:Array):Array
		{
			return [];
		}

		/*private function laterFunction(barraAgregazione:BarraAgregazione,agregazione:Array):void
		{
			this.box.addChild( barraAgregazione );
			this.addListenerButton(barraAgregazione.bottone);
			var canvasDce:OpenableVista = this.getVistaDCE(agregazione);
			this.box.addChild( canvasDce );
			this.addBtnToVista(barraAgregazione.bottone,canvasDce);
			this.addVistaTobtn(barraAgregazione.bottone,canvasDce);
			this.dictVistaBarra[barraAgregazione.bottone] = barraAgregazione;

			var nameWindow:String 		= GestWindows.getInstance().createName( VoDocEntry(barraAgregazione.agregazione[0]).idSetDocumentale );
			nameWindow = nameWindow + "_" + VoDocEntry(barraAgregazione.agregazione[0]).counterWin;
			var exist:Boolean			= GestWindows.getInstance().existWindow( nameWindow );
			if(exist)
			{
				GestWindows.getInstance().replaceBarra(nameWindow,barraAgregazione);
			}
		}*/
	}
}