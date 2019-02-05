package com.li.dc.sebc.turboFSE.model.filters.base
{
	import it.lispa.siss.sebc.flex.specification.AbstractCompositeSpecification;
	import it.lispa.siss.sebc.flex.specification.ISpecification;
	import it.lispa.siss.sebc.middleground.entity.Folder;

	public class HasDceSpecification extends AbstractCompositeSpecification
	{
		private var isNotNull:ISpecification;
		public function HasDceSpecification()
		{
			super();
			isNotNull = new IsNullSpecification().not();
		}
		override public function isSatisfiedBy(candidate:Object):Boolean
		{
			if(isNotNull.isSatisfiedBy(Folder(candidate).listaDCE))
			{
				if(Folder(candidate).listaDCE.length>0)return true;
			} 
			return false;
		}
	}
}