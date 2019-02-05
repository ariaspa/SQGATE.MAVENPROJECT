package com.li.dc.sebc.turboFSE.model
{
	public class ConstTimeLine
	{
		// TIMELINE
		public static const RICOVERO_PS_BAND:int 	= 0; // le tipologie sono 4, eventoRicovero,eventoPS,documentoRicovero,documentoPS 
		
		public static const EVENTO_RICOVERO:int 	= 4; // book_red.png
		public static const EVENTO_PS:int 			= 5; // book_green
		public static const DOCUMENTO_RICOVERO:int 	= 6; // book_red_doc.png
		public static const DOCUMENTO_PS:int 		= 7; // book_green_doc.PNG
		
		public static const SPECIALISTICO_BAND:int 	= 1; // eventoSpecialistico,documentoSpecialistico
		
		public static const EVENTO_SPECIALISTICO:int 		= 8; // book_blue.png
		public static const DOCUMENTO_SPECIALISTICO:int 	= 9; // book_blue_doc.png
		
		
		public static const FARMACEUTICO_BAND:int 	= 2; // eventoFarmaceutico
		public static const EVENTO_FARMACEUTICO:int = 10; // icona_pillola.gif
		
		public static const ALTRO_BAND:int 			= 3; // evento, documento
		
		public static const EVENTO:int 				= 11; // book_yellow.png
		public static const DOCUMENTO:int 			= 12; // book_yellow_doc.png 
		
		/////////////////////////////////////////////////////////////////////////
		public static const L_RICOVERO:String			= "RICOVERO E PRONTO SOCCORSO";
		public static const L_SPECIALISTICO:String		= "SPECIALISTICI";
		public static const L_FARMACEUTICO:String		= "FARMACEUTICI";
		public static const L_ALTRO:String				= "ALTRI DATI";
		////////////////////////////////////////////////////////////////////////
		
		
	}
}