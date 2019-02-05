package com.li.dc.sebc.turboFSE.model.vo
{
	public class DataRicovero
	{
		public  var valueNosologico:String 			= "";
		public  var valueDataOraRicovero:String 	= "";
		public  var valueRepartoRicovero:String 	= "";
		public  var valueDiagnosiIngresso:String 	= "";
		public  var valueProvenienza:String 		= "";
		public  var valueTipoRicovero:String 		= "";
		public  var valueOnereDegenza:String 		= "";
		public  var valueRegimeRicovero:String 		= "";
		public  var valueDataOraDimi:String 		= "";
		public  var valueModalitaDimi:String 		= "";
		public  var valueRepartoDimi:String 		= "";
		public  var valueDiagnosiDimi:String 		= "";
		public  var rowCountDataGridDiag:uint		= 0;					
		public  var rowCountDataGridInterventi:uint = 0;					
		public  var rowCountDataGridTrasf:uint 		= 0;					
		public  var dataProviderGridDiag:Object;					
		public  var dataProviderGridInterventi:Object;					
		public  var dataProviderGridTrasf:Object;			
		
		
		public function DataRicovero()
		{
		}

	}
}