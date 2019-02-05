package com.li.dc.sebc.turboFSE.model.filters.base
{
	import it.lispa.siss.sebc.flex.specification.AbstractCompositeSpecification;

	public class IsNullSpecification extends AbstractCompositeSpecification
	{
		public function IsNullSpecification()
		{
			super();
		}
		override public function isSatisfiedBy(candidate:Object):Boolean
		{
			return (candidate == null);
		}
	}
}