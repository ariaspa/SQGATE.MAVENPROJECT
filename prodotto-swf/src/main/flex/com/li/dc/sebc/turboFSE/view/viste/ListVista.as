package com.li.dc.sebc.turboFSE.view.viste
{
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	
	import it.lispa.siss.sebc.flex.collection.ArrayIterator;
	import it.lispa.siss.sebc.flex.collection.IIterator;
	
	import mx.controls.Button;
	
	public class ListVista extends Vista
	{
		private var map:Dictionary;
		private var oldBtn:Button;
		private var fatto:Boolean;
		public function ListVista()
		{
			super();
			fatto	= false;
			map = new Dictionary();
		}
		override protected function updateData():void
		{
			if(!fatto){
				fatto = true;
				//{dataBody:temp,label:label,tooltip:toolTip};
				var iter:IIterator	= new ArrayIterator( getList() );
				while( iter.hasNext() )
				{
					var next:Object 	= iter.next();
					var btn:Button		= getButton( next ); 
					btn.toggle			= true;
					var v:Vista			= getBoxVista( next );
					map[btn] 			= v;
					btn.addEventListener(MouseEvent.CLICK,onClick);
					this.addChild( btn );
					this.addChild( v );
				}
			}
		}
		private function onClick(e:MouseEvent):void
		{
			var target:Button 		= e.target as Button;
			var selected:Boolean	= target.selected;
			var curBox:OpenableBox 	= map[target] as OpenableBox;
			if(selected)
			{
				openVista( curBox );
			}else
			{
				closeVista( curBox );
			}
			if(target != oldBtn && oldBtn!=null)
			{
				var oldBox:OpenableBox 	= map[oldBtn] as OpenableBox;
				oldBtn.selected			= false;
				closeVista( oldBox );
			}
			oldBtn = target;
		}
		protected function closeVista(v:Vista):void
		{
			 
		}
		protected function openVista(v:Vista):void
		{
			 
		}
		protected function getList( ):Array
		{
			return new Array();
		}
		protected function getBoxVista(obj:Object):OpenableBox
		{
			return new OpenableBox();
		}
		protected function getButton(obj:Object):Button
		{
			return new Button();
		}
	}
}