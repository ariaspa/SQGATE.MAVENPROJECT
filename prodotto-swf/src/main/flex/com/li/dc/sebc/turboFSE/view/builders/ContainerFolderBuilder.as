package com.li.dc.sebc.turboFSE.view.builders
{
	import com.li.dc.sebc.turboFSE.model.vo.EventoTree;
	import com.li.dc.sebc.turboFSE.model.vo.FolderTree;
	import com.li.dc.sebc.turboFSE.view.viste.ContainerFolderVista;
	import com.li.dc.sebc.turboFSE.view.viste.Vista;
	
	import it.lisit.siss.flex.utility.debug.Debug;
	import it.lispa.siss.sebc.flex.collection.ArrayIterator;
	import it.lispa.siss.sebc.flex.collection.IIterator;
	import it.lispa.siss.sebc.middleground.entity.DatoCodificato;
	
	import mx.collections.ArrayCollection;	
	public class ContainerFolderBuilder extends Builder
	{
		public function ContainerFolderBuilder( )
		{
			super();
		}
		protected override function getVista():Vista
		{
			return  new ContainerFolderVista();
		}
		
		override protected function transformData(obj:Object):Object
		{
			var res:Array		= new Array();
			var iter:IIterator  = new ArrayIterator(  extractChildren(obj) );
			while(iter.hasNext())
			{
				res.push( extractLabel( iter.next() ) );
			}
			return res;
		}
		private function extractLabel(obj:Object):String
		{
			var label:String = "";
			if(obj is FolderTree)
			{
				label = (obj as FolderTree).label;
			}else if( obj is EventoTree)
			{
				label = (obj as EventoTree).label;
			}
			return label;
		}
		
		private function extractCodice(obj:Object):String
		{
			var dc:DatoCodificato;
			if(obj is FolderTree)
			{
				dc = (obj as FolderTree).folder;
			}else if( obj is EventoTree)
			{
				dc = (obj as EventoTree).tipoEvento;
			}
			return (dc!=null) ? dc.codice : "";
		}
		private function extractChildren(obj:Object):Array
		{
			var children:ArrayCollection;
			if(obj is FolderTree)
			{
				children = (obj as FolderTree).children;
			}else if(obj is EventoTree)
			{
				children = (obj as EventoTree).children;
			}
			return (children!=null) ? children.toArray() : new Array();
		}
		override protected function getKey():Object
		{
			var str:String		= "";
			var iter:IIterator  = new ArrayIterator(  extractChildren(currentData) );
			while( iter.hasNext() )
			{
				str += extractCodice( iter.next() );
			}
			return str;
		}
	}
}