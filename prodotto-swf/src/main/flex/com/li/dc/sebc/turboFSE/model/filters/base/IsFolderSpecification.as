package com.li.dc.sebc.turboFSE.model.filters.base
{
	import com.li.dc.sebc.turboFSE.model.vo.FolderTree;
	
	import it.lispa.siss.sebc.flex.specification.AbstractCompositeSpecification;

	public class IsFolderSpecification extends AbstractCompositeSpecification
	{
		public function IsFolderSpecification()
		{
			super();
		}
		override public function isSatisfiedBy(candidate:Object):Boolean
		{
			return candidate is FolderTree;
		}
	}
}