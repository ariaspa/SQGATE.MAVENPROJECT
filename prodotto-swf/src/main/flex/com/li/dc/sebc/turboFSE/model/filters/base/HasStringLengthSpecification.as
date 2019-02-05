package com.li.dc.sebc.turboFSE.model.filters.base
{
	import it.lispa.siss.sebc.flex.specification.AbstractCompositeSpecification;

	public class HasStringLengthSpecification extends AbstractCompositeSpecification
	{
		public function HasStringLengthSpecification()
		{
			super();
		}
		override public function isSatisfiedBy(candidate:Object):Boolean
		{
			return ((candidate as String).length>0);
		}
	}
}