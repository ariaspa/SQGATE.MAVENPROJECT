package com.li.dc.sebc.turboFSE.events
{
	import flash.events.Event;

	public class TurboEvent extends Event
	{
		public static const REFRESH:String 				= "refresh";
		public static const CLICK_CONFERMA:String 		= "clickConferma";
		public static const CLICK_RICERCA:String 		= "clickRicerca";
		public static const CLICK_CANCELLA:String 		= "clickCancella";

		public static const CLICK_ICON_DCE:String 		= "clickIconDce";
		public static const CLICK_BUTTON_DCE:String 	= "clickButtonDce";
		public static const CLICK_DCE_FOCUS:String 		= "clickDceFocus";
		
		public static const CLICK_BUTTON_FILTER:String 	 = "clickButtonFilter";
		public static const CLICK_BUTTON_PDT:String 	 = "clickButtonPdt";
		public static const CLICK_BUTTON_OSCURATI:String = "clickButtonOscurati";
		public static const CLICK_BUTTON_AGGIORNA:String = "clickButtonAggiorna";
		
		
		
		public static const CHANGE_PANEL_FILTER:String 	= "changePanelFilter";
		public static const CHANGE_FILTER_DATA:String 	= "changeFilterData";
		public static const POSITION_BEGINS:String 		= "positionBegins";
		public static const FILTER_SELECT:String 		= "filterSelect";
		public static const FILTER_DESELECT:String 		= "filterDeselect";
		public static const RESET_EVENT:String 			= "resetEvent";
		
		public static const COMPLETE_EVENT:String 		= "completeEvent";
		public static const UPDATE:String 				= "update";
		
		public static const DATA_AGREGAZIONE_CHANGE_FOCUS:String = "dataAgregazioneChangeFocus";
		public static const DATA_AGREGAZIONE_CHANGE_SELECT:String = "dataAgregazioneChangeSelect";
		public static const DATA_AGREGAZIONE_CHANGE_ENABLE:String = "dataAgregazioneChangeEnable";
 
		
		
		//
		public function TurboEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}