package com.li.dc.sebc.turboFSE.view.mediator.mediatorView
{
	import com.li.dc.sebc.turboFSE.controller.ConstCommand;
	import com.li.dc.sebc.turboFSE.model.ConstDataProxy;
	import com.li.dc.sebc.turboFSE.model.FSEModel;
	import com.li.dc.sebc.turboFSE.view.mediator.ConstMediator;
	import com.li.dc.sebc.turboFSE.view.mediator.TurboView;
	import com.li.dc.sebc.turboFSE.view.nodeView.RootFlussi;
	
	import it.lispa.siss.sebc.flex.debug.Debug;
	import it.lispa.siss.sebc.flex.mvc.controller.Controller;
	import it.lispa.siss.sebc.flex.mvc.model.proxy.DataProxyEvent;
	import it.lispa.siss.sebc.flex.mvc.view.Mediator;
	
	import mx.binding.utils.BindingUtils;

	public class RootFlussiMediator extends Mediator
	{
		private var flussi:RootFlussi;
		public function RootFlussiMediator()
		{
			super();
			Debug.logDebug("instance RootFlussiMediator create");
		}
		override protected function finalize():void
		{
		}
		override protected function initialize( ):void
		{
			flussi = (this.view as RootFlussi);
			initializeData();
			initializeView();	 
		}
		private function initializeData():void
		{
			var model:FSEModel = FSEModel.getInstance();
			BindingUtils.bindProperty(flussi,"enabled", model,"enabledTabEventi",true);
			FSEModel.getInstance().retrieveProxy(ConstDataProxy.DATA_TREE_FLUSSI).addEventListener(DataProxyEvent.DATA_UPDATE,onTreeFlussi);
		}
		private function onTreeFlussi(e:DataProxyEvent):void
		{
			Controller.getInstance().executeCommand(ConstCommand.UPDATE_FLUSSI, e.getData() );
		}
		private function initializeView():void
		{
			TurboView.getInstance().createMediator(ConstMediator.HEADER_TOOGLE_FLUSSI,ConstMediator.HEADER_TOOGLE_FLUSSI,flussi.hToggleFlussi);
			TurboView.getInstance().createMediator(ConstMediator.BOX_TREE_FLUSSI,ConstMediator.BOX_TREE_FLUSSI,flussi.boxTreeFlussi);
			TurboView.getInstance().createMediator(ConstMediator.BOX_VIEW_FLUSSI,ConstMediator.BOX_VIEW_FLUSSI,flussi.boxViewFlussi);
		}
	}
}