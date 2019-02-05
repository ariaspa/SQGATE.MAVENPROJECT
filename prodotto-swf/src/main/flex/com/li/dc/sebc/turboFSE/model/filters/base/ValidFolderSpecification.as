package com.li.dc.sebc.turboFSE.model.filters.base
{
	import it.lispa.siss.sebc.flex.specification.AbstractCompositeSpecification;

	public class ValidFolderSpecification extends AbstractCompositeSpecification
	{
		public function ValidFolderSpecification()
		{
			super();
		}
		override public function isSatisfiedBy(candidate:Object):Boolean
		{
			return true;
		}
	}
}