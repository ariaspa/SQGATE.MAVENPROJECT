package com.li.dc.sebc.turboFSE.model.vo
{
	import com.li.dc.sebc.turboFSE.events.TurboEvent;
	import com.li.dc.sebc.turboFSE.util.ConstImageTree;
	import com.li.dc.sebc.turboFSE.util.Utils;
	
	import flash.events.EventDispatcher;
	
	import it.lispa.siss.sebc.flex.debug.Debug;
	import it.lispa.siss.sebc.middleground.entity.SetDocumentale;
	
	import mx.events.PropertyChangeEvent;
	
	[Event(name="dataAgregazioneChangeFocus", type="com.li.dc.sebc.turboFSE.events.TurboEvent")]
	[Event(name="dataAgregazioneChangeSelect", type="com.li.dc.sebc.turboFSE.events.TurboEvent")]
	[Event(name="dataAgregazioneChangeEnable", type="com.li.dc.sebc.turboFSE.events.TurboEvent")]
	[Bindable]
	public class DataAgregazione extends EventDispatcher
	{
		public static const LINKOSCURATO:String = "linkOscurato";
		public static const LINK:String 		= "link";
		public static const OSCURATO:String 	= "oscurato";
		public static const DOCUMENTO:String 	= "documento";
		
		 
		private var _agrr:Array;
		 
		private var _idWindow:String = null;
		///////////////////////////////////////////////////////////
		public function get idWindow():String{return _idWindow;}
		public function get agregazione():Array{return _agrr;}	
		// titolo 
		public  var labelAgregazione:String;
		public  var tipAgregazione:String;
		public  var iconDCE:Class;
		////////////////////////////////////
		public  var isSelect:Boolean 	= false;
		public  var enable:Boolean 		= true;
		public  var inFocus:Boolean 	= false;

		////////////////////////////////////
		public  var statoDCE:String 	= "";
		public  var toolTipIconDCE:String 	= "";
		public function DataAgregazione(agrr:Array = null )
		{
			_agrr = agrr;
			var setDoc:SetDocumentale = agregazione[0];
			createAttr( setDoc );
			this.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE,onChangeProperty); 
		}
		private function createAttr(setDoc:SetDocumentale):void
		{
			labelAgregazione		= Utils.getLabelButtonDocEntry( setDoc );
			var tip:String			= Utils.getPrestazioni( setDoc );
			tipAgregazione			= labelAgregazione + ((tip==null || tip.length==0) ? "" : tip);
			statoDCE 				= creaStato(setDoc);
			iconDCE					= getIcon( statoDCE );
			toolTipIconDCE			= getToolTipDCE(statoDCE);
			if(setDoc.idSetDocumenti!=null && setDoc.idSetDocumenti.length>0)
			{
				_idWindow			= "_"+setDoc.idSetDocumenti.split(".").join("_")+"_";
			}
		}
		private function creaStato(dce:SetDocumentale):String
		{
			var isCopiato:Boolean 	= (dce.flagCopiato!=null) ? (dce.flagCopiato.toUpperCase() == "S") : false;
			var isOscurato:Boolean 	= Utils.isOscurato(  dce.oscuramento );
			if (isOscurato && isCopiato) {
				return LINKOSCURATO;
			} else if (isCopiato) {
				return LINK;
			} else if (isOscurato) {
				return OSCURATO;
			} 
			return DOCUMENTO;
		}
		private function getToolTipDCE(stato:String):String
		{
			if (LINKOSCURATO || LINK) {
				return "Trascina per copiare il documento";
			}   
			return "Premi per cancellare il documento";
		}
		private function getIcon(stato:String):Class
		{
			var cls:Class =  ConstImageTree.DOCUMENTO;
			switch(stato)
			{
				case LINKOSCURATO:
				cls =  ConstImageTree.LINKOSCURATO;
				break;
				case LINK:
				cls =  ConstImageTree.LINK;
				break;
				case OSCURATO:
				cls =  ConstImageTree.OSCURATO;
				break;
			}
			return cls;
		}
		private function onChangeProperty(e:PropertyChangeEvent):void
		{
			if(e.property=="isSelect")
			{
				Debug.logDebug("DataAgregazione.onChangeProperty ISSELECT :: "+isSelect);
				dispatchEvent(new TurboEvent(TurboEvent.DATA_AGREGAZIONE_CHANGE_SELECT));
				if(!this.isSelect && this.inFocus)
				{
					this.inFocus = false;
				} 
			}else if(e.property=="enable")
			{
			 	dispatchEvent(new TurboEvent(TurboEvent.DATA_AGREGAZIONE_CHANGE_ENABLE));	
			}else if(e.property=="inFocus")
			{
				// solo se c'è una finestra aperta e se il nuovo valore è true 
				if(this.isSelect)
				{
					dispatchEvent(new TurboEvent(TurboEvent.DATA_AGREGAZIONE_CHANGE_FOCUS));
				}else
				{
					this.inFocus = false;
				}		 
			}
		}
	}
}