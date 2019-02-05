package com.li.dc.sebc.turboFSE.model.filters.tline
{
	import com.li.dc.sebc.turboFSE.model.filters.base.IsArrayCollectionSpecification;
	import com.li.dc.sebc.turboFSE.model.filters.base.IsNullSpecification;
	import com.li.dc.sebc.turboFSE.model.filters.base.IsStringSpecification;
	import com.li.dc.sebc.turboFSE.model.vo.WrapDataDocument;
	
	import it.lispa.siss.sebc.flex.collection.ArrayIterator;
	import it.lispa.siss.sebc.flex.collection.IIterator;
	import it.lispa.siss.sebc.flex.specification.AbstractCompositeSpecification;
	
	import mx.collections.ArrayCollection;

	public class PDTSpecification extends AbstractCompositeSpecification
	{
		private var isString:IsStringSpecification;
		private var isNull:IsNullSpecification;
		private var isArrayC:IsArrayCollectionSpecification;
		private var listItems:Array;
		public function PDTSpecification(listItems:Array)
		{
			super();
			this.listItems = listItems;
			isNull 			= new IsNullSpecification();
			isString 		= new IsStringSpecification();
			isArrayC 		= new IsArrayCollectionSpecification();
		}
		override public function isSatisfiedBy(candidate:Object):Boolean
		{
			if( isNull.not().isSatisfiedBy( listItems ))
			{
				if( listItems.length == 0)return true;
				if( isNull.not().isSatisfiedBy( candidate ) )
				{
					var wrap:WrapDataDocument = candidate as WrapDataDocument;
					//if(isNull.isSatisfiedBy( wrap.PDT))return true;
					if( isNull.not().and( isArrayC ).isSatisfiedBy( wrap.PDT ) )
					{
						var pdts:ArrayCollection =  wrap.PDT  as ArrayCollection;
						var iter:IIterator = new ArrayIterator(listItems);
						while(iter.hasNext())
						{
							var voice:String = iter.next() as String;
							if(pdts.contains( voice ))
							{
								return true;
							}
						}
					}
				}
			}
			return false;
		}
	}
}