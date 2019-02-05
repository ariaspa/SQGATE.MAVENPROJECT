package com.li.dc.sebc.turboFSE.util.window
{
	import com.li.dc.sebc.turboFSE.model.vo.DataAgregazione;
	
	import flash.utils.Dictionary;
	
	import it.lispa.siss.sebc.flex.collection.DictionaryIteratorKey;
	import it.lispa.siss.sebc.flex.collection.IIterator;
	import it.lispa.siss.sebc.flex.debug.Debug;
	
	public class GestWindows
	{
		
		private static var instance:GestWindows;
		public static function getInstance():GestWindows
		{
			if(instance == null)
			{
				instance = new GestWindows(new HideClass());
			}
			return instance;
		}
		private var mapWindow:Dictionary;
		public function GestWindows(hide:HideClass)
		{
			mapWindow = new Dictionary();
		}
		/**
		 *cancella e chiude tutte le finestre aperte 
		 * 
		 */		
		public function clearAll():void
		{
			var iter:IIterator = new DictionaryIteratorKey(mapWindow);
			while(iter.hasNext()) 
			{
				var s:Object = iter.next();
				var win:WindowReference = mapWindow[s] as WindowReference;
				if(win!=null)
				{
					closeAgregazione( win.getDataAgregazione() );
				}
			}
		}
		/**
		 * apre una popup corrispondente a questa agregazione nel caso non sia già aperta 
		 * @param data
		 * 
		 */		
		public function manageAgregazione(data:DataAgregazione):void
		{
			Debug.logWarning("GestWindows manageAgregazione ");
			if(data.isSelect)
			{
				openAgregazione(data);
			}else
			{
				closeAgregazione(data);
			}
		}
		private function openAgregazione(data:DataAgregazione):void
		{
			if(data.idWindow != null && !isOpenWindow(data.idWindow))
			{
				openWindow(data);
			}
		}
		private function closeAgregazione(data:DataAgregazione):void
		{
			if(data!=null && isOpenWindow(data.idWindow))
			{
				closeWindow(data);
			}
		}
		/**
		 * crea la referenza alla finestra    
		 * @param data
		 * 
		 */		
		private function openWindow(data:DataAgregazione):void
		{
			Debug.logDebug("GESTWINDOWS openWindow : " );
			
			var window:WindowReference 	= new WindowReference(data); 
			mapWindow[data.idWindow] 	= window;
			window.start();
		}
		private function closeWindow(data:DataAgregazione):void
		{
			Debug.logDebug("GESTWINDOWS closeWindow");
			if(data!=null)
			{
				var window:WindowReference = getReferenceFromData(data);
				if(window!=null)
				{
					mapWindow[data.idWindow] = null;
					delete mapWindow[data.idWindow];
					window.close();
				}
			}
		}
		public function getReference(idWindow:String):WindowReference
		{
			return mapWindow[idWindow];
		}
		public function getReferenceFromData(data:DataAgregazione):WindowReference
		{
			return getReference(data.idWindow);
		}
		 
		public function freezeAll(flag:Boolean):void
		{
			for(var s:Object in mapWindow)
			{
				freezeWindow(s,flag);
			}
		}
		public function freezeWindow(win:Object,flag:Boolean):void
		{
			var window:WindowReference = mapWindow[win] as WindowReference;
			if(window!=null)
			{
				window.freeze(flag);
			}
		}
		public function isOpenWindow(nameWindow:String):Boolean
		{
			return !(mapWindow[nameWindow] == null);
		}
		// verso la finestra
		private function focus(data:DataAgregazione):void
		{
			var window:WindowReference = getReference(data.idWindow);
			Debug.logDebug("GESTWINDOWS focus "+window);
			if(window!=null)
			{
				window.focusWindow( data );
			}
		}
		//////////////////////////////////////////////////////////
		public function changeFocus(data:DataAgregazione):void
		{
			if(data !=null)
			{
				Debug.logDebug("GESTWINDOWS changeFocus "+data.idWindow+" -focus-> "+data.inFocus);
				focus( data ); 
				Debug.logDebug("--------------------------------------------------------");
				if(data.inFocus)
				{
					var iter:IIterator = new DictionaryIteratorKey( mapWindow );
					while( iter.hasNext() ) 
					{
						var key:String = iter.next() as String;
						var window:WindowReference = getReference( key );
						if(window!=null)
						{
							window.getDataAgregazione().inFocus = false;
						}
					}	
				}
			} 
		}
	}
}
class HideClass{}