package com.li.dc.sebc.turboFSE.model.vo
{
	import mx.collections.ArrayCollection;
	
	 
	public class Configuration
	{
		
		public function Configuration()
		{
			 
		}
		public var destination:String;
		/**
		 * temporale indica quando valorizzato il link all'aplicazione esterna, con la presenza del link 
		 * nel tab 'Fascicolo Sanitario' si aggiunge una voce nell'albero delle viste 
		 * ../FseHealthPath/FseHealthpath.jsp
		 */
		public var temporale:String; 
		
		public var urlGado:String; 
		/**
		 * Configurazione dei moduli per la visualizzazione dei documenti dentro alla popup
		 */
		public var popup:PopupConfig;
		/**
		 * lista dei codici PDT disponibili
		 */
		public var listaCodiciPDT:ArrayCollection;
		/**
		 * lista dei codici DCE disponibili per il copy dei PDT
		 */
		public var listCopyDCEInPdt:ArrayCollection;
		/** 
		 * dataInizioFlussi, dataFineFlussi. Se non vaolorizzati prende gli ultimi tre mesi
		 * data espressa in questa forma YYYYMMDD
		 */  	
		public var dataInizioFlussi:String; 
		/**
		 * data espressa in questa forma YYYYMMDD
		 */ 
		public var dataFineFlussi:String; 
		 
		/**
		 *  a true indica che deve essere visualizzato il bottone delle autorizzazioni dei dce
		 */
		public var autorizza:Boolean;
		
		public var apriChiudiPdt:Boolean;
		 
	 
		public var debug:DebugConfig;  
		
		
		  
	}
}