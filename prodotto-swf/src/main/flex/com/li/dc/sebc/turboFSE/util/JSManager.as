package com.li.dc.sebc.turboFSE.util
{
	import com.li.dc.sebc.turboFSE.util.window.GestWindows;
	
	import flash.external.ExternalInterface;
	
	import it.lisit.siss.flex.js.JavaScript;
	import it.lispa.siss.sebc.flex.debug.Debug;
	
	public class JSManager
	{
		private const PERCENT_WINDOW:uint = 60;
		private static var instance:JSManager;
		public static function getInstance():JSManager
		{
			if(instance == null)
			{
				instance = new JSManager( new HideClass() );
			}
			return instance;
		}
		private var _pedranziniAperto:Boolean = false;
		private var _gadoAperto:Boolean = false;
		private var _pedranziniCallbackAdded:Boolean = false;
		private var _gadoCallbackAdded:Boolean = false;
		private var _gadoCallback:Function;
		public function get pedranziniAperto():Boolean{return _pedranziniAperto;}
		
		public function JSManager(hide:HideClass){
			initJavaScript();
		}
		private function initJavaScript():void
		{
			 // scrivo i js iniziali che mi sono necessari
			 var js:JavaScript 	= new JavaScript();
			 js.script			= iniJs.children()[0].toString();
		}
		public function openPedranzini(url:String):void
		{
			Debug.logDebug( "openPedranzini url ::: "+url);
			if(ExternalInterface.available)
			{
				if(!_pedranziniCallbackAdded)
				{
					_pedranziniCallbackAdded = true;
					ExternalInterface.addCallback("closePedranzini",pedranziniChiuso);
				}
				 ExternalInterface.call("apriPedranzini",url,ExternalInterface.objectID);
				 _pedranziniAperto = true;
				 GestWindows.getInstance().freezeAll(true);
				 ViewMessageManager.getInstance().freezeApplication(true,"Attendere... Apertura vista esterna");
			}		
		}
		 
		private function pedranziniChiuso():void
		{
			Debug.logDebug( "pedranziniChiuso ");
			_pedranziniAperto = false;
			GestWindows.getInstance().freezeAll(false);
			ViewMessageManager.getInstance().freezeApplication(false);	 
		}
		 
		public function getUrlParams():String
		{
			if(ExternalInterface.available)
			{
				return ExternalInterface.call("getUrlParams");
			}
			return "";
		}
		// ok
		public function creaNuovaFinestraGado(newUrl:String,unloadGado:Function):void
		{
			 if(ExternalInterface.available && !_gadoAperto)
			 {
			 	_gadoAperto = true;
			 	ExternalInterface.addCallback("closePopup", gadoChiuso);
			 	
			 	_gadoCallback = unloadGado;
			 	var name:String 	= "FinestraVisibilità";
			 	ExternalInterface.call("creaGadoFinestra",ExternalInterface.objectID,newUrl,name);
			 	GestWindows.getInstance().freezeAll(true);
				ViewMessageManager.getInstance().freezeApplication(true,"Attendere... Apertura applicazione esterna");
			 }
		}
		private function gadoChiuso(tabAbilitazione:Object, tabOscuraDeoscura:Object):void
		{
			Debug.logDebug("GADOCHIUSO GADOCHIUSO GADOCHIUSO GADOCHIUSO GADOCHIUSO GADOCHIUSO GADOCHIUSO GADOCHIUSO");
			_gadoAperto = false;
			_gadoCallback(tabAbilitazione,tabOscuraDeoscura);
			GestWindows.getInstance().freezeAll(false);
			ViewMessageManager.getInstance().freezeApplication(false);	 
		}
		//ok
		public function createWindow(url:String,name:String,x:Number,y:Number,w:Number,h:Number):Boolean
		{
			Debug.logDebug("createWindow url : "+url+", name : "+name+", ExternalInterface.available : "+ExternalInterface.available);
			 if(ExternalInterface.available)
			 {
			 	return ExternalInterface.call("creaNuovaFinestra",url,name,x,y,w,h);
			 }
			 return false;
		}
		// ok
		public  function closeWindow(name:String):void
		{
			if(ExternalInterface.available)
			{
				ExternalInterface.call("closeWindow",name);
			}
		}
		public  function clearReference(name:String):void
		{
			if(ExternalInterface.available)
			{
				ExternalInterface.call("clearReference",name);
			}
		}
		public  function getDimensionScreen():Object 
		{
			if(ExternalInterface.available)
			{
				var screen:String 	= ExternalInterface.call("getScreen");
				var spl:Array		= screen.split(":");
				var w:Number		= Number(spl[0]);
				var h:Number		= Number(spl[1]);
				return {width:w,height:h};
			}
			return null;
		}
		
		public function getLayout():Object
		{
			var layout:Object	= new Object();
			var screen:Object	= getDimensionScreen();
			layout.w			= screen.width/100*PERCENT_WINDOW;
			layout.h			= screen.height/100*PERCENT_WINDOW;
			layout.x			= screen.width	- layout.w;
			layout.y			= screen.height	- layout.h;
			return layout;
		}
		/////////////////////////////////////////
		//////////////JAVA SCRIPT///////////////
		/////////////////////////////////////////
		private static var iniJs:XML = <root>
			<![CDATA[
				var idFlash;
				var windowGado;
				var finestraPedranzini;
				var flagGado = 0;
				// legge i parametri della url 
				
				getUrlParams = function()
				{
					return window.location.search;
				}
				
				getScreen = function()
				{
					// NS 4+, IE 5+
					var w = window.screen.width;
					var h = window.screen.height;
					return w+":"+h;
				}
				
				creaNuovaFinestra = function (url,nameWindow,x,y,w,h)
				{
					var win = internalCreaNuovaFinestra(url,nameWindow,x,y,w,h);
					if(win!=null && win!=undefined)
					{
						return true;	
					}
					return false;
				}
				
				creaGadoFinestra = function(objFlash,url,nameWindow)
				{
					idFlash 	= objFlash;
					var w = window.screen.width - 50;
					var h = window.screen.height - 50;
					var x = 50; 
					var y = 50;	
					windowGado	= internalCreaNuovaFinestra(url,nameWindow,x,y,w,h);
					if(windowGado!=null && windowGado!=undefined)
					{
						flagGado 	= 1;
						return true;	
					}
					return false;
				}
				
				internalCreaNuovaFinestra = function (url,nameWindow,x,y,w,h)
				{ 
					try{
						var dimension 		= getDimensionString(w,h);	
						var position 		= getPositionString(x,y);	
						var attribute 		= getAttributeString();
						return  			window.open(url,nameWindow,dimension +','+ position +','+ attribute);
					}catch(e)
					{}
					return null;
				}
				
				getDimensionString = function (w,h)
				{
					return 'width='+w+',height='+h;
				}
				
				getPositionString = function(x,y)
				{
					return 'left='+x+',top='+y+',screenX='+x+',screenY='+y;
				}
				
				getAttributeString = function()
				{
					return 'resizable=yes,scrollbars=yes,toolbar=no,location=no,directories=no,status=no,menubar=no,copyhistory=no';
				}
				
				///////////////////////////////////////////////////////
				thisMovie = function (movieName) 
				{
			         if (navigator.appName.indexOf("Microsoft") != -1) {
			             return window[movieName];
			         } else {
			             return document[movieName];
			         }
		     	}
		     	 
				
				clearReference = function(name){}
				
				closeWindow = function(name){}
				
				//
				apriPedranzini = function (url , idObjectflash)
				{
					try{
						idFlash = idObjectflash;
						var w = window.screen.width - 50;
						var h = window.screen.height - 50;
						var x = 50; 
						var y = 50;	
						finestraPedranzini = window.open(url,"temporale", 'width=' + w + ',height=' + h + ',' + 'left=' + x + ',top=' + y + ',screenX=' + x + ',screenY=' + y +',resizable=yes,scrollbars=yes');
						flagGado 	= 2;
					}catch(error)
					{}
				}
				
				onUnloadPedra = function()
				{
					if(flagGado == 1)
					{
						var tabAbilitazione; 
						var tabOscuraDeoscura;
						var dErr = null;
						var gado;
						var st;
						try{
							gado 					= windowGado.frames['iframe_frame0'];
						}catch(error)
						{
							st = "error 1";
							dErr = error;
						}
						try{
							if(gado!=null){
								tabAbilitazione		= gado.tabAbilitazione == null ? "" :  gado.tabAbilitazione;
								tabOscuraDeoscura	= gado.tabOscuraDeoscura == null ? "" : gado.tabOscuraDeoscura;
							}else
							{
								throw new Error("gado = null");
							}
						}catch(error)
						{
							st = "error 2";
							dErr = error;
						}
						try{
							var flash = thisMovie(idFlash);
							flash.closePopup(tabAbilitazione, tabOscuraDeoscura);
						}catch(error)
						{
							st = "error 3";
							dErr = error;	
						}
						if(dErr!=null)
						{
							 
						}
					}else if(flagGado == 2)
					{
						 
						thisMovie(idFlash).closePedranzini();
					}
				}
				getMessage = function(st,dErr)
				{
					var res = "";
					for(var s in dErr)
					{
						res += s + " = "+dErr[s]+"\n";
					}
					return st + " - "+res;
				} 
			]]>
		</root>
		/////////////////////////////////////////
		/////////////////////////////////////////
		/////////////////////////////////////////
	}
}
class HideClass{}
