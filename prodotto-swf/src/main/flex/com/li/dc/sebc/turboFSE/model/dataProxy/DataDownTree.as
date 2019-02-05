package com.li.dc.sebc.turboFSE.model.dataProxy
{
	import com.li.dc.sebc.turboFSE.model.Costanti;
	import com.li.dc.sebc.turboFSE.model.vo.DataLabelTree;
	
	import it.lispa.siss.sebc.flex.mvc.model.proxy.DataProxy;
	
	import mx.collections.ArrayCollection;

	public class DataDownTree extends DataProxy
	{
		public function DataDownTree()
		{
			super( null );
		}
		override protected function controlType(value:Object):Boolean
		{
			return (value is DataLabelTree);
		}
		
		public function fillDefault():void
		{
			var root:DataLabelTree 	= new DataLabelTree();
			root.children 			= new ArrayCollection();
			root.label				= "viste";
			root.toolTip			= "viste";
			root.value				= "root";
			root.children.addItem( new DataLabelTree( "Documenti","Lista dei documenti" , Costanti.DOCUMENTI) );
			root.children.addItem( new DataLabelTree( "Disciplina","Lista delle discipline presenti" , Costanti.DISCIPLINA) );
			//root.children.addItem( new DataLabelTree( "Temporale","Visualizzazione esterna cronologica" , Costanti.TEMPORALE2) );
			update( root );
		}
	}
}