package com.li.dc.sebc.turboFSE.model.filters
{
	import com.li.dc.sebc.turboFSE.model.filters.base.EqualObjectSpecification;
	import com.li.dc.sebc.turboFSE.model.filters.base.HasAttributiSpecificiSpecification;
	import com.li.dc.sebc.turboFSE.model.filters.base.HasAttributiWithEnte;
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
	import it.lispa.siss.sebc.middleground.entity.Ambulatoriale;
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

	public class EnteSpecification extends AbstractCompositeSpecification
	{
		private var iterator:IIterator;
		private var attEnte:ISpecification;
		private var isNN:ISpecification;
		private var equal:EqualObjectSpecification;
		private var string:ISpecification;
		 
		private var isFolderAndHasChildren:ISpecification;
		  
		public function EnteSpecification(list:Array)
		{
			super();
			iterator 				= new ArrayIterator( list );
			isFolderAndHasChildren 	= new IsFolderAndHasChildrenSpecification();
			attEnte 				= getSpecAttEnte();	
			isNN					= new IsNullSpecification().not(); 
			equal					= new EqualObjectSpecification(); 
			string					= getSpecString();
			string      			= string.and( equal );
		}
		private function getSpecAttEnte():ISpecification
		{
			var att:ISpecification 	= new IsNullSpecification().not(); 
			att 					= att.and( new IsFolderSpecification() );
		 	att 					= att.and( new HasAttributiSpecificiSpecification() );
		 	att 					= att.and( new HasAttributiWithEnte() );
		 	return att;
		}
		private function getSpecString():ISpecification
		{
			var sp:ISpecification 	= new IsNullSpecification().not(); 
			sp 						= sp.and( new IsStringSpecification() );
			sp 						= sp.and( new HasStringLengthSpecification() );
			return sp;
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
			 
			if( attEnte.isSatisfiedBy( candidate ) )
			{
				var descrizione:String = extractDescrizione((candidate as Folder).attributiSpecificiFolder);
				equal.setObject( descrizione.toUpperCase() );
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
					return getCodice(ps as DatoSanitario);	 
				case ConstAttributiSpecificiFolder.ATTRIBUTI_RICOVERO:
					var ric:Ricovero = AttributiFolderRicovero(candidate).datiRicovero;
					return getCodice(ric as DatoSanitario);
				case ConstAttributiSpecificiFolder.ATTRIBUTI_AMBULATORIALE:
					var att:Ambulatoriale = AttributiFolderAmbulatoriale(candidate).attributiAmbulatoriale;
				 	return getCodice(att as DatoSanitario);	    
			}
			return "";
		} 
		private function getCodice(dc:DatoSanitario):String
		{
			if(isNN.isSatisfiedBy(dc) 
			&& isNN.isSatisfiedBy(dc.struttura) 
			&& isNN.isSatisfiedBy(dc.struttura.ente)
			&& isNN.isSatisfiedBy(dc.struttura.ente.descrizione))
			{
				return dc.struttura.ente.descrizione;
			}	  
		 	return "";
		}
	}
}