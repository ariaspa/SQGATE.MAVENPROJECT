package com.li.dc.sebc.turboFSE.util.feedback
{
	import flash.display.Sprite;
	
	import mx.core.Application;
	import mx.core.IUIComponent;
	import mx.core.UIComponent;

	public class FeedbackManager
	{
		public static const IMPORTANCE_LOW:String 		= "low";
		public static const IMPORTANCE_MEDIUM:String	= "medium";
		public static const IMPORTANCE_HIGH:String 		= "high";
		/////////////////////////////////////////////////////////
		private static var instance:FeedbackManager;
		public static function getInstance():FeedbackManager
		{
			if(instance == null)
			{
				instance = new FeedbackManager(new HideClass());
			}
			return instance;
		}
		public function FeedbackManager(hide:HideClass)
		{
		}
		
		public function registerFeedback(name:String,feedback:AbstractFeedback):Boolean
		{
			return false;
		}
		public function getFeedback(name:String,target:IUIComponent):AbstractFeedback
		{
			var app:UIComponent = Application.application as UIComponent;
			switch(name)
			{
				case IMPORTANCE_LOW:
					 return new FeedbackLow(target,app);
				case IMPORTANCE_MEDIUM:
					return new FeedbackMedium(target,app );
				case IMPORTANCE_HIGH:
					return new FeedbackHigh(target,app);
			}
			return new AbstractFeedback(target,app);
		}
	}
}
class HideClass{}