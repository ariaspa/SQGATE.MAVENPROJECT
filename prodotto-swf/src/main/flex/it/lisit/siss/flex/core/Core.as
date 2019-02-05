package it.lisit.siss.flex.core
{
	import it.lisit.siss.flex.sebwebsiss;
	import it.lisit.siss.flex.utility.debug.Debug;
	
	import mx.core.Application;
	use namespace sebwebsiss;
	public class Core
	{
		sebwebsiss static var _app:Application;
		private static var _initialized:Boolean	= false;
		public static function initialize(application:Application):void
		{
			if(!_initialized)
			{
				_initialized = true;
				_app = application;
			}
		}
		//
		public static function get message():MessageManager
		{
			return MessageManager.getInstance();
		}
		public static function get wait():ManagerWaitPopUp
		{
			return ManagerWaitPopUp.getInstance();
		}
		public static function get sound():ManagerSound
		{
			return ManagerSound.getInstance(); 
		}
		//////////////////////////////////////////////////
		private static var _log:DebugLog;
		public static function get log():DebugLog
		{
			if(_log==null)
			{
				_log = new DebugLog( );
			}
			return _log;
		}  				
	}
}
	import it.lisit.siss.flex.utility.debug.Debug;
	import it.lisit.siss.flex.utility.debug.DebugLevel;
	import it.lisit.siss.flex.utility.debug.IConsole;
	import it.lisit.siss.flex.core.Core;
	import it.lisit.siss.flex.sebwebsiss;
	import it.lisit.siss.flex.core.MessageManager;
	import it.lisit.siss.flex.core.ManagerWaitPopUp;
	import it.lisit.siss.flex.component.PanelDebug;
	
	import flash.events.KeyboardEvent;
	import mx.core.Application;
	
	use namespace sebwebsiss;
class DebugLog
{
	public const DEBUG:uint 	=  DebugLevel.DEBUG;
	public const ERROR:uint 	=  DebugLevel.ERROR;
	public const FATAL:uint 	=  DebugLevel.FATAL;
	public const INFO:uint 		=  DebugLevel.INFO;
	public const WARNING:uint 	=  DebugLevel.WARNING;
	/////////////////////////
	public const CONSOLE_DEFAULT:String = Debug.CONSOLE_DEFAULT;
	public const CONSOLE_PANEL:String 	= "__panel__debug__";	 
	public function set level(value:uint):void
	{
		Debug.level = value;
	}
	public function get level():uint
	{
		return Debug.level;
	} 	 
	private var _panelDeb:PanelDebug;
	private var _visiblePanel:Boolean
	public function get visiblePanel():Boolean
	{
		return _visiblePanel;
	}
	public function set visiblePanel(value:Boolean):void
	{
		_visiblePanel = value;
		if(_visiblePanel)
		{
			if( Core._app!=null && _panelDeb==null)
			{
				_panelDeb 			= new PanelDebug();
				_panelDeb.width		= 430;
				_panelDeb.height	= 400;
				addConsole(CONSOLE_PANEL,_panelDeb);
			 	Core._app.addChild( _panelDeb );
			 	Core._app.addEventListener(KeyboardEvent.KEY_DOWN,onKeyEvent);
			}
		}else{
			if( Core._app!=null && _panelDeb!=null)
			{
				removeConsole(CONSOLE_PANEL);
				Core._app.removeEventListener(KeyboardEvent.KEY_DOWN,onKeyEvent);
			 	Core._app.removeChild( _panelDeb );
			 	_panelDeb = null;
			}
			
		}
	}
	public function DebugLog( )
	{
		_visiblePanel = false;
	}
	private function onKeyEvent(event:KeyboardEvent):void
	{
		if(event.keyCode == 123)
		{
			_panelDeb.visible	=! _panelDeb.visible;
		}  
	}
	public function warning(message:Object):void
	{
		Debug.logWarning(message);
	}
	public function info(message:Object):void
	{
		Debug.logInfo(message);
	}
	public function fatal(message:Object):void
	{
		Debug.logFatal(message);
	}
	public function error(message:Object):void
	{
		Debug.logError(message);
	}
	public function debug(message:Object):void
	{
		Debug.logDebug(message);
	}
	public function getConsole(name:String):IConsole
	{
		return Debug.getConsole( name );
	}
	public function existConsole(name:String):Boolean
	{
		return Debug.existConsole(name);
	}
	public function removeConsole(name:String):Boolean
	{
		return Debug.removeConsole(name);
	}
	public function addConsole(name:String,console:IConsole):Boolean
	{
		return Debug.addConsole(name,console);
	}
}