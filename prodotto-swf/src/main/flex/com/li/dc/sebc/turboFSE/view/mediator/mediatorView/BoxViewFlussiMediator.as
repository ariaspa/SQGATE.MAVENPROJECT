package com.li.dc.sebc.turboFSE.view.mediator.mediatorView
{
	import com.li.dc.sebc.turboFSE.controller.ConstCommand;
	import com.li.dc.sebc.turboFSE.model.ConstDataProxy;
	import com.li.dc.sebc.turboFSE.model.FSEModel;
	import com.li.dc.sebc.turboFSE.util.UtilColor;
	import com.li.dc.sebc.turboFSE.view.builders.DirectorViste;
	import com.li.dc.sebc.turboFSE.view.nodeView.BoxView;
	
	import flash.events.Event;
	
	import it.lispa.siss.sebc.flex.mvc.controller.Controller;
	import it.lispa.siss.sebc.flex.mvc.model.proxy.DataProxyEvent;
	import it.lispa.siss.sebc.flex.mvc.view.Mediator;

	public class BoxViewFlussiMediator extends Mediator
	{
		private var box:BoxView;
		public function BoxViewFlussiMediator()
		{
			super();
		}
		override protected function finalize():void
		{
		}
		override protected function initialize( ):void
		{
			box = (this.view as BoxView);
			initializeData();
			initializeView();	 
		}
		private function initializeData():void
		{
			var model:FSEModel = FSEModel.getInstance();
		 	model.retrieveProxy(ConstDataProxy.DATA_FLUSSI_SELECT).addEventListener(DataProxyEvent.DATA_UPDATE,onUpdateFolderSelect);
		}
		
		private function initializeView():void
		{
			box.addEventListener("changeSelectButton",onChangeSelectButton);
		}
		private function onChangeSelectButton(e:Event):void
		{
			e.stopPropagation();
			var select:Boolean 		= box.selectButton;
			var param:Object		= {select:select,who:box};
			Controller.getInstance().executeCommand(ConstCommand.EXPAND_VIEW,param);
		}
		private function onUpdateFolderSelect(e:DataProxyEvent):void
		{
			var model:FSEModel 		= FSEModel.getInstance();
			var dt:Object			= e.getData();
			var isNull:Boolean		= (dt==null);
			/*Update della label del titolo*/
			box.labelTitle 			= isNull ? "" : dt.label;
			/*Update del colore*/
			box.colorBackground		= isNull ? 0xFFFFFF : UtilColor.getColorBCK( dt );
			/*Creo la vista */
			box.currentVista		= isNull ? null : DirectorViste.getInstance().createVista( dt );
		}
	}
}