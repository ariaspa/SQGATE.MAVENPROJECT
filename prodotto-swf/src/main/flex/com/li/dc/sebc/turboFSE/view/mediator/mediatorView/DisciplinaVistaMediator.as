package com.li.dc.sebc.turboFSE.view.mediator.mediatorView
{
	import com.li.dc.sebc.turboFSE.events.TurboEvent;
	import com.li.dc.sebc.turboFSE.model.vo.DataAgregazione;
	import com.li.dc.sebc.turboFSE.util.window.GestWindows;
	import com.li.dc.sebc.turboFSE.view.component.BarraAgregazione;
	import com.li.dc.sebc.turboFSE.view.viste.VistaDisciplina;
	
	import flash.events.Event;
	
	import it.lispa.siss.sebc.flex.debug.Debug;
	import it.lispa.siss.sebc.flex.mvc.view.Mediator;
	import it.lispa.siss.sebc.flex.utils.Later;
	import it.lispa.siss.sebc.middleground.entity.SetDocumentale;
	
	import mx.controls.Alert;
	import mx.events.CloseEvent;

	public class DisciplinaVistaMediator extends Mediator
	{
		private var vista:VistaDisciplina;
		private var _lastDCE:SetDocumentale
		public function DisciplinaVistaMediator()
		{
			super();
		}
		override protected function finalize():void
		{
			vista.removeEventListener(Event.ADDED_TO_STAGE,onAddedStage);
			vista.removeEventListener(Event.REMOVED_FROM_STAGE,onRemoveStage);
			removeAll();
		}
		override protected function initialize():void
		{
			vista = this.view as VistaDisciplina;
			vista.addEventListener(Event.ADDED_TO_STAGE,onAddedStage);
			vista.addEventListener(Event.REMOVED_FROM_STAGE,onRemoveStage);
			vista.addEventListener(TurboEvent.COMPLETE_EVENT,onCompleteVista);
		}
		private function  onCompleteVista(e:Event = null):void
		{
		 	Debug.logDebug("DisciplinaVistaMediator.onCompleteVista doLater ");
			var listButtons:Array	= (vista as VistaDisciplina).getListButton();
			if( listButtons !=null && listButtons.length > 0 )
			{	
				(vista as VistaDisciplina).removeEventListener(TurboEvent.COMPLETE_EVENT,onCompleteVista);		 
				setButtons( listButtons );
			}else
			{
				Later.doLater( onCompleteVista );
			}
		}
		protected function refresh(listButtons:Array):void
		{
			Debug.logDebug("DisciplinaVistaMediator.refresh listButtons.length "+listButtons.length);
			for(var i:uint = 0;i<listButtons.length;i++)
			{
				var btn:BarraAgregazione = listButtons[i];
				if(btn!=null)
				{
					btn.refresh();
				}
			}
		}
		private function setButtons(listButtons:Array):void
		{
			Debug.logDebug("DisciplinaVistaMediator.setButtons ");
			refresh( listButtons );
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
			var listButtons:Array	= vista.getListButton();
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
		private function onClickDce(e:TurboEvent):void
		{
			e.stopImmediatePropagation();
			Debug.logWarning("OpenableVistaMediator onClickDce");
			var data:DataAgregazione = e.target as DataAgregazione;
			data.dispatchEvent(new TurboEvent(TurboEvent.REFRESH));
			GestWindows.getInstance().manageAgregazione( data );
		}
		 
		private function onDceFocus(e:TurboEvent):void
		{
			e.stopImmediatePropagation();
			Debug.logWarning("OpenableVistaMediator onDceFocus");
			var data:DataAgregazione = e.target as DataAgregazione;
			data.dispatchEvent(new TurboEvent(TurboEvent.REFRESH));
			GestWindows.getInstance().changeFocus( data );
		}
		/*private function onClickDce(e:TurboEvent):void
		{
			e.stopImmediatePropagation();
			Debug.logWarning("DisciplinaVistaMediator onClickDce");
			var barra:BarraAgregazione 	= e.target as BarraAgregazione;
			var data:DataAgregazione	= barra.dataAgregazione;
			GestWindows.getInstance().manageAgregazione( data );
		}
		
		private function onDceFocus(e:TurboEvent):void
		{
			e.stopImmediatePropagation();
			Debug.logWarning("DisciplinaVistaMediator onDceFocus");
			var barra:BarraAgregazione 	= e.target as BarraAgregazione;
			var data:DataAgregazione	= barra.dataAgregazione;
			GestWindows.getInstance().changeFocus( data );
		}*/
		
		private function onClickIcon(e:TurboEvent):void
		{
			var btn:BarraAgregazione = e.target as BarraAgregazione;
			btn.refresh();
			/*var dataAgregazione:DataAgregazione	= (e.target as BarraAgregazione).dataAgregazione;
			var statoDce:String 				= dataAgregazione.statoDCE;
			if(statoDce == DataAgregazione.LINKOSCURATO ||
			statoDce == DataAgregazione.LINK)
			{
				_lastDCE = dataAgregazione.agregazione[0];
				var msg:String	= "Sei sicuro di voler cancellare il riferimento al documento selezionato?";
				Alert.yesLabel 	= "SI";
				ViewMessageManager.getInstance().showAlert(msg,"Conferma",(Alert.YES | Alert.NO),confermaCancella,null,Alert.YES);
			}else if(statoDce == DataAgregazione.OSCURATO ||
			statoDce == DataAgregazione.DOCUMENTO)
			{
			
			}*/
		}
		private function confermaCancella(event:CloseEvent):void
		{
			if (event.detail == Alert.YES && _lastDCE!=null) 
			{
				 
				/*var e:CallBackEvent = new CallBackEvent(ConstFSECommand.CANCELLA_DCE, callbackCancellaDCE);
				var param:Object = new Object();
				param.folder = GlobalModel.getInstance().dictVofolders[dce.idPadre];
				param.dce = dce;
				e.data = param;
				e.dispatch();*/
			}
		}
		
		
		private function onRemoveStage(e:Event):void{}
		
		private function onAddedStage(e:Event):void
		{
			 if(vista.dataVista!=null)
			 {
			 	onCompleteVista();
			 }
		}
	}
}