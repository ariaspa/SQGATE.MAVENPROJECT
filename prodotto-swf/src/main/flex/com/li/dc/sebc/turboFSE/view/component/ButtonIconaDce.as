package com.li.dc.sebc.turboFSE.view.component
{
	import com.li.dc.sebc.turboFSE.model.vo.DataAgregazione;
	
	import flash.events.MouseEvent;
	
	import mx.controls.Button;

	public class ButtonIconaDce extends Button
	{
		public function set statoButton(value:String):void
		{
			_stato = value;
		}
		public function get statoButton():String
		{
			return _stato;
		} 
		private var _stato:String;
		private var _iconDce:Class;
		public function get dceIcon():Class{return _iconDce;}
		public function set dceIcon(value:Class):void
		{
			_iconDce = value;
			this.setStyle("icon", _iconDce);
		}
		public function ButtonIconaDce()
		{
			super();
			this.setStyle("border", "inset");
			////////////
			this.addEventListener(MouseEvent.MOUSE_OVER, setBorder);
			this.addEventListener(MouseEvent.MOUSE_OUT, unsetBorder);
		}
		private function setBorder(event:MouseEvent):void {
			 
			this.setStyle("fillColors", [0x009900, 0x009900]);
		}
		private function unsetBorder(event:MouseEvent):void {
			 
			this.setStyle("fillColors", undefined);
		} 
	}
}