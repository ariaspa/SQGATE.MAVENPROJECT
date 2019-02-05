package com.li.dc.sebc.turboFSE.view.mediator.mediatorView
{
	import com.li.dc.sebc.turboFSE.model.ConstDataProxy;
	import com.li.dc.sebc.turboFSE.model.FSEModel;
	import com.li.dc.sebc.turboFSE.view.nodeView.VisualizzaCittadino;
	
	import it.lispa.siss.sebc.flex.mvc.model.proxy.DataProxyEvent;
	import it.lispa.siss.sebc.flex.mvc.view.Mediator;
	import it.lispa.siss.sebc.middleground.entity.Cittadino;

	public class VisualizzaCittadinoMediator extends Mediator
	{
		private var visualizza:VisualizzaCittadino;
		public function VisualizzaCittadinoMediator()
		{
			super();
		}
		override protected function finalize():void
		{
		}
		override protected function initialize( ):void
		{
			visualizza = (this.view as VisualizzaCittadino);
			initializeData();
			initializeView();	 
		}
		private function initializeData():void
		{
			FSEModel.getInstance().retrieveProxy(ConstDataProxy.DATA_CITTADINO).addEventListener(DataProxyEvent.DATA_UPDATE,onUpdateCittadino);
		}
		private function onUpdateCittadino(e:DataProxyEvent):void
		{
			visualizza.cittadino = e.getData() as Cittadino;
		}
		private function initializeView():void
		{
		
		}
	}
}