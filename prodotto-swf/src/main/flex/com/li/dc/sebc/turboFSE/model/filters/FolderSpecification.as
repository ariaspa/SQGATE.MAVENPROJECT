package com.li.dc.sebc.turboFSE.model.filters
{
	import com.li.dc.sebc.turboFSE.model.filters.base.EqualObjectSpecification;
	import com.li.dc.sebc.turboFSE.model.filters.base.HasStringLengthSpecification;
	import com.li.dc.sebc.turboFSE.model.filters.base.IsFolderSpecification;
	import com.li.dc.sebc.turboFSE.model.filters.base.IsNullSpecification;
	import com.li.dc.sebc.turboFSE.model.filters.base.IsStringSpecification;
	import com.li.dc.sebc.turboFSE.model.vo.FolderTree;
	import com.li.dc.sebc.turboFSE.util.ArrayCollectionIterator;
	
	import it.lispa.siss.sebc.flex.collection.ArrayIterator;
	import it.lispa.siss.sebc.flex.collection.IIterator;
	import it.lispa.siss.sebc.flex.specification.AbstractCompositeSpecification;
	import it.lispa.siss.sebc.flex.specification.ISpecification;
	import it.lispa.siss.sebc.middleground.entity.Folder;
	
	import mx.collections.ArrayCollection;

	public class FolderSpecification extends AbstractCompositeSpecification
	{
		private var iterator:IIterator;
		private var isNN:ISpecification;
		private var hasLen:ISpecification;
		private var equal:EqualObjectSpecification;
		private var string:ISpecification;
		private var isFolder:ISpecification;
		
		private var isFolderAndHasChildren:ISpecification;
		public function FolderSpecification(listFolder:Array /* lista di stringhe */)
		{
			super();
			isFolderAndHasChildren 	= new IsFolderAndHasChildrenSpecification();
			isFolder	= new IsNullSpecification().not();
			isFolder	= isFolder.and( new IsFolderSpecification());
			equal		= new EqualObjectSpecification(); 
			isNN		= new IsNullSpecification().not();
			hasLen		= new HasStringLengthSpecification();
			string		= getSpecString();
			string		= string.and( equal );
			iterator	= new ArrayIterator(toUperCase(listFolder));
		}
		private function toUperCase(list:Array):Array
		{
			var ite:IIterator 		= new ArrayIterator(list);
			var spec:ISpecification	= getSpecString();
			var res:Array			= new Array();
			while(ite.hasNext())
			{
				var str:String	= ite.next() as String;
				if(spec.isSatisfiedBy(str))res.push( str.toUpperCase() );
			}
			return res;
		}
		private function getSpecString():ISpecification
		{
			var sp:ISpecification 	= new IsNullSpecification().not(); 
			sp 						= sp.and( new IsStringSpecification() );
			sp 						= sp.and( new HasStringLengthSpecification() );
			return sp;
		}
		private function findChild(children:ArrayCollection):Boolean
		{
			var iter:IIterator 	= new ArrayCollectionIterator( children );
			while(iter.hasNext())
			{
				var flag:Boolean = isSatisfiedBy( iter.next() );
				if(flag)
				{
					return true;
				}
			}
			return false;
		} 
		override public function isSatisfiedBy(candidate:Object):Boolean
		{
			if(isFolderAndHasChildren.isSatisfiedBy(candidate))
			{
				return findChild((candidate as FolderTree).children);
			}
			if(isFolder.isSatisfiedBy(candidate))
			{
				var descrizione:String	= getDescrizione(candidate as Folder);
				
				if(hasLen.isSatisfiedBy( descrizione ))
				{
					equal.setObject( descrizione );
					iterator.reset();
					while(iterator.hasNext())
					{
						if(string.isSatisfiedBy( iterator.next() ))return true;
					} 
				}
			}
			return false;
		}
		private function getDescrizione(fld:Folder):String
		{
			if(isNN.isSatisfiedBy(fld) 
			&& isNN.isSatisfiedBy(fld.folder) 
			&& isNN.isSatisfiedBy(fld.folder.descrizione))
			{
				return fld.folder.descrizione.toUpperCase();
			}	  
		 	return "";
		}
	}
}