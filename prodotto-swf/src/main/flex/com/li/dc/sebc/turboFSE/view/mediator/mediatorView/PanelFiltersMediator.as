package com.li.dc.sebc.turboFSE.view.mediator.mediatorView
{
	import com.li.dc.sebc.turboFSE.controller.ConstCommand;
	import com.li.dc.sebc.turboFSE.events.TurboEvent;
	import com.li.dc.sebc.turboFSE.view.mediator.ConstMediator;
	import com.li.dc.sebc.turboFSE.view.mediator.TurboView;
	import com.li.dc.sebc.turboFSE.view.nodeView.PanelFilters;
	
	import flash.events.Event;
	
	import it.lispa.siss.sebc.flex.graphic.image.ImageDefinition;
	import it.lispa.siss.sebc.flex.mvc.controller.Controller;
	import it.lispa.siss.sebc.flex.mvc.view.Mediator;
	
	import mx.events.CloseEvent;

	public class PanelFiltersMediator extends Mediator
	{
		private var panelFilters:PanelFilters; 
		private var init:Boolean = false;
		public function PanelFiltersMediator()
		{
			super();
		}
		override protected function finalize():void
		{
			panelFilters.removeEventListener(Event.ADDED_TO_STAGE,onAddedStage);
		}
		override protected function initialize( ):void
		{
			panelFilters = (this.view as PanelFilters);
			panelFilters.addEventListener(Event.ADDED_TO_STAGE,onAddedStage);
		}
		private function onAddedStage(e:Event):void
		{
			if(!init)
			{
				initializeData();
				initializeView();
				panelFilters.callLater(createChildrenMediators);	
			}
		}
		private function initializeData():void
		{
			
		}
		private function createChildrenMediators():void
		{
			var turboView:TurboView = TurboView.getInstance();
			turboView.createMediator(ConstMediator.FILTER_GENERICI,ConstMediator.FILTER_GENERICI, panelFilters.canvasFiltriGenerici);
			turboView.createMediator(ConstMediator.FILTER_DATA,ConstMediator.FILTER_DATA, panelFilters.canvasFiltriData);
			
		}
		private function initializeView():void
		{
			panelFilters.title				= "Pannello filtri";
			panelFilters.styleName			= "windowFilter";
			panelFilters.showCloseButton	= true;
			panelFilters.addEventListener(CloseEvent.CLOSE,onClose);
			panelFilters.addEventListener(TurboEvent.CLICK_CANCELLA,clickCancella); 
			//	 
			//panelFilters.addEventListener(TurboEvent.CLICK_RICERCA,clickRicerca); 
			
			//panelFilters.addEventListener(TurboEvent.CHANGE_PANEL_FILTER,onSelectFilter);
						
		}
		/*private function onSelectFilter(e:TurboEvent):void
		{
			var indexSelected:int 	= panelFilters.indexSelected;
			var flag:Boolean		= panelFilters.selected;
			//FascicoloModel.getInstance().dataButtonFilter = {select:flag,index:index};
			//FascicoloModel.getInstance().selectItemMenu = null;
			//new CairngormEvent(ConstFSECommand.EXECUTE_FILTER).dispatch();
			 
		}*/
		/* cancella i filtri selezionati */
		private function clickCancella(event:TurboEvent):void
		{
			panelFilters.reset();
		}
		private function onClose(event:CloseEvent):void
		{
			closeAll();
			/* Esegue la ricerca nei filtri e chiude il pannello */
			Controller.getInstance().executeCommand(ConstCommand.UPDATE_FILTRI , panelFilters );
			//Controller.getInstance().executeCommand(ConstCommand.CHIUDI_PANEL_FILTRI, panelFilters );
		} 
		private function closeAll():void
		{
			//panelFilters.closeAll()
		}
	 	 
		
		
	}
}