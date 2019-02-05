package com.li.dc.sebc.turboFSE.view.builders
{
	import com.li.dc.sebc.turboFSE.model.FSEModel;
	import com.li.dc.sebc.turboFSE.model.vo.DataAgregazione;
	import com.li.dc.sebc.turboFSE.view.viste.Vista;
	
	import it.lispa.siss.sebc.flex.debug.Debug;
	import it.lispa.siss.sebc.flex.mvc.view.Mediator;
	
	public class Builder
	{
		protected var currentData:Object;
		 
		public function Builder()
		{
		}
		public function setParam(obj:Object):void
		{
			currentData = obj;
		}
		protected final function putValue(key:*,v:*):void
		{
			FSEModel.getInstance().hashViste.put( key , v );
		}
		protected final function putAgregazione(key:String,a:DataAgregazione):void
		{
			putValue(key , a );
		}
		protected final function putMediator(key:Vista,m:Mediator):void
		{
			putValue(key , m );
		} 
		
		protected final function putVista(key:*,v:Vista):void
		{
			putValue(key , v );
		} 
		protected final function getValue(key:*):Object 
		{
			return FSEModel.getInstance().hashViste.getValue( key );
		}
		protected final function containsKey(key:*):Boolean
		{
			return FSEModel.getInstance().hashViste.containsKey(key);
		}
		public final function createVista( ):Vista
		{
			Debug.logInfo("I am ::: "+this );
			/* mi crea una chiave per questa vista */
			var key:Object	= getKey( );
			if(key==null)return null;
			var v:Vista	= null;
			try{
				if(containsKey(key))
				{
					/* con questa chiave ho già una vista */
					v  = getValue(key) as Vista;
				}
				if( v == null )
				{
					v = getVista();
					putVista(key , v);
					v.dataVista	= transformData( currentData );
				}
			}catch(e:Error)
			{
				Debug.logError("error : "+e.getStackTrace() );
			}
			Debug.logInfo("And my vista is ::: "+v );
			createMediator( v );
			return v;
		}
		
		protected function createMediator( v:Vista ):void
		{
			
		}
		/**
		 * 
		 * @return 
		 * 
		 */		
		protected function getKey():Object
		{
			return currentData;
		}
		/**
		 * Trasforma il dato da un tipo ad un'altro adatto alla vista
		 * @param obj
		 * @return 
		 * 
		 */		
		protected function transformData(obj:Object):Object{return obj;}
		/**
		 * restituisce la vista cortretta
		 * @return 
		 * 
		 */		
		protected function getVista():Vista
		{
			return new Vista();
		}
	}
}