package com.li.dc.sebc.turboFSE.view.builders
{
	import com.li.dc.sebc.turboFSE.model.ConstDataProxy;
	import com.li.dc.sebc.turboFSE.model.FSEModel;
	import com.li.dc.sebc.turboFSE.model.vo.DataLabelTree;
	import com.li.dc.sebc.turboFSE.model.vo.FolderTree;
	import com.li.dc.sebc.turboFSE.model.vo.Tree;
	import com.li.dc.sebc.turboFSE.util.Utils;
	
	import it.lispa.siss.sebc.flex.collection.ArrayIterator;
	import it.lispa.siss.sebc.flex.collection.IIterator;
	
	import mx.collections.ArrayCollection;
	
	public class DocumentiBuilder extends OpenableBuilder
	{
		private var oldParam:Object;
		private var listDataAgregazione:Array;
		public function DocumentiBuilder()
		{
			super();
		}
		override public function setParam(obj:Object):void
		{
			oldParam	= currentData;
			currentData = obj;
		}
		private function internalRecursiveData(list:Array):Array
		{
			var temp:Array	= new Array();
			var iter:IIterator	= new ArrayIterator( list );
			while(iter.hasNext())
			{
				var folder:FolderTree = iter.next() as FolderTree;
				if(folder.listaDCE !=null && folder.listaDCE.length>0)
				{
					temp = temp.concat( folder.listaDCE.toArray() );
				}
				if(folder.children!=null && folder.children.length>0)
				{
					temp = temp.concat( internalRecursiveData( folder.children.toArray() ) );
				}
			}	
			return temp;
		}
		 
		override protected function transformData(obj:Object):Object
		{
			var label:String	= (obj as DataLabelTree).label;
			var toolTip:String	= (obj as DataLabelTree).toolTip;
			//if(oldParam != currentData)
			//{
			var list:ArrayCollection 		= (FSEModel.getInstance().retrieveProxy(ConstDataProxy.DATA_TREE).getData() as Tree).listaFolder;
			var totalSetDocumentali:Array 	= internalRecursiveData( list.toArray() );
			listDataAgregazione				= getListDataAgregazione( Utils.getOrdinaAgregazioni( new ArrayCollection( totalSetDocumentali ) ) );
			//}
			return {dataHeader:null,dataBody:listDataAgregazione,label:label,tooltip:toolTip};
		} 
	}
}