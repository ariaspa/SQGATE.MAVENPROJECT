package com.li.dc.sebc.turboFSE.model.filters.tline
{
	import com.li.dc.sebc.turboFSE.model.filters.base.IsNullSpecification;
	import com.li.dc.sebc.turboFSE.model.filters.base.IsStringSpecification;
	import com.li.dc.sebc.turboFSE.model.vo.WrapDataDocument;
	
	import it.lispa.siss.sebc.flex.collection.ArrayIterator;
	import it.lispa.siss.sebc.flex.collection.IIterator;
	import it.lispa.siss.sebc.flex.specification.AbstractCompositeSpecification;

	public class DisciplinaSpecification extends AbstractCompositeSpecification
	{
		private var isString:IsStringSpecification;
		private var isNull:IsNullSpecification;
		private var listItems:Array;
		public function DisciplinaSpecification(listItems:Array)
		{
			super();
			this.listItems	= listItems;
			isNull 			= new IsNullSpecification();
			isString 		= new IsStringSpecification();
		}
		override public function isSatisfiedBy(candidate:Object):Boolean
		{
			if( isNull.not().isSatisfiedBy( listItems ))
			{
				if( listItems.length == 0)return true;
				if( isNull.not().isSatisfiedBy( candidate ) )
				{
					var wrap:WrapDataDocument = candidate as WrapDataDocument;
					//if(isNull.isSatisfiedBy( wrap.disciplina))return true;
					if( isNull.not().and( isString ).isSatisfiedBy( wrap.disciplina ) )
					{
						var iter:IIterator 	= new ArrayIterator(listItems);
						var d:String		= wrap.disciplina.toUpperCase();
						while(iter.hasNext())
						{
							var voice:String = iter.next() as String;
							if(voice.toUpperCase() == d)
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