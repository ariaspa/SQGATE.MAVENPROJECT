package com.li.dc.sebc.turboFSE.view.mediator.mediatorView
{
	import com.li.dc.sebc.turboFSE.model.ConstDataProxy;
	import com.li.dc.sebc.turboFSE.model.FSEModel;
	import com.li.dc.sebc.turboFSE.view.mediator.ConstMediator;
	import com.li.dc.sebc.turboFSE.view.mediator.TurboView;
	import com.li.dc.sebc.turboFSE.view.nodeView.Root;
	
	import it.lispa.siss.sebc.flex.debug.Debug;
	import it.lispa.siss.sebc.flex.mvc.model.proxy.DataProxyEvent;
	import it.lispa.siss.sebc.flex.mvc.view.Mediator;

	public class RootMediator extends Mediator
	{
		private var root:Root;
		public function RootMediator()
		{
			super();
			Debug.logDebug("instance RootMediator create");
		}
		override protected function finalize():void
		{
		}
		override protected function initialize():void
		{
			root = this.view as Root;
			initializeData();
			initializeView();
		}	
		private function initializeData():void
		{
			var model:FSEModel = FSEModel.getInstance();
			model.retrieveProxy(ConstDataProxy.STATE_STACK).addEventListener(DataProxyEvent.DATA_UPDATE,changeState);
			model.retrieveProxy(ConstDataProxy.DATA_MESSAGE).addEventListener(DataProxyEvent.DATA_UPDATE,changeMessage);
		}
		private function changeMessage(e:DataProxyEvent):void
		{
			root.message = e.getData() as String;
		}
		private function changeState(e:DataProxyEvent):void
		{
			root.currentState = e.getData() as String;
		}
		private function initializeView():void
		{
			var br:String = ConstMediator.BARRA_INTESTAZIONE;
			var al:String = ConstMediator.AREA_LAVORO;
			//TurboView.getInstance().createMediator(br,br,root.barraIntestazione);
			TurboView.getInstance().createMediator(al,al,root.areaLavoro);
		}
	}
}