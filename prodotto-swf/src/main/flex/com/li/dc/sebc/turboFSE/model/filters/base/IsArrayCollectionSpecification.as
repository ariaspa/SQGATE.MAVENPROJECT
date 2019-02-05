package com.li.dc.sebc.turboFSE.model.filters.base
{
	import it.lispa.siss.sebc.flex.specification.AbstractCompositeSpecification;
	
	import mx.collections.ArrayCollection;

	public class IsArrayCollectionSpecification extends AbstractCompositeSpecification
	{
		public function IsArrayCollectionSpecification()
		{
			super();
		}
		override public function isSatisfiedBy(candidate:Object):Boolean
		{
			return (candidate is ArrayCollection);
		}
	}
}