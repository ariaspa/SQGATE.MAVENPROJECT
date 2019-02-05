package com.li.dc.sebc.turboFSE.view.viste
{
	import com.li.dc.sebc.turboFSE.events.TurboEvent;
	import com.li.dc.sebc.turboFSE.model.vo.EventoTree;
	import com.li.dc.sebc.turboFSE.model.vo.WrapData;
	import com.li.dc.sebc.turboFSE.view.builders.DirectorViste;
	import com.li.dc.sebc.turboFSE.view.component.ButtonFolder;
	
	import flash.utils.Dictionary;
	
	import mx.controls.Button;
	
	public class ListVistaCronologico extends ListVista
	{
		private var mapLazy:Dictionary;
		public function ListVistaCronologico()
		{
			super();
			mapLazy = new Dictionary();
		}
		override protected function getList( ):Array
		{
			return this.dataVista.dataBody as Array;
		}
		override protected function getBoxVista(obj:Object):OpenableBox
		{
			var evento:WrapData		= obj as WrapData;
			var box:OpenableBox		= new OpenableBox();
			box.display				= evento.vista;
			return box;
		}
		override protected function closeVista(v:Vista):void
		{
			(v as OpenableBox).close();	 
		}
		override protected function openVista(v:Vista):void
		{
			(v as OpenableBox).open();
		}
		override protected function getButton(obj:Object):Button
		{
			var evento:EventoTree	= (obj as WrapData).data as EventoTree;
			//
			var btn:ButtonFolder 	= new ButtonFolder();
			btn.label				= evento.label;
			btn.toolTip				= evento.tooltip;
			btn.percentWidth		= 100;
			btn.height				= 30;
			btn.toggle				= true;
			btn.buttonMode			= true;
			btn.setStyle("cornerRadius",0);
			return btn;
		}
	}
}