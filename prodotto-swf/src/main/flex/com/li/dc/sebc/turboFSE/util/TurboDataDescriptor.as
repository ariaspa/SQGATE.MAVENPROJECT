package com.li.dc.sebc.turboFSE.util
{
	import com.li.dc.sebc.turboFSE.model.vo.FolderTree;
	
	import it.lispa.siss.sebc.flex.collection.IIterator;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ICollectionView;
	import mx.collections.IViewCursor;
	import mx.controls.treeClasses.DefaultDataDescriptor;

	public class TurboDataDescriptor extends DefaultDataDescriptor
	{
		public function TurboDataDescriptor()
		{
			super();
		}
		override public function getHierarchicalCollectionAdaptor(hierarchicalData:ICollectionView, uidFunction:Function, openItems:Object, model:Object = null):ICollectionView
    	{
    		var _data:ICollectionView = hierarchicalData;
    		if(hierarchicalData!=null)
    		{
    			_data = getCollection( hierarchicalData );
    		}
        	return super.getHierarchicalCollectionAdaptor(_data,uidFunction,openItems,model);
    	}
		override public function isBranch(node:Object, model:Object = null):Boolean
		{
			if(node!=null && node is FolderTree)
			{
				return hasChildren(node , model);
			}
			return super.isBranch( node , model);
		} 
		override  public function getData(node:Object, model:Object = null):Object
		{
			if(node!=null && node is FolderTree && !(node as FolderTree).visible)
			{
				return null;
			}
			return super.getData(node,model);
		}
		override public function hasChildren(node:Object, model:Object=null):Boolean
		{
			if(node!=null && node is FolderTree )
			{
				if(!(node as FolderTree).visible 
				|| (node as FolderTree).children==null 
				|| (node as FolderTree).children.length==0)
				{
					return false;
				}
				var iter:IIterator	= new ArrayCollectionIterator( (node as FolderTree).children );
				while(iter.hasNext())
				{
					if((iter.next() as FolderTree).visible)
					{
						return true;
					}
				}
				return false;
			}
			return super.hasChildren(node,model);
		} 
		private function getCollection(children:ICollectionView):ICollectionView
		{
			var result:ICollectionView	 = new ArrayCollection();
			if(children!=null && children.length>0)
			{	
				var cursor:IViewCursor		 = children.createCursor();
				var cont:Boolean			 = true;
				while(cont)
				{
					var obj:Object = cursor.current;
					if(obj!=null && obj is FolderTree && (obj as FolderTree).visible)
					{
						(result as ArrayCollection).addItem( obj );
					}	
					cont = cursor.moveNext();
				}
			}
			return result;
		}
		override public function getChildren(node:Object, model:Object=null):ICollectionView
		{
			if(node!=null && node is FolderTree)
			{
				var children:ArrayCollection = (node as FolderTree).children;
				return getCollection( children as ICollectionView);
			}
			return super.getChildren( node, model );
		}
	}
}









