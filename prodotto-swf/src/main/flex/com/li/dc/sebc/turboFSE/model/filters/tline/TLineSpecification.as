package com.li.dc.sebc.turboFSE.model.filters.tline
{
	import com.li.dc.sebc.turboFSE.model.filters.base.IsNullSpecification;
	
	import it.lispa.siss.sebc.flex.specification.AbstractCompositeSpecification;

	public class TLineSpecification extends AbstractCompositeSpecification
	{
		private var disciplina:DisciplinaSpecification; 
		private var farmaco:FarmacoSpecification; 
		private var pdt:PDTSpecification; 
		private var prestazione:PrestazioneSpecification; 
		private var tipoDati:TipologiaDatiSpecification; 
		private var tipoDCE:TipologiaDCESpecification; 
		
		public function TLineSpecification(listItems:Array)
		{
			super();
			/*	
				items.push( tDati.list.selectedItems == null ? new Array() :  tDati.list.selectedItems );
				items.push( tDCE.list.selectedItems  == null ? new Array() :  tDCE.list.selectedItems );
				items.push( pdt.list.selectedItems  == null ? new Array() : pdt.list.selectedItems );
				items.push( farmaci.list.selectedItems  == null ? new Array() : farmaci.list.selectedItems );
				items.push( discipline.list.selectedItems == null ? new Array() : discipline.list.selectedItems );
				items.push( prestazioni.list.selectedItems == null ? new Array() : prestazioni.list.selectedItems );
			*/
			
			tipoDati	= new TipologiaDatiSpecification( listItems[0] ); 
			tipoDCE		= new TipologiaDCESpecification( listItems[1] ); 
			pdt 		= new PDTSpecification( listItems[2] );
			farmaco 	= new FarmacoSpecification( listItems[3] );
			disciplina 	= new DisciplinaSpecification( listItems[4] );
			prestazione = new PrestazioneSpecification( listItems[5] ); 
			
		}
		
		override public function isSatisfiedBy( candidate:Object ):Boolean
		{
			return disciplina.and(farmaco).and(pdt).and(prestazione).and(tipoDati).and(tipoDCE).and(prestazione).isSatisfiedBy( candidate ); 
		}
	}
}

 
  			 
  				 
  			 