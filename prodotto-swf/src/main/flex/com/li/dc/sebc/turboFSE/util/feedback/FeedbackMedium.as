package com.li.dc.sebc.turboFSE.util.feedback
{
	import mx.core.IUIComponent;
	import mx.core.UIComponent;
	
	internal class FeedbackMedium extends AbstractFeedback
	{
		public function FeedbackMedium(target:IUIComponent,layer:UIComponent)
		{
			super(target,layer);
		}
		override protected function getColor():int{return 0xEEFFFF;}
		 
	}
}