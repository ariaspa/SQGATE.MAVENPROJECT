package com.li.dc.sebc.turboFSE.model.filters
{
	import com.li.dc.sebc.turboFSE.model.filters.base.EqualObjectSpecification;
	import com.li.dc.sebc.turboFSE.model.filters.base.HasDceSpecification;
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
	import it.lispa.siss.sebc.middleground.entity.SetDocumentale;
	
	import mx.collections.ArrayCollection;

	public class ErogazioneSpecification extends AbstractCompositeSpecification
	{
		private var iterator:IIterator;
		private var hasDce:ISpecification;
		private var isNN:ISpecification;
		private var equal:EqualObjectSpecification;
		private var string:ISpecification;
		
		private var isFolderAndHasChildren:ISpecification;
		public function ErogazioneSpecification(list:Array)
		{
			super();
			isFolderAndHasChildren 	= new IsFolderAndHasChildrenSpecification();
			iterator	= new ArrayIterator(toUperCase(list));
			hasDce 		= getSpecListDce();
			isNN		= new IsNullSpecification().not();
			equal		= new EqualObjectSpecification();
			string		= getSpecString();
			string		= string.and( equal );
		}
		
		private function getSpecString():ISpecification
		{
			var sp:ISpecification 	= new IsNullSpecification().not(); 
			sp 						= sp.and( new IsStringSpecification() );	
			sp 						= sp.and( new HasStringLengthSpecification() );
			return sp;
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
		private function getSpecListDce():ISpecification
		{
			var spec:ISpecification = new IsNullSpecification().not();
			spec					= spec.and( new IsFolderSpecification() );
			spec					= spec.and( new HasDceSpecification() );
			return spec;
		}
		private function getDescrizione(dce:SetDocumentale):String
		{
			if(isNN.isSatisfiedBy(dce) 
			&& isNN.isSatisfiedBy(dce.disciplinaErogazione) 
			&& isNN.isSatisfiedBy(dce.disciplinaErogazione.descrizione))
			{
				return dce.disciplinaErogazione.descrizione.toUpperCase();
			}	  
		 	return "";
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
			if(hasDce.isSatisfiedBy( candidate ))
			{
				var dce:ArrayIterator = new ArrayIterator(Folder(candidate).listaDCE.toArray());
				while(dce.hasNext())
				{
					var descrizione:String 		= getDescrizione( dce.next() as SetDocumentale );
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
	}
}