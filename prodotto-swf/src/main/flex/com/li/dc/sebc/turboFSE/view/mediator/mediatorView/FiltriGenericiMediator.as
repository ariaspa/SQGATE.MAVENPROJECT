package com.li.dc.sebc.turboFSE.view.mediator.mediatorView
{
	import com.li.dc.sebc.turboFSE.events.MessageEvent;
	import com.li.dc.sebc.turboFSE.events.SelectItems;
	import com.li.dc.sebc.turboFSE.events.TurboEvent;
	import com.li.dc.sebc.turboFSE.model.ConstDataProxy;
	import com.li.dc.sebc.turboFSE.model.FSEModel;
	import com.li.dc.sebc.turboFSE.model.filters.EnteSpecification;
	import com.li.dc.sebc.turboFSE.model.filters.ErogazioneSpecification;
	import com.li.dc.sebc.turboFSE.model.filters.FolderSpecification;
	import com.li.dc.sebc.turboFSE.model.filters.ManagerFilters;
	import com.li.dc.sebc.turboFSE.model.filters.PresidioSpecification;
	import com.li.dc.sebc.turboFSE.view.component.CanvasFiltriGenerici;
	import com.li.dc.sebc.turboFSE.view.component.ResizableBoxFiltri;
	
	import flash.utils.Dictionary;
	
	import it.lispa.siss.sebc.flex.mvc.model.proxy.DataProxyEvent;
	import it.lispa.siss.sebc.flex.mvc.view.Mediator;
	import it.lispa.siss.sebc.flex.specification.ISpecification;

	public class FiltriGenericiMediator extends Mediator
	{
		private var filterGenerici:CanvasFiltriGenerici; 
		private var oldHasFilter:Boolean = false;
		private var listFilter:Dictionary;
		private var listBox:Dictionary;
		private var select:Boolean;
		public function FiltriGenericiMediator()
		{
			super();
		}
		override protected function finalize():void
		{
		}
		override protected function initialize( ):void
		{
			filterGenerici = (this.view as CanvasFiltriGenerici);
			initializeData();
			initializeView();	
		}
		private function initializeData():void
		{
			select = false;
			var model:FSEModel = FSEModel.getInstance();
			model.retrieveProxy(ConstDataProxy.DATA_TREE).addEventListener(DataProxyEvent.DATA_UPDATE,onUpdateTree);
			 
			updateErogazione(model.retrieveProxy(ConstDataProxy.LIST_EROGAZIONE).getData() as Array);
			updateFolder(model.retrieveProxy(ConstDataProxy.LIST_FOLDER).getData() as Array);
			updatePresidio(model.retrieveProxy(ConstDataProxy.LIST_PRESIDIO).getData() as Array);
			updateEnte(model.retrieveProxy(ConstDataProxy.LIST_ENTE).getData() as Array);
			
			model.retrieveProxy(ConstDataProxy.LIST_EROGAZIONE).addEventListener(DataProxyEvent.DATA_UPDATE,onUpdateErogazione);
			model.retrieveProxy(ConstDataProxy.LIST_FOLDER).addEventListener(DataProxyEvent.DATA_UPDATE,onUpdateFolder);
			model.retrieveProxy(ConstDataProxy.LIST_PRESIDIO).addEventListener(DataProxyEvent.DATA_UPDATE,onUpdatePresidio);
			model.retrieveProxy(ConstDataProxy.LIST_ENTE).addEventListener(DataProxyEvent.DATA_UPDATE,onUpdateEnte);
			 
			listFilter 	= new Dictionary();
			listBox		= new Dictionary();
			
		}
		private function initializeView():void
		{
			filterGenerici.addEventListener(TurboEvent.RESET_EVENT,onReset);
			////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			filterGenerici.ente.addEventListener(SelectItems.SELECT_ITEMS,onSelectItemsEnte);
			filterGenerici.erogazione.addEventListener(SelectItems.SELECT_ITEMS,onSelectItemsErogazione);
			filterGenerici.folder.addEventListener(SelectItems.SELECT_ITEMS,onSelectItemsFolder);
			filterGenerici.presidio.addEventListener(SelectItems.SELECT_ITEMS,onSelectItemsPresidio);
			////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			filterGenerici.ente.addEventListener(MessageEvent.MESSAGE_EVENT,onMessage);
			filterGenerici.erogazione.addEventListener(MessageEvent.MESSAGE_EVENT,onMessage);
			filterGenerici.folder.addEventListener(MessageEvent.MESSAGE_EVENT,onMessage);
			filterGenerici.presidio.addEventListener(MessageEvent.MESSAGE_EVENT,onMessage);
			////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		}
		private function onUpdateTree(e:DataProxyEvent):void 
		{
			reset();
		}
		private function updateEnte(a:Array):void
		{
			a = (a == null) ? new Array() : a ;
			filterGenerici.listDataEnte = a;
			filterGenerici.ente.enabled	= (a.length>0);
		}
		private function updatePresidio(a:Array):void
		{
			a = (a == null) ? new Array() : a ;
			filterGenerici.listDataPresidio = a;
			filterGenerici.presidio.enabled	= (a.length>0);
		}
		private function updateFolder(a:Array):void
		{
			a = (a == null) ? new Array() : a ;
			filterGenerici.listDataTipoFolder = a;
			filterGenerici.folder.enabled	= (a.length>0);
		}
		private function updateErogazione(a:Array):void
		{
			a = (a == null) ? new Array() : a ;
			filterGenerici.listDataDisciplina 	= a;
			filterGenerici.erogazione.enabled	= (a.length>0);
		}
		
		private function onUpdateEnte(e:DataProxyEvent):void 
		{
			updateEnte(e.getData() as Array);
		}
		private function onUpdatePresidio(e:DataProxyEvent):void 
		{
			updatePresidio(e.getData() as Array);
		}
		private function onUpdateFolder(e:DataProxyEvent):void
		{
			updateFolder( e.getData() as Array);
		}
		private function onUpdateErogazione(e:DataProxyEvent):void
		{
			updateErogazione( e.getData() as Array );
		}
		
		private function reset():void
		{
			/* le Specificge non sono più valide perchè questo è un'altra lista */
			//ManagerFilters.getInstance().clearSpecification();
			for(var s:String in listFilter)
			{
				removeFilter( s );
			}
			checkSelectTab();
			
		}
		private function getDataSelect(index:int,select:Boolean):Object
		{
			return {index:index,select:select};
		}
		private function onReset(event:TurboEvent):void
		{
			reset();
		}
		private function onMessage(event:MessageEvent):void
		{
			filterGenerici.testoArea = event.getValue();
		}
		//============================================================================
		private function removeFilter( key:String ):void
		{
			ManagerFilters.getInstance().removeFilter( key );
			delete listBox[key];
			delete listFilter[key];
		}
		private function addFilter(key:String,filter:ISpecification,target:ResizableBoxFiltri):void
		{
			ManagerFilters.getInstance().addFilter( key, filter );
			listFilter[key] = filter;
			listBox[key]	= target;
		}
		private function hasFilter():Boolean
		{
			for(var s:Object in listFilter)
			{
				return true;
			}
			return false;
		}
		private function checkSelectTab():void
		{
			var hasFilter:Boolean 	= hasFilter();
			select 					= hasFilter;
			var m:FSEModel	= FSEModel.getInstance();
			m.retrieveProxy(ConstDataProxy.DATA_SELECT_BUTTON).update( getDataSelect(0,select) );
			if(hasFilter != oldHasFilter)
			{
				oldHasFilter 			= hasFilter;
				var typeEvent:String	= oldHasFilter ?  TurboEvent.FILTER_SELECT : TurboEvent.FILTER_DESELECT;
				filterGenerici.dispatchEvent( new TurboEvent( typeEvent ) ); 
			}
		}
		private function updateFilter(key:String,filter:ISpecification,target:ResizableBoxFiltri):void
		{
			removeFilter(key);
			addFilter(key,filter,target)
			checkSelectTab();
		} 
		//============================================================================
		private function onSelectItemsEnte(e:SelectItems):void
		{
			var target:ResizableBoxFiltri = e.target as ResizableBoxFiltri;
			var items:Array = e.items;
			if(items.length>0)
			{
				updateFilter( ManagerFilters.KEY_ENTE, new EnteSpecification( items ) , target);
			}else
			{
				removeFilter( ManagerFilters.KEY_ENTE );
				checkSelectTab();
			}
		}
		private function onSelectItemsErogazione(event:SelectItems):void
		{
			var target:ResizableBoxFiltri = event.target as ResizableBoxFiltri;
			var items:Array = event.items;
			if(items.length>0)
			{
				updateFilter( ManagerFilters.KEY_EROGAZIONE, new ErogazioneSpecification( items ) , target);
			}else
			{
				removeFilter( ManagerFilters.KEY_EROGAZIONE );
				checkSelectTab();
			}
		}
		private function onSelectItemsPresidio(event:SelectItems):void
		{
			var target:ResizableBoxFiltri = event.target as ResizableBoxFiltri;
			var items:Array = event.items;
			if(items.length>0)
			{
				updateFilter( ManagerFilters.KEY_PRESIDIO, new PresidioSpecification( items ), target );
			}else
			{
				removeFilter( ManagerFilters.KEY_PRESIDIO );
				checkSelectTab();
			}
		}
		private function onSelectItemsFolder(event:SelectItems):void
		{
			var target:ResizableBoxFiltri = event.target as ResizableBoxFiltri;
			var items:Array = event.items;
			if(items.length>0)
			{
				updateFilter( ManagerFilters.KEY_FOLDER, new FolderSpecification( items ) , target);
			}else
			{
				removeFilter( ManagerFilters.KEY_FOLDER );
				checkSelectTab();
			}
		}
	}
}