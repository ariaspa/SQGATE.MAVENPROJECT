package com.li.dc.sebc.turboFSE.model
{
	import mx.core.UIComponent;

	public class Costanti
	{
		// INDIRIZZI DI DEFAULT
		// indica la url dell'xml di config di default (potrebbe comunque non essere presente)
		public static const URL_XML_CONF:String					= "config.xml";
		public static const URL_TEMPORALE:String				= "/FseHealthPath/FseHealthPath.jsp";
		public static const URL_CONSOLE_DEBUG:String			= "panelDebug.swf";
		////////////////////////////////////////////////////////////////////////////
		public static const URL_COMUNICATOR:String				= "Comunicator.swf";
		public static const URL_VISUALIZER:String				= "Visualizer.swf";
		public static const URL_COLLECTOR:String				= "Collettore.swf";
		public static const URL_CONTAINER:String				= "http://127.0.0.1:8000/classes/flex/container.html";

		public static const URL_GADO:String						= "https://dcss.cgi.crs.lombardia.it/ope_gado/";
		////////////////////////////////////////////////////////////////////////////

		// il valore di default della destination
		public static const DEFAULT_DESTINATION:String		= "FSEOperatore";
		public static const NOME_CONSOLE:String				= "panelConsole";
		public static const NOME_DEBUG:String				= "panelDebug";
		// i nomi delle label dei tree
		public static const CRONOLOGICO:String				= "cronologico";
		public static const DOCUMENTI:String				= "documenti";
		public static const DISCIPLINA:String				= "disciplina";
		public static const TEMPORALE2:String				= "temporale";


		public static const FINESTRA:String					= "finestra";
		public static const OSCURA:String					= "oscura";
		public static const DEOSCURA:String					= "deoscura";
		//////////////////////////////////////////////////////////////////
		//
		public static const OPEN_DEBUG:Boolean				= false;
		public static const DEFAULT_LEVEL_DEBUG:uint		= 0;
		//////////////////////////////////////////////////////////////////


		public static const CODICEFISCALE:String			= "codiceFiscale";

		public static const LISTA_CODICI_PDT:String			= "listaCodiciPDT";
		public static const LISTA_COPY_DCE:String			= "listCopyDCEInPdt";


		public static const MAX_TAB:int						= 4;


		/////////////////////////////////////////////////////////////////////////

		public static const TIPO_DOC_TACUINO:String = "28";
		public static const TIPO_DOC_CARTELLA_CLINICA:String = "30";


	}
}