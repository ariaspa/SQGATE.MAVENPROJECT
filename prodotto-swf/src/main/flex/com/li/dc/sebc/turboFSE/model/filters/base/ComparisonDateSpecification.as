package com.li.dc.sebc.turboFSE.model.filters.base
{
	import com.li.dc.sebc.turboFSE.model.filters.IsFolderAndHasChildrenSpecification;
	import com.li.dc.sebc.turboFSE.model.vo.FolderTree;
	import com.li.dc.sebc.turboFSE.util.ArrayCollectionIterator;
	import com.li.dc.sebc.turboFSE.util.UtilDate;
	
	import it.lispa.siss.sebc.flex.collection.IIterator;
	import it.lispa.siss.sebc.flex.specification.AbstractCompositeSpecification;
	import it.lispa.siss.sebc.flex.specification.ISpecification;
	
	import mx.collections.ArrayCollection;

	public class ComparisonDateSpecification extends AbstractCompositeSpecification
	{
		private var start:Date;
		private var end:Date;
		private var isFolderAndHasChildren:ISpecification;
		public function ComparisonDateSpecification(startDate:Date,endDate:Date)
		{
			super();
			start 	= startDate;
			end		= endDate; 
			isFolderAndHasChildren 	= new IsFolderAndHasChildrenSpecification();
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
			if(candidate is Date)
			{
			//	Debug.logDebug("candidate : "+candidate);
				var dt:Date = (candidate as Date);
				if((UtilDate.isMajor(dt, start ) || UtilDate.isEquals(start,dt) ) 
				&& (UtilDate.isMajor(end,dt) || UtilDate.isEquals(end , dt)  ) )
				{
					return true;				
				}
			}
			return false;
		}
	}
}