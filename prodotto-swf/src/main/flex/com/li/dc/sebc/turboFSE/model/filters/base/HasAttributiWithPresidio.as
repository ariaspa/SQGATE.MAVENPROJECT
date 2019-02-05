package com.li.dc.sebc.turboFSE.model.filters.base
{
	import it.lispa.siss.sebc.flex.specification.AbstractCompositeSpecification;
	import it.lispa.siss.sebc.middleground.entity.AttributiSpecificiFolder;
	import it.lispa.siss.sebc.middleground.entity.ConstAttributiSpecificiFolder;
	import it.lispa.siss.sebc.middleground.entity.Folder;

	public class HasAttributiWithPresidio extends AbstractCompositeSpecification
	{
		public function HasAttributiWithPresidio()
		{
			super();
		}
		override public function isSatisfiedBy(candidate:Object):Boolean
		{
			var folder:Folder 					= candidate as Folder;
			var att:AttributiSpecificiFolder	= folder.attributiSpecificiFolder;
			switch(att.tipo)
			{
				case ConstAttributiSpecificiFolder.ATTRIBUTI_PS:
				case ConstAttributiSpecificiFolder.ATTRIBUTI_RICOVERO:
				case ConstAttributiSpecificiFolder.ATTRIBUTI_AMBULATORIALE:
				return true;
			}
			return false;
		}
	}
}