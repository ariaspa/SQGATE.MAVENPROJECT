package com.li.dc.sebc.turboFSE.util.window
{
	import com.li.dc.sebc.turboFSE.model.vo.PopupConfig;
	import com.li.dc.sebc.turboFSE.util.JSManager;
	
	import it.lispa.siss.sebc.flex.debug.Debug;
	
	public class JSWindow
	{
		private const PERCENT_WINDOW:uint = 60;
		private var name:String; 
		private var _isCreate:Boolean; 
		public function get isCreate():Boolean{return _isCreate;}
		public function JSWindow(pop:PopupConfig,name:String)
		{
			Debug.logDebug("JSWindow start name : " +name);
			if( pop!=null  && name!=null)
			{
				var urlContainer:String = pop.urlHtmlContainer;
				var module:String		= "visualizer="+pop.urlModuloVisualizer+"&comunicator="+pop.urlModuloComunicator+"&collect="+pop.urlModuloCollector;
				var url:String			= urlContainer+"?"+module;
				this.name				= name;
				var layout:Object		= getLayout();
				_isCreate = JSManager.getInstance().createWindow(url,name,layout.x,layout.y,layout.w,layout.h);
			}
		}
		private function getLayout():Object
		{
			var layout:Object	= new Object();
			var screen:Object	= JSManager.getInstance().getDimensionScreen();
			layout.w			= screen.width/100*PERCENT_WINDOW;
			layout.h			= screen.height/100*PERCENT_WINDOW;
			layout.x			= screen.width	- layout.w;
			layout.y			= screen.height	- layout.h;
			return layout;
		}
		public function close():void
		{
			//JSManager.getInstance().closeWindow(name);
			//clearReference();
		}
		public function clearReference():void
		{
			//JSManager.getInstance().clearReference(name);
		}
		public function focusWindow(flag:Boolean):void
		{
			//if(ExternalInterface.available)
			//{
			//	 ExternalInterface.call("focusWindow",name,flag);
			//}
		}
		public function resizeWindow(w:Number , h:Number):void
		{
			//if(ExternalInterface.available)
			//{
			//	 ExternalInterface.call("resizeWindow",name,w,h);
			//}
		}
		public function moveWindow(x:Number , y:Number):void
		{
			//if(ExternalInterface.available)
			//{
			//	 ExternalInterface.call("moveWindow",name,x,y);
			//}
		}
	}
}