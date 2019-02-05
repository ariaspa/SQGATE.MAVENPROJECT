package com.li.dc.sebc.turboFSE.util
{
	import com.li.dc.sebc.turboFSE.model.FSEModel;
	
	import flash.events.KeyboardEvent;
	
	import it.lispa.siss.sebc.flex.collection.ArrayIterator;
	import it.lispa.siss.sebc.flex.collection.IIterator;
	import it.lispa.siss.sebc.flex.debug.Debug;
	import it.lispa.siss.sebc.flex.smartCard.ISmartCardListener;
	import it.lispa.siss.sebc.flex.smartCard.ISmartCardObserver;
	
	import mx.collections.ArrayCollection;
	import mx.core.Application;

	public class LocalSmartCardReader implements ISmartCardListener
	{
		private var _listObserver:ArrayCollection;
		private var _enable:Boolean;
		public function LocalSmartCardReader()
		{
			_listObserver = new ArrayCollection();
			_enable = false;
			var app:Application = FSEModel.getInstance().turboApp;
			app.stage.addEventListener(KeyboardEvent.KEY_DOWN,onMyKeyDown);
			Debug.logDebug( "LocalSmartCardReader  instance (app==null) : "+(app==null));
		}
		private function onMyKeyDown(e:KeyboardEvent):void
		{
			Debug.logDebug( "LocalSmartCardReader onMyKeyDown e.charCode : "+e.charCode);
			Debug.logDebug( "LocalSmartCardReader enable : "+enable);
			if(enable)
			{
				switch(e.charCode)
				{
					case 49:
						insertOperatore();
						break;
					case 50:
						rejectOperatore();
						break;
					case 51:
						insertCittadino();
						break;
					case 52:
						rejectCittadino();
						break;
				}
			}
		}
		private function insertOperatore():void
		{
			Debug.logDebug( "LocalSmartCardReader insertOperatore ");
			var ite:IIterator = new ArrayIterator(_listObserver.toArray() );
			while(ite.hasNext()) 
			{
				(ite.next() as ISmartCardObserver).smartCardOperatoreReading();
			}
		} 
		private function rejectOperatore():void
		{
			Debug.logDebug( "LocalSmartCardReader rejectOperatore ");
			var ite:IIterator = new ArrayIterator(_listObserver.toArray() );
			while(ite.hasNext()) 
			{
				(ite.next() as ISmartCardObserver).smartCardOperatoreEject()
			}
		} 
		private function insertCittadino():void
		{
			Debug.logDebug( "LocalSmartCardReader insertCittadino ");
			var ite:IIterator = new ArrayIterator(_listObserver.toArray() );
			while(ite.hasNext()) 
			{
				(ite.next() as ISmartCardObserver).smartCardCittadinoReading()
			}
		} 
		private function rejectCittadino():void
		{
			Debug.logDebug( "LocalSmartCardReader rejectCittadino ");
			var ite:IIterator = new ArrayIterator(_listObserver.toArray() );
			while(ite.hasNext()) 
			{
				(ite.next() as ISmartCardObserver).smartCardCittadinoEject()
			}
		} 
		public function set enable(value:Boolean):void
		{
			_enable = value;
		}
		
		public function get enable():Boolean
		{
			return _enable;
		}
		
		public function addObserver(observer:ISmartCardObserver):Boolean
		{
			if(!_listObserver.contains( observer ) )
			{
				_listObserver.addItem( observer );
				return true;
			}
			return false;
		}
		
		public function removeObserver(observer:ISmartCardObserver):Boolean
		{
			if(_listObserver.contains( observer ) )
			{
				_listObserver.removeItemAt( _listObserver.getItemIndex( observer ) );
				return true;
			}
			return false;
		}
		
	}
}