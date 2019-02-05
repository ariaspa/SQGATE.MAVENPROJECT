package com.li.dc.sebc.turboFSE.view.mediator.mediatorView
{
	import com.li.dc.sebc.turboFSE.model.ConstDataProxy;
	import com.li.dc.sebc.turboFSE.model.FSEModel;
	import com.li.dc.sebc.turboFSE.view.component.Logo3DMXML;
	import com.li.dc.sebc.turboFSE.view.mediator.ConstMediator;
	import com.li.dc.sebc.turboFSE.view.mediator.TurboView;
	import com.li.dc.sebc.turboFSE.view.nodeView.AreaLavoro;
	
	import it.lispa.siss.sebc.flex.debug.Debug;
	import it.lispa.siss.sebc.flex.mvc.model.proxy.DataProxyEvent;
	import it.lispa.siss.sebc.flex.mvc.view.Mediator;
	
	import mx.binding.utils.BindingUtils;

	public class AreaLavoroMediator extends Mediator
	{
		private var area:AreaLavoro;
		public function AreaLavoroMediator()
		{
			super();
			Debug.logDebug("instance AreaLavoroMediator create");
			 
		}
		override protected function finalize():void
		{
		}
		override protected function initialize( ):void
		{
			area = (this.view as AreaLavoro);
			initializeData();
			initializeView();	 
		}
		private function initializeData( ):void
		{
			var model:FSEModel = FSEModel.getInstance();
			model.retrieveProxy(ConstDataProxy.STATE_AREA_LAVORO).addEventListener(DataProxyEvent.DATA_UPDATE,changeState);
			BindingUtils.bindProperty(model,"colorBckPopup",area,"bckValuePopUp",true);	
		}
		private function changeState(e:DataProxyEvent):void
		{
			var model:FSEModel = FSEModel.getInstance();
			area.currentState = e.getData() as String;
			/*switch(area.currentState)
			{
				case AreaLavoro.ACTIVE:
					model.retrieveProxy(ConstDataProxy.STATE_LOGO).update( Logo3DMXML.QUIET );
					break;
				case AreaLavoro.WAIT:
					model.retrieveProxy(ConstDataProxy.STATE_LOGO).update( Logo3DMXML.ACTIVITY );
					break;
			}*/
		}
		private function initializeView( ):void
		{
			var turboView:TurboView = TurboView.getInstance();
			turboView.createMediator(ConstMediator.AREA_TAB,ConstMediator.AREA_TAB,area.areaTab ); 
			turboView.createMediator(ConstMediator.AREA_WAIT,ConstMediator.AREA_WAIT,area.areaWait );
		}  
	}
}