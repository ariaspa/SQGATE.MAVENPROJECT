package com.li.dc.sebc.turboFSE.view.mediator.mediatorView
{
	import com.li.dc.sebc.turboFSE.model.FSEModel;
	import com.li.dc.sebc.turboFSE.view.nodeView.RootTimeLineHtml;
	
	import it.lisit.siss.flex.utility.Later;
	import it.lispa.siss.sebc.flex.mvc.view.Mediator;
	import it.lispa.siss.sebc.sebwebsiss;
	
	import mx.binding.utils.BindingUtils;
	
	use namespace sebwebsiss;
	public class RootTimeLineHtmlMediator extends Mediator
	{
		private var rootTimelineHtml:RootTimeLineHtml;
		//
		public function RootTimeLineHtmlMediator()
		{
			super();
		}
		override protected function initialize( ):void
		{
			rootTimelineHtml = (this.view as RootTimeLineHtml);
			Later.doLater(	init );
		}
		
		private function init():void
		{
			initializeData();
		}
		
		private function initializeData():void
		{
			var model:FSEModel 	= FSEModel.getInstance();
			BindingUtils.bindProperty(rootTimelineHtml,"enabled",model,"enabledTabFascicolo",true);
		}
	}
}