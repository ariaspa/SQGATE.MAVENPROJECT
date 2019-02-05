package com.li.dc.sebc.turboFSE.model.filters.base
{
	import it.lispa.siss.sebc.flex.specification.AbstractCompositeSpecification;
	import it.lispa.siss.sebc.middleground.entity.Folder;

	public class HasAttributiSpecificiSpecification extends AbstractCompositeSpecification
	{
		public function HasAttributiSpecificiSpecification()
		{
			super();
		}
		override public function isSatisfiedBy(candidate:Object):Boolean
		{
			if(candidate is Folder)
			{
				return ((candidate as Folder).attributiSpecificiFolder != null);
			}
			return false;
		}
	}
}