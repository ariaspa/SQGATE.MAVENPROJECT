package com.li.dc.sebc.turboFSE.view.mediator.mediatorView
{
	import com.li.dc.sebc.turboFSE.events.TurboEvent;
	import com.li.dc.sebc.turboFSE.model.ConstDataProxy;
	import com.li.dc.sebc.turboFSE.model.FSEModel;
	import com.li.dc.sebc.turboFSE.model.filters.DateSpecification;
	import com.li.dc.sebc.turboFSE.model.filters.ManagerFilters;
	import com.li.dc.sebc.turboFSE.util.UtilDate;
	import com.li.dc.sebc.turboFSE.view.component.CanvasFiltriData;
	
	import it.lispa.siss.sebc.flex.mvc.view.Mediator;
	import it.lispa.siss.sebc.flex.specification.ISpecification;
	
	import mx.controls.DateField;

	public class FiltriDataMediator extends Mediator
	{
		private var filterData:CanvasFiltriData; 
		 
		public function FiltriDataMediator()
		{
			super();
		}
		override protected function finalize():void
		{
		}
		override protected function initialize( ):void
		{
			filterData = (this.view as CanvasFiltriData);
			initializeData();
			initializeView();	
		}
		private function initializeData():void
		{
		
		}
		private function initializeView():void
		{
			filterData.styleName	=	"wFiltri";
			filterData.addEventListener(TurboEvent.FILTER_SELECT,onSelectDateFilter);
			filterData.addEventListener(TurboEvent.FILTER_DESELECT,onDeselectDateFilter);
			setFromDateFiled();
			setToDateFiled();			
		}
		private function onSelectDateFilter(e:TurboEvent):void
		{
			deselectSpecification();
			var toFiled:DateField 				= filterData.toDateFiled;
			var from:DateField 					= filterData.fromDateFiled;
			var specification:ISpecification	= new DateSpecification(from.selectedDate,toFiled.selectedDate);
			
			var m:FSEModel						= FSEModel.getInstance();
			m.retrieveProxy(ConstDataProxy.DATA_SELECT_BUTTON).update( {index:1,select:true} );
			
			ManagerFilters.getInstance().addFilter( ManagerFilters.KEY_DATE,specification);
		}
		private function onDeselectDateFilter(e:TurboEvent):void
		{
			var m:FSEModel						= FSEModel.getInstance();
			m.retrieveProxy(ConstDataProxy.DATA_SELECT_BUTTON).update( {index:1,select:false} );
			deselectSpecification();
		}
		private function deselectSpecification():void
		{
			ManagerFilters.getInstance().removeFilter( ManagerFilters.KEY_DATE );
		}
		private function setToDateFiled():void
		{
			var toFiled:DateField 	= filterData.toDateFiled;
			toFiled.monthNames		= UtilDate.MESI; 
			toFiled.dayNames		= UtilDate.GIORNI;
			toFiled.formatString	= UtilDate.FORMATTER_STRING; 
			toFiled.yearNavigationEnabled = true;
		}
		private function setFromDateFiled():void
		{
			var from:DateField 	= filterData.fromDateFiled;
			from.monthNames 	= UtilDate.MESI;
			from.formatString	= UtilDate.FORMATTER_STRING;
			from.dayNames		= UtilDate.GIORNI;
			from.minYear		= 1900; 
			from.yearNavigationEnabled = true;				
		}
	}
}