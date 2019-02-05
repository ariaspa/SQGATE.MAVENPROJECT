package com.li.dc.sebc.turboFSE.model.filters.base
{
	import com.li.dc.sebc.turboFSE.model.vo.FolderTree;
	
	import it.lispa.siss.sebc.flex.specification.AbstractCompositeSpecification;
	import it.lispa.siss.sebc.middleground.entity.AttributiSpecificiFolder;
	import it.lispa.siss.sebc.middleground.entity.ConstAttributiSpecificiFolder;

	public class HasAttributiWithEnte extends AbstractCompositeSpecification
	{
		public function HasAttributiWithEnte()
		{
			super();
		}
		override public function isSatisfiedBy(candidate:Object):Boolean
		{
			if(!(candidate is FolderTree))return false;
			var att:AttributiSpecificiFolder = (candidate as FolderTree).attributiSpecificiFolder;
			if(att==null)return false;
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