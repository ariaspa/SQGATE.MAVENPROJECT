package com.li.dc.sebc.turboFSE.view.mediator.mediatorView
{
	import com.li.dc.sebc.turboFSE.events.TLFilterEvent;
	import com.li.dc.sebc.turboFSE.events.TurboEvent;
	import com.li.dc.sebc.turboFSE.model.ConstDataProxy;
	import com.li.dc.sebc.turboFSE.model.ConstPrestazioni;
	import com.li.dc.sebc.turboFSE.model.ConstTimeLine;
	import com.li.dc.sebc.turboFSE.model.FSEModel;
	import com.li.dc.sebc.turboFSE.model.filters.tline.TLineSpecification;
	import com.li.dc.sebc.turboFSE.model.vo.WrapDataDocument;
	import com.li.dc.sebc.turboFSE.util.BodyPopUpVT;
	import com.li.dc.sebc.turboFSE.util.TransformDataTimeLine;
	import com.li.dc.sebc.turboFSE.util.TransformDataTimeLineBase;
	import com.li.dc.sebc.turboFSE.util.ViewMessageManager;
	import com.li.dc.sebc.turboFSE.view.PopUpFiltriTML;
	import com.li.dc.sebc.turboFSE.view.PopUpLegend;
	import com.li.dc.sebc.turboFSE.view.component.Popup;
	import com.li.dc.sebc.turboFSE.view.component.ResizableBoxFiltri;
	import com.li.dc.sebc.turboFSE.view.component.TimelineFilter;
	import com.li.dc.sebc.turboFSE.view.mediator.ConstMediator;
	import com.li.dc.sebc.turboFSE.view.mediator.TurboView;
	import com.li.dc.sebc.turboFSE.view.nodeView.RootTimeLine;
	
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	
	import it.lispa.siss.library.ui.menustandard.Header;
	import it.lispa.siss.sebc.flex.collection.ArrayIterator;
	import it.lispa.siss.sebc.flex.collection.IIterator;
	import it.lispa.siss.sebc.flex.color.HTMLTabColor;
	import it.lispa.siss.sebc.flex.color.UtilsColor;
	import it.lispa.siss.sebc.flex.debug.Debug;
	import it.lispa.siss.sebc.flex.graphic.timeline.TimeLine;
	import it.lispa.siss.sebc.flex.graphic.timeline.events.DataDocumentEvent;
	import it.lispa.siss.sebc.flex.graphic.timeline.events.DataLabelEvent;
	import it.lispa.siss.sebc.flex.graphic.timeline.events.MenuItemSelect;
	import it.lispa.siss.sebc.flex.graphic.timeline.events.TLHelpEvent;
	import it.lispa.siss.sebc.flex.graphic.timeline.model.DataDocument;
	import it.lispa.siss.sebc.flex.graphic.timeline.model.DataLabel;
	import it.lispa.siss.sebc.flex.mvc.model.proxy.DataProxyEvent;
	import it.lispa.siss.sebc.flex.mvc.view.Mediator;
	import it.lispa.siss.sebc.flex.utils.Later;
	import it.lispa.siss.sebc.middleground.entity.Evento;
	import it.lispa.siss.sebc.middleground.entity.Programmazione;
	import it.lispa.siss.sebc.middleground.entity.SetDocumentale;
	import it.lispa.siss.sebc.sebwebsiss;
	
	import mx.binding.utils.BindingUtils;
	import mx.core.IUIComponent;
	import mx.core.UIComponent;
	import mx.events.CloseEvent;
	
	use namespace sebwebsiss;
	public class RootTimeLineMediator extends Mediator
	{
		// il canvas vuoto che fa da segna posto per i tab
		private var rootTimeline:RootTimeLine;
		// la timeline vera e propria
		private var timeline:TimeLine;
		// i filtri della popup
		private var filtri:TimelineFilter;
		private var popFiltri:PopUpFiltriTML;
		private var popLegend:PopUpLegend;
		//////////////////////////////////////////////////////
		private var enableLabel:Dictionary; 
		// la popup interna alla timeline che visualizza i valori del data
		private var pop:Popup;
		private var docs:Array;
		private var listWrap:Array;
		//
		public function RootTimeLineMediator()
		{
			super();
		}
		override protected function initialize( ):void
		{
			rootTimeline = (this.view as RootTimeLine);
			timeline	 = rootTimeline.timeline;
			popFiltri    = new PopUpFiltriTML();
			popLegend	 = new PopUpLegend();
			rootTimeline.addChild( popFiltri );
			Later.doLater(	init );
		}
		private function init():void
		{
			filtri		 = popFiltri.filt;
			rootTimeline.removeChild( popFiltri );
			initializeWiew();
			initializeData();
		}
		 
		private function initializeWiew():void
		{
			
			rootTimeline.btnFiltri.addEventListener(MouseEvent.CLICK,onOpenFilter);
			popFiltri.addEventListener(CloseEvent.CLOSE,onCloseFilter);
			popFiltri.title	= "FILTRI";
			rootTimeline.btnLegend.addEventListener(MouseEvent.CLICK,onOpenLegend);
			popLegend.title	= "LEGENDA";
			popLegend.addEventListener(CloseEvent.CLOSE,onCloseLegend);
			 
			// timeline labels
			timeline.dataLabels = getDataLabels();
			// TIMELINE STYLE
			timeline.setStyle("labelEspandi","espandi");
			timeline.setStyle("labelRiduci","riduci");
			//
			timeline.setStyle("windowScroll",12);
			// la quantità di anni visibili sulla barra degli anni
			timeline.setStyle("visibleYear",5);
			timeline.setStyle("calendarStyle",TimeLine.CALENDAR_STYLE_VERYSMALL); 
			timeline.setStyle("calendarStyleUpButton",TimeLine.CALENDAR_STYLE_VERYSMALL); 
			
			timeline.setStyle("themeColor",0x7BADB0);  
			// il colore degli anni
			timeline.setStyle("formatColorYear",HTMLTabColor.BLACK);
			// il colore delle lineette e delle lettere all'interno della barra scorrevole in basso	
			timeline.setStyle("colorLineCalendar",0xD8E8E8);  	 
			// il colore di bck
			timeline.setStyle("bckColor",HTMLTabColor.BLACK);
			// l'alpha del bck  	  
			timeline.setStyle("bckAlpha",0.7);
			// il colore dei bottoni sopra la colonna per selezionarli
			timeline.setStyle("buttonColor",HTMLTabColor.LIGHTSTEELBLUE);  	  
			timeline.setStyle("rollOutScrollColor",HTMLTabColor.WHITESMOKE);  	  
			timeline.setStyle("rollOverScrollColor",HTMLTabColor.RED); 
			
			// timeline listener
			timeline.addEventListener(DataLabelEvent.DATA_LABEL_CHANGE_ENABLED,onChangeEnabledDataLabel);
			timeline.addEventListener(DataDocumentEvent.CHANGE_STATE_EVENT,onChangeStateEvent);
			timeline.addEventListener(DataDocumentEvent.CLICK_DOCUMENT_EVENT,onClickDocument);
			timeline.addEventListener(MenuItemSelect.MENU_ITEM_SELECT,onMenuItemSelect);
			timeline.addEventListener(TLHelpEvent.TL_HELP_EVENT,onHelpEvent);
		 	
		 	// da quale punto inizia la timeline
		 	var model:FSEModel 		= FSEModel.getInstance();
		 	
			var dt:Date 			= model.today;
			 
			timeline.startYear		= model.startYearTimeline	= dt.fullYear-4;
			timeline.endYear		= model.endYearTimeline		= dt.fullYear+1;
			timeline.windowScroll	= dt.month + 1;
			
			filtri.lab_tipologie_dati 	= "TIPOLOGIE DATI";
			filtri.lab_tipologie_DCE 	= "TIPOLOGIE DCE";
			filtri.lab_PDT				= "PDT";
			filtri.lab_farmaci			= "ELENCO FARMACI";
			filtri.lab_discipline		= "ELENCO DISCIPLINE";
			filtri.lab_prestazioni		= "ELENCO PRESTAZIONI";
			
			filtri.addEventListener(TLFilterEvent.TLFILTER_EVENT,onFilterApplica);
			filtri.addEventListener(TurboEvent.RESET_EVENT,onResetFiltri); 
			////////////////
			//Later.doLater(doLater);
		}
		private function onCloseLegend(e:CloseEvent):void
		{
			if(popLegend!=null)
			{
				ViewMessageManager.getInstance().closeDisplayer();
			}
		}
		private function onCloseFilter(e:CloseEvent):void
		{
			if(popFiltri!=null)
			{
				ViewMessageManager.getInstance().closeDisplayer();
				filtri.clickApplica();
			}
		}
		private function onOpenFilter(e:MouseEvent):void
		{
			ViewMessageManager.getInstance().showPanel(popFiltri,0xCCCCCC,{width:550,height:350}); 
		}
		private function onOpenLegend(e:MouseEvent):void
		{
			ViewMessageManager.getInstance().showPanel(popLegend,0xCCCCCC,{width:550,height:350}); 
		}
		/* private function  doLater():void
		{
			var btnInfo:IUIComponent = (TurboView.getInstance().retriveMediator(ConstMediator.HEADER).getView() as Header).dragInfo;
			btnInfo.addEventListener(MouseEvent.MOUSE_DOWN, beginDrag );
		} */
		
		private function beginDrag(e:MouseEvent):void
		{
			//var dragSource:DragSource = new DragSource();
			//var label:String = "test";
			//(timeline.dataLabels[0] as DataLabel).formatDrop = label;
			//dragSource.addData( "addDataWhichYouWantStillObjects", label);
			// e.target-> il bottone su cui ho cliccato
			// Il DragSource a cui ho aggiunto il data e la label di riconoscimento
			// e l'evento del mouse
			// l'immagine da associare con questo drag, anche null
			//var prxImg:IFlexDisplayObject = (e.target as IDropDragClass).getProxyImage();
			//DragManager.doDrag( e.target as IUIComponent, dragSource, e, prxImg);
		}
		
		private function initializeData():void
		{
			var model:FSEModel 	= FSEModel.getInstance();
			BindingUtils.bindProperty(rootTimeline,"enabled",model,"enabledTabFascicolo",true);
			model.retrieveProxy(ConstDataProxy.DATA_TIMELINE).addEventListener(DataProxyEvent.DATA_UPDATE,onUpdateDataTimeline);
			//model.retrieveProxy(ConstDataProxy.OPENPOPUPTIMELINE).addEventListener(DataProxyEvent.DATA_UPDATE,onOpenTab);
		}
		/**
		 * quando arrivano i nuovi dati da remoto
		 * @param e
		 * 
		 */		
		private function onUpdateDataTimeline(e:DataProxyEvent):void
		{
			var newData:Object	= e.getData();
			if(newData==null)
			{
				timeline.dataDocument	= [];
				filtri.list_prestazione = filtri.list_discipline  = filtri.list_farmaci = filtri.list_PDT = filtri.list_tipologie_DCE = filtri.list_tipologie_dati = null;
			}else{
				var tr:TransformDataTimeLine	= new TransformDataTimeLine(newData as Array);
				// la lista dei dataDocument
				docs 			 				= tr.execute();
				// la lista dei wrap dei dataDocument
				listWrap						= tr.getListWrap();
				//////////////////////////////////////////////////////// 1
				var lTipologieDati:Array		= tr.getTipologieDati();
				if(lTipologieDati!=null && lTipologieDati.length>0)
				{
					filtri.tDati.enabled			= true;
					filtri.list_tipologie_dati 		= lTipologieDati;
				}else
				{
					filtri.tDati.enabled			= false;
				}
				//////////////////////////////////////////////////////// 2
				var lTipologieDCE:Array				= tr.getTipologieDCE();
				if(lTipologieDCE!=null && lTipologieDCE.length>0)
				{
					filtri.tDCE.enabled			= true;
					filtri.list_tipologie_DCE 	= lTipologieDCE;
				}else
				{
					filtri.tDCE.enabled			= false;
				}
				////////////////////////////////////////////////////////  3
				var lElencoPDT:Array				= tr.getElencoPDT();
				if(lElencoPDT!=null && lElencoPDT.length>0)
				{
					filtri.pdt.enabled			= true;
					filtri.list_PDT 			= lElencoPDT;
				}else
				{
					filtri.pdt.enabled			= false;
				}
				////////////////////////////////////////////////////////  4
				var lElencoFarmaci:Array		= tr.getElencoFarmaci();
				if(lElencoPDT!=null && lElencoPDT.length>0)
				{
					filtri.farmaci.enabled			= true;
					filtri.list_farmaci 			= lElencoFarmaci;
				}else
				{
					filtri.farmaci.enabled			= false;
				}
				////////////////////////////////////////////////////////  5
				var lElencoDiscipline:Array		= tr.getElencoDiscipline();
				if(lElencoDiscipline!=null && lElencoDiscipline.length>0)
				{
					filtri.discipline.enabled		= true;
					filtri.list_discipline 			= lElencoDiscipline;
				}else
				{
					filtri.discipline.enabled			= false;
				}
				////////////////////////////////////////////////////////  6
				var lElencoPrestazione:Array		= tr.getElencoPrestazione();
				if(lElencoPrestazione!=null && lElencoPrestazione.length>0)
				{
					filtri.prestazioni.enabled		= true;
					filtri.list_prestazione 			= lElencoPrestazione;
				}else
				{
					filtri.prestazioni.enabled			= false;
				}
				
				addListenerRoll();
				
				timeline.dataDocument			= docs;
			} 
		}
		 
		//======================================================================
		 
		private function onHelpEvent(e:TLHelpEvent):void{}
		/**
		 * al selezionamento di una voce del menù di destra su un item grafico che rappresenta un dataDocument 
		 * @param e
		 * 
		 */		
		private function getDataDocFromID(id:String):DataDocument
		{
			var iter:IIterator = new ArrayIterator(docs);
			while(iter.hasNext())
			{
				var doc:DataDocument = iter.next() as DataDocument;
				if(doc.id == id)
				{
					return doc;
				}
			}
			return null;
		}
		private function getChildrenDocs(listId:Array):Array
		{
			var iter:IIterator 	= new ArrayIterator(listId);
			var lit:Array		= new Array();
			while(iter.hasNext())
			{
				var doc:DataDocument = getDataDocFromID(iter.next() as String);
				if(doc!=null)
				{
					lit.push( doc );
				}
			}
			return lit;
		}
		private function onMenuItemSelect(e:MenuItemSelect):void
		{
			var caption:String = e.getItemMenu().getCaption();
			//e.getDataDocument().children
			Debug.logDebug("caption : "+caption);
			var doc:DataDocument;
			var idF:String;
			var children:Array;
			var iter:IIterator;
			var childrenID:Array;
			if(caption=="seleziona padre")
			{
				idF 				= e.getDataDocument().idFather;
				doc 				= getDataDocFromID(idF); 
				if(doc!=null){
					e.getDataDocument().stateDoc = doc.stateDoc	= "select";
					e.getDataDocument().getItemMenu("seleziona padre").setEnabled(false);
					e.getDataDocument().getItemMenu("deseleziona padre").setEnabled(true);
				}
			}else if(caption == "deseleziona padre")
			{
				idF 				= e.getDataDocument().idFather;
				doc 				= getDataDocFromID(idF); 
				if(doc!=null){
					e.getDataDocument().stateDoc = doc.stateDoc	= DataDocument.DEFAULT;
					e.getDataDocument().getItemMenu("seleziona padre").setEnabled(true);
					e.getDataDocument().getItemMenu("deseleziona padre").setEnabled(false);
				}
			}else if(caption == "seleziona programmazione")
			{
				childrenID = e.getDataDocument().children;
				if(childrenID!=null && childrenID.length>0)
				{
					children = getChildrenDocs(childrenID);
					if(children!=null && children.length>0)
					{
						iter = new ArrayIterator(children);
						while(iter.hasNext())
						{
							doc 		= iter.next() as DataDocument;
							doc.stateDoc = "select";
						}
						e.getDataDocument().stateDoc = "select";
						e.getDataDocument().getItemMenu("seleziona programmazione").setEnabled(false);
						e.getDataDocument().getItemMenu("deseleziona programmazione").setEnabled(true);
					}
				}
			}else if(caption == "deseleziona programmazione")
			{
				childrenID = e.getDataDocument().children;
				if(childrenID!=null && childrenID.length>0)
				{
					children = getChildrenDocs(childrenID);
					if(children!=null && children.length>0)
					{
						iter = new ArrayIterator(children);
						while(iter.hasNext())
						{
							doc 			= iter.next() as DataDocument;
							doc.stateDoc 	= DataDocument.DEFAULT;
						}
						e.getDataDocument().stateDoc = DataDocument.DEFAULT;
						e.getDataDocument().getItemMenu("seleziona programmazione").setEnabled(true);
						e.getDataDocument().getItemMenu("deseleziona programmazione").setEnabled(false);
					}
				}
			}
		}
		
		/**
		 * al cambuio di stato del dataDocument
		 * @param e
		 * 
		 */		
		private function onChangeStateEvent(e:DataDocumentEvent):void
		{
		
		}
		
		/**
		 * al cambio di stato di un dataLabel 
		 * @param e
		 * 
		 */		
		private function onChangeEnabledDataLabel(e:DataLabelEvent):void
		{
			/* var idlab:uint	= e.getDataLabel().idBand; 
			enableLabel[idlab] =!selectLabel[idlab];
			var enableLab:Boolean = enableLabel[idlab];
			filt.setVisibleFilter(idlab,enableLab);  */
		}
		//======================================================================
		private function getDataLabels():Array
		{
			 
			enableLabel   = new Dictionary();
  			var col:Array = UtilsColor.dilayColors(0xD5E8DD,HTMLTabColor.LIGHTGREEN,4);
  			//var col:Array = [0xA1B5A9,0xD5E8DD,0xA1B5A9,0xD5E8DD];
  			//var col:Array = [0xD5E8DD,0xA1B5A9,0xD5E8DD,0xA1B5A9];
  			 
  			var t:Array = new Array();
  			for(var i:uint = 0;i<4;i++)
  			{
  				var dt:DataLabel = new DataLabel(); 	
  				dt.color		= col[i];
  				dt.idBand		= i;	
  				dt.label		= getLabelDLabel(i);
  				dt.formatDrop	= "test_"+i;
  				enableLabel[dt.idBand] = true;
  				t.push( dt );
  			} 
  			return t;
		}
		private function getLabelDLabel(n:uint):String
  		{
  			switch(n)
  			{
  				case ConstTimeLine.RICOVERO_PS_BAND: 	return ConstTimeLine.L_RICOVERO;
  				case ConstTimeLine.SPECIALISTICO_BAND: 	return ConstTimeLine.L_SPECIALISTICO;
  				case ConstTimeLine.FARMACEUTICO_BAND: 	return ConstTimeLine.L_FARMACEUTICO;
  			}
  			return ConstTimeLine.L_ALTRO;
  		}
  		private function onResetFiltri(e:TurboEvent):void
  		{
  			var iter:IIterator 	= new ArrayIterator( listWrap );
  			while(iter.hasNext())
  			{
				var wrapDoc:WrapDataDocument = iter.next() as WrapDataDocument;
				wrapDoc.dataDocument.visible = true;
  			}
  		}
  		private function onFilterApplica(e:TLFilterEvent):void
  		{
  			// array di array
  			var listItems:Array = e.getList();
  			var tLineSpec:TLineSpecification 	= new TLineSpecification(listItems);
  			var iter:IIterator 					= new ArrayIterator( listWrap );
  			while(iter.hasNext())
  			{
				var wrapDoc:WrapDataDocument = iter.next() as WrapDataDocument;
				wrapDoc.dataDocument.visible = tLineSpec.isSatisfiedBy( wrapDoc );
  			}
  		}
	
		private function addListenerRoll():void
		{
			addRoll(filtri.tDati);
			addRoll(filtri.tDCE);
			addRoll(filtri.pdt);
			addRoll(filtri.discipline);
			addRoll(filtri.farmaci);
			addRoll(filtri.prestazioni);
		}
		private function addRoll(t:UIComponent):void
		{
			 t.addEventListener(MouseEvent.ROLL_OVER,onRollOver);
			 t.addEventListener(MouseEvent.ROLL_OUT,onRollOut);
		}
		private function onRollOver(e:MouseEvent):void
		{
			var ui:ResizableBoxFiltri 	= e.target as ResizableBoxFiltri;
			var tip:String		= "Nessuna voce selezionata";	
			var selected:Array	= ui.list.selectedItems;
			var res:String		= "";
			if(selected!=null)
			{
				for(var i:uint = 0;i<selected.length;i++)
				{
					res += selected[i] + "\n";
				}
				if(res.length>0)
				{
					tip = "Le voci selezionate sono\n"+res;
				}
			}
			ui.toolTip = tip;
		}
		private function onRollOut(e:MouseEvent):void{}
		 					 
		override protected function finalize():void
		{   }
		  
		/**
		 * al click sull'oggetto grafico che rappresenta il dataDocument 
		 * @param e
		 */		
		private function onClickDocument(e:DataDocumentEvent):void
		{
			if(isClickPopup(e))
			{
				openPopUpTimeLine(e);
			}
		}
		/** 
		 * @param e
		 * @return 
		 * 
		 */		
		private function isClickPopup(e:DataDocumentEvent):Boolean
		{
			return true;
		}
		 
		private function openPopUpTimeLine(e:DataDocumentEvent):void
		{
  			if(pop==null)
		 	{
		 		pop 		= new Popup();
		 		pop.addEventListener(CloseEvent.CLOSE,onClose);
		 	}
		 	pop.titolo		= getTitolo(e.dataDocument);
		 	pop.body		= BodyPopUpVT.getBody(  e.dataDocument );
		 	var col:int 	= e.dataDocument.getStyle("themeColor");
		 	pop.bckColor	= col;
		 	ViewMessageManager.getInstance().showPanel(pop,0xCCCCCC,{width:400,height:350}); 
		}
		
		private function onClose(e:CloseEvent):void
		{
			if(pop!=null)
			{
				ViewMessageManager.getInstance().closeDisplayer();
			}
		}
		//////////////////////////////////////////////////
		/**
		 * titolo della popup 
		 * @param item
		 * @return 
		 * 
		 */		
		
		private function getTitolo(item:DataDocument):String
		{
			 if(item.data!=null)
			 {
			 	if(item.data is SetDocumentale)
			 	{
			 		var setDoc:SetDocumentale = item.data as SetDocumentale;
					if(setDoc.tipoDocumento!=null && setDoc.tipoDocumento.descrizione!=null && setDoc.tipoDocumento.descrizione.length>0)
					{
					 	return (setDoc.tipoDocumento.descrizione as String).toUpperCase();
					}
			 	}else if(item.data is Evento)
			 	{
			 		var evento:Evento = item.data as Evento;
			 		if(evento!=null && evento.tipoEvento!=null && evento.tipoEvento.codice!=null && evento.tipoEvento.codice.length>0)
					{
						var cod:int = Number(evento.tipoEvento.codice);
						switch(cod)
						{
							case TransformDataTimeLineBase.RICOVERO:
								return "RICOVERO";
							case TransformDataTimeLineBase.PRONTO_SOCCORSO:
								return "PRONTO SOCCORSO";
							case TransformDataTimeLineBase.DIAGNOSTICO:
								return "SPECIALISTICA AMBULATORIALE";
							case TransformDataTimeLineBase.FARMACEUTICO:
								return "FARMACEUTICA";
						}
					}
			 	}else if(item.data is Programmazione)
			 	{
			 		var prog:Programmazione = item.data as Programmazione;
			 		if(prog!=null && prog.tipoPrestazione!=null && prog.tipoPrestazione.codice!=null && prog.tipoPrestazione.codice.length>0)
			 		{
			 			var code:String = prog.tipoPrestazione.codice;
			 			switch(code)
			 			{
			 				case  ConstPrestazioni.FARMACEUTICA:
			 					return "PRESTAZIONE PROGRAMMATA - FARMACEUTICA"; 
			 				case  ConstPrestazioni.SPECIALISTICA_AMBULATORIALE:
			 				case  ConstPrestazioni.MMG:
			 					return "PRESTAZIONE PROGRAMMATA - SPECIALISTICA"; 
			 				case  ConstPrestazioni.VACCINALE:
			 				case  ConstPrestazioni.ALTRE:
			 				case  ConstPrestazioni.AUTORILEVAZIONE:
			 				case  ConstPrestazioni.PROTESICA:
			 				case  ConstPrestazioni.ASSISTENZA:
			 				case  ConstPrestazioni.EDUCAZIONE:
			 				case  ConstPrestazioni.PRESTAZIONI:
			 				 	return "PRESTAZIONE PROGRAMMATA"; 
			 			}
			 		}
			 	}
			 }
			return "";
		}
	}
}