package com.li.dc.sebc.turboFSE.view.mediator.mediatorView
{
	import com.li.dc.sebc.turboFSE.model.ConstDataProxy;
	import com.li.dc.sebc.turboFSE.model.FSEModel;
	import com.li.dc.sebc.turboFSE.util.ViewMessageManager;
	
	import it.lispa.siss.library.ui.menustandard.Footer;
	import it.lispa.siss.sebc.flex.messages.IEnvelopeMessage;
	import it.lispa.siss.sebc.flex.messages.IUserMessage;
	import it.lispa.siss.sebc.flex.mvc.model.proxy.DataProxyEvent;
	import it.lispa.siss.sebc.flex.mvc.view.Mediator;

	public class FooterMediator extends Mediator implements IUserMessage
	{
		private var footer:Footer;
		private var currEnvelope:IEnvelopeMessage = null;
		public function FooterMediator()
		{
			super();
		}
		override protected function finalize():void
		{
		}
		override protected function initialize( ):void
		{
			footer = (this.view as Footer);
			initializeData();
			initializeView();	 
		}
		private function initializeData():void
		{
			var model:FSEModel = FSEModel.getInstance();
			model.retrieveProxy(ConstDataProxy.DATA_AREATAB).addEventListener(DataProxyEvent.DATA_UPDATE,onUpdateTabIndex);
		}
		public function analyze(title:String, type:String ):Boolean
		{
			return true;
		}
		public function useMessage( envelope:IEnvelopeMessage ):void
		{
			currEnvelope = envelope;
			ViewMessageManager.getInstance().afterCloseDisplayer(afterClose);
			ViewMessageManager.getInstance().showDisplayer( currEnvelope.getMessage() );
		}
		private function afterClose():void
		{
			currEnvelope.stopPropagation();
			currEnvelope.completedUse();
			currEnvelope = null;
			ViewMessageManager.getInstance().afterCloseDisplayer(null);
		}
		private function onUpdateTabIndex(e:DataProxyEvent):void
		{
			footer.resetSemaforo();
			//footer.clearStatusBar();
		}
		private function initializeView():void
		{
			//footer
			/* footer.automaticClickStatusBar 	= true;
			footer.changeIconAfterClick		= false;
			footer.activeBlinkStatusBar		= false;
			footer.soundActiveStatusBar		= true;
			footer.styleName				= "borderStyle" 
			footer.maxBlinkStatusBar		= 5; */
		}
	}
}
















