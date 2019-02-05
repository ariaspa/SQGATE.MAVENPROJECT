package com.li.dc.sebc.turboFSE.model.filters
{
	import com.li.dc.sebc.turboFSE.model.filters.base.EqualObjectSpecification;
	import com.li.dc.sebc.turboFSE.model.filters.base.HasAttributiSpecificiSpecification;
	import com.li.dc.sebc.turboFSE.model.filters.base.HasAttributiWithPresidio;
	import com.li.dc.sebc.turboFSE.model.filters.base.HasStringLengthSpecification;
	import com.li.dc.sebc.turboFSE.model.filters.base.IsFolderSpecification;
	import com.li.dc.sebc.turboFSE.model.filters.base.IsNullSpecification;
	import com.li.dc.sebc.turboFSE.model.filters.base.IsStringSpecification;
	import com.li.dc.sebc.turboFSE.model.vo.FolderTree;
	import com.li.dc.sebc.turboFSE.util.ArrayCollectionIterator;
	
	import it.lispa.siss.sebc.flex.collection.ArrayIterator;
	import it.lispa.siss.sebc.flex.collection.IIterator;
	import it.lispa.siss.sebc.flex.specification.AbstractCompositeSpecification;
	import it.lispa.siss.sebc.flex.specification.ISpecification;
	import it.lispa.siss.sebc.middleground.entity.AttributiFolderAmbulatoriale;
	import it.lispa.siss.sebc.middleground.entity.AttributiFolderProntoSoccorso;
	import it.lispa.siss.sebc.middleground.entity.AttributiFolderRicovero;
	import it.lispa.siss.sebc.middleground.entity.AttributiSpecificiFolder;
	import it.lispa.siss.sebc.middleground.entity.ConstAttributiSpecificiFolder;
	import it.lispa.siss.sebc.middleground.entity.DatoSanitario;
	import it.lispa.siss.sebc.middleground.entity.Folder;
	import it.lispa.siss.sebc.middleground.entity.ProntoSoccorso;
	import it.lispa.siss.sebc.middleground.entity.Ricovero;
	
	import mx.collections.ArrayCollection;

	public class PresidioSpecification extends AbstractCompositeSpecification
	{
		private var iterator:IIterator;
		private var isNN:ISpecification;
		private var attPresidio:ISpecification;
		private var string:ISpecification;
		private var equal:EqualObjectSpecification;
		private var isFolderAndHasChildren:ISpecification;
		
		public function PresidioSpecification(listPresidio:Array /*of Strings*/ ) 
		{
			super();
			isFolderAndHasChildren 	= new IsFolderAndHasChildrenSpecification();
			iterator	= new ArrayIterator(listPresidio);
			isNN		= new IsNullSpecification().not();
			equal		= new EqualObjectSpecification(); 
			string		= getSpecString();
			string 		= string.and( equal );
			attPresidio = getSpecAttPresidio();	
		}
		private function getSpecString():ISpecification
		{
			var sp:ISpecification 	= new IsNullSpecification().not(); 
			sp 						= sp.and( new IsStringSpecification() );
			sp 						= sp.and( new HasStringLengthSpecification() );
			return sp;
		}
		private function getSpecAttPresidio():ISpecification
		{
			var att:ISpecification 	= new IsNullSpecification().not(); 
			att 					= att.and( new IsFolderSpecification() );
		 	att 					= att.and( new HasAttributiSpecificiSpecification() );
		 	att 					= att.and( new HasAttributiWithPresidio() );
		 	return att;
		}
		private function findChild(children:ArrayCollection):Boolean
		{
			var iter:IIterator 	= new ArrayCollectionIterator( children );
			while(iter.hasNext())
			{
				var flag:Boolean = isSatisfiedBy( iter.next() );
				if(flag)
				{
					return true;
				}
			}
			return false;
		} 
		override public function isSatisfiedBy(candidate:Object):Boolean
		{
			if(isFolderAndHasChildren.isSatisfiedBy(candidate))
			{
				return findChild((candidate as FolderTree).children);
			}
			if(attPresidio.isSatisfiedBy( candidate ))
			{
				var descrizione:String = extractDescrizione((candidate as Folder).attributiSpecificiFolder);
				equal.setObject( descrizione );
				iterator.reset();
				while(iterator.hasNext())
				{
					if(string.isSatisfiedBy( iterator.next() ))return true;
				} 
			}
			return false;
		}
		private function extractDescrizione(candidate:AttributiSpecificiFolder):String
		{
			switch(candidate.tipo)
			{
				case ConstAttributiSpecificiFolder.ATTRIBUTI_PS :
					var ps:ProntoSoccorso = AttributiFolderProntoSoccorso(candidate).datiProntoSoccorso;
					return getDescrizione(ps as DatoSanitario);	 
				case ConstAttributiSpecificiFolder.ATTRIBUTI_RICOVERO:
					var ric:Ricovero = AttributiFolderRicovero(candidate).datiRicovero;
					return getDescrizione(ric as DatoSanitario);
				case ConstAttributiSpecificiFolder.ATTRIBUTI_AMBULATORIALE:
					var att:Ambulatoriale = AttributiFolderAmbulatoriale(candidate).attributiAmbulatoriale;
				 	return getDescrizione(att as DatoSanitario);	    
			}
			return "";
		} 
		private function getDescrizione(dc:DatoSanitario):String
		{
			if(isNN.isSatisfiedBy(dc) 
			&& isNN.isSatisfiedBy(dc.presidio) 
			&& isNN.isSatisfiedBy(dc.presidio.descrizione))
			{
				return dc.presidio.descrizione;
			}	  
		 	return "";
		}
	}
}