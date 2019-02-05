package com.li.dc.sebc.turboFSE.model.filters.base
{
	import it.lispa.siss.sebc.flex.specification.AbstractCompositeSpecification;

	public class IsStringSpecification extends AbstractCompositeSpecification
	{
		public function IsStringSpecification()
		{
			super();
		}
		override public function isSatisfiedBy(candidate:Object):Boolean
		{
			return candidate is String;
		}
	}
}