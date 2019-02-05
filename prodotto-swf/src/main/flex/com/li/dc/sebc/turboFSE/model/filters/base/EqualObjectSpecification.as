package com.li.dc.sebc.turboFSE.model.filters.base
{
	import it.lispa.siss.sebc.flex.specification.AbstractCompositeSpecification;

	public class EqualObjectSpecification extends AbstractCompositeSpecification
	{
		private var _object:Object;
		public function EqualObjectSpecification( )
		{
			super();
		}
		public function getObject():Object{return _object;} 
		public function setObject(obj:Object):void{_object = obj;} 
		override public function isSatisfiedBy(candidate:Object):Boolean
		{
			return getObject() == candidate;
		}
	}
}