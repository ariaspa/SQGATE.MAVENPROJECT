package com.li.dc.sebc.turboFSE.model.filters
{
	import com.li.dc.sebc.turboFSE.model.filters.base.IsArrayCollectionSpecification;
	import com.li.dc.sebc.turboFSE.model.filters.base.IsFolderSpecification;
	import com.li.dc.sebc.turboFSE.model.filters.base.IsNullSpecification;
	import com.li.dc.sebc.turboFSE.model.vo.FolderTree;
	
	import it.lispa.siss.sebc.flex.specification.AbstractCompositeSpecification;
	import it.lispa.siss.sebc.flex.specification.ISpecification;
	
	import mx.collections.ArrayCollection;

	public class IsFolderAndHasChildrenSpecification extends AbstractCompositeSpecification
	{
		private var specFolder:ISpecification;
		private var specArray:ISpecification;
		public function IsFolderAndHasChildrenSpecification()
		{
			super();
			//-- non è null ed è un folderTree
			specFolder		= new IsNullSpecification().not();
			specFolder		= specFolder.and( new IsFolderSpecification());
			//-- 
			specArray		= new IsNullSpecification().not();
			specArray		= specArray.and( new IsArrayCollectionSpecification());
		}
		override public function isSatisfiedBy(candidate:Object):Boolean
		{
			if(specFolder.isSatisfiedBy( candidate ) )
			{
				var children:ArrayCollection = (candidate as FolderTree).children;
				if(specArray.isSatisfiedBy(children))
				{
					if(children.length>0)
					{
						return true;
					}
				}
			}
			return false;
		}
	}
}