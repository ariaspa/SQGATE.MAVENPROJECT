package com.li.dc.sebc.turboFSE.model.filters
{
	import com.li.dc.sebc.turboFSE.model.filters.base.ComparisonDateSpecification;
	import com.li.dc.sebc.turboFSE.model.filters.base.HasAttributiSpecificiSpecification;
	import com.li.dc.sebc.turboFSE.model.filters.base.HasAttributiWithPresidio;
	import com.li.dc.sebc.turboFSE.model.filters.base.HasStringLengthSpecification;
	import com.li.dc.sebc.turboFSE.model.filters.base.IsFolderSpecification;
	import com.li.dc.sebc.turboFSE.model.filters.base.IsNullSpecification;
	import com.li.dc.sebc.turboFSE.model.filters.base.IsStringSpecification;
	import com.li.dc.sebc.turboFSE.util.UtilDate;
	
	import it.lispa.siss.sebc.flex.debug.Debug;
	import it.lispa.siss.sebc.flex.specification.AbstractCompositeSpecification;
	import it.lispa.siss.sebc.flex.specification.ISpecification;
	import it.lispa.siss.sebc.middleground.entity.AttributiFolderAmbulatoriale;
	import it.lispa.siss.sebc.middleground.entity.AttributiFolderProntoSoccorso;
	import it.lispa.siss.sebc.middleground.entity.AttributiFolderRicovero;
	import it.lispa.siss.sebc.middleground.entity.AttributiSpecificiFolder;
	import it.lispa.siss.sebc.middleground.entity.ConstAttributiSpecificiFolder;
	import it.lispa.siss.sebc.middleground.entity.Folder;

	public class DateSpecification extends AbstractCompositeSpecification
	{
		private var folder:ISpecification;
		private var attributiFolder:ISpecification;
		private var comparison:ISpecification;
		private var isNN:ISpecification;
		private var string:ISpecification;
		public function DateSpecification(dataStart:Date,dataEnd:Date)
		{
			super();
			folder			= getFolderSpec();
			attributiFolder	= getAttributiSpec();
			string			= getSpecString();
			isNN			= new IsNullSpecification().not();
			comparison		= new ComparisonDateSpecification(dataStart,dataEnd); 
			Debug.logInfo("DateSpecification TODO : CAPIRE BENE QUALI DATE BISOGNA CONTROLLARE");
		}
		private function getAttributiSpec():ISpecification
		{
			var spec:ISpecification = getFolderSpec();
			spec					= spec.and( new HasAttributiSpecificiSpecification() );
			spec					= spec.and( new HasAttributiWithPresidio() );
			return spec; 
		}
		private function getSpecString():ISpecification
		{
			var sp:ISpecification 	= new IsNullSpecification().not(); 
			sp 						= sp.and( new IsStringSpecification() );	
			sp 						= sp.and( new HasStringLengthSpecification() );
			return sp;
		}
		private function getFolderSpec():ISpecification
		{
			var spec:ISpecification	= new IsNullSpecification().not();
			spec 					= spec.and( new IsFolderSpecification() );
			return spec; 
		}
		/* funziona in modo diverso se è un folder ma non ha date va bene, se è un folder e ha date controllare la data */
		override public function isSatisfiedBy(candidate:Object):Boolean
		{
			return comparison.isSatisfiedBy( getDate( candidate as Folder) as Object );	
		}
		
		private function getDate(cnd:Folder):Date
		{
			var att:AttributiSpecificiFolder = cnd.attributiSpecificiFolder;
			if(att!=null)
			{
				switch(att.tipo)
				{
					case ConstAttributiSpecificiFolder.ATTRIBUTI_PS:
						return extractDatePS( att as AttributiFolderProntoSoccorso );
					case ConstAttributiSpecificiFolder.ATTRIBUTI_RICOVERO:
						return extractDateRicovero( att as AttributiFolderRicovero );
					case ConstAttributiSpecificiFolder.ATTRIBUTI_AMBULATORIALE:
						return extractDateAmbulatoriale( att as AttributiFolderAmbulatoriale );
				}
			}
			return new Date();
		}
		private function extractDatePS(att:AttributiFolderProntoSoccorso):Date
		{
			var dtStr:String = extractDatePSOraIngresso(att);
			if(!string.isSatisfiedBy(dtStr))
			{
				dtStr = extractDatePSOraUscita(att);
			}
			if(string.isSatisfiedBy(dtStr))
			{
				return  UtilDate.fromStringToDate( dtStr ); 
			}
			return new Date();
		}
		private function extractDatePSOraUscita(att:AttributiFolderProntoSoccorso):String
		{
			if(isNN.isSatisfiedBy(att.datiProntoSoccorso) 
			&& isNN.isSatisfiedBy(att.datiProntoSoccorso.datiDimissione) 
			&& string.isSatisfiedBy(att.datiProntoSoccorso.datiDimissione.dataOraDimissione))
			{
				return att.datiProntoSoccorso.datiDimissione.dataOraDimissione;
			}
			return "";
		}
		private function extractDatePSOraIngresso(att:AttributiFolderProntoSoccorso):String
		{
			if(isNN.isSatisfiedBy(att.datiProntoSoccorso) 
			&& string.isSatisfiedBy(att.datiProntoSoccorso.dataOraIngresso))
			{
				return att.datiProntoSoccorso.dataOraIngresso;
			}
			return "";
		}		
		
		private function extractDateRicovero(att:AttributiFolderRicovero):Date
		{
			if(isNN.isSatisfiedBy(att.datiRicovero) 
				&& string.isSatisfiedBy(att.datiRicovero.dataOraRicovero))
			{
				return  UtilDate.fromStringToDate( att.datiRicovero.dataOraRicovero ); 
			}
			return new Date();
		}
		private function extractDateAmbulatoriale(att:AttributiFolderAmbulatoriale):Date
		{
			if(isNN.isSatisfiedBy(att.attributiAmbulatoriale) 
				&& string.isSatisfiedBy(att.attributiAmbulatoriale.dataAccettazione))
			{
				return  UtilDate.fromStringToDate( att.attributiAmbulatoriale.dataAccettazione ); 
			}
			return new Date();
		}
	}
}