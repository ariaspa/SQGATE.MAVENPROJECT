package com.li.dc.sebc.turboFSE.view.mediator.mediatorView
{
	import com.li.dc.sebc.turboFSE.controller.ConstCommand;
	import com.li.dc.sebc.turboFSE.model.ConstDataProxy;
	import com.li.dc.sebc.turboFSE.model.FSEModel;
	import com.li.dc.sebc.turboFSE.view.mediator.ConstMediator;
	import com.li.dc.sebc.turboFSE.view.mediator.TurboView;
	import com.li.dc.sebc.turboFSE.view.nodeView.RootFascicolo;
	
	import it.lispa.siss.sebc.flex.mvc.controller.Controller;
	import it.lispa.siss.sebc.flex.mvc.model.proxy.DataProxyEvent;
	import it.lispa.siss.sebc.flex.mvc.view.Mediator;
	
	import mx.binding.utils.BindingUtils;

	public class RootFascicoloMediator extends Mediator
	{
		private var rootFascicolo:RootFascicolo;
		public function RootFascicoloMediator()
		{
			super();
		}
		override protected function finalize():void
		{}
		override protected function initialize( ):void
		{
			rootFascicolo = (this.view as RootFascicolo);
			initializeData();
			initializeView();	
		}
		private function initializeData():void
		{
			var model:FSEModel = FSEModel.getInstance();
			BindingUtils.bindProperty(rootFascicolo,"enabled",model,"enabledTabEventi",true);
			model.retrieveProxy(ConstDataProxy.DATA_TREE).addEventListener(DataProxyEvent.DATA_UPDATE,onUpdateDataTree);
		}
		private function onUpdateDataTree(e:DataProxyEvent):void		
		{
			Controller.getInstance().executeCommand( ConstCommand.UPDATE_FOLDER, e.getData() );
		}
		private function initializeView():void
		{
			TurboView.getInstance().createMediator(ConstMediator.HEADER_TOOGLE,ConstMediator.HEADER_TOOGLE,rootFascicolo.hToggle);
			TurboView.getInstance().createMediator(ConstMediator.BOX_TREE,ConstMediator.BOX_TREE,rootFascicolo.boxTree);
			TurboView.getInstance().createMediator(ConstMediator.BOX_VIEW,ConstMediator.BOX_VIEW,rootFascicolo.boxView);
		}
	}
}