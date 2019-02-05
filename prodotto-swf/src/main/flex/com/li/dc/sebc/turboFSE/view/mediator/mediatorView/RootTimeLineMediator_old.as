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
	import com.li.dc.sebc.turboFSE.view.component.Popup;
	import com.li.dc.sebc.turboFSE.view.component.PopupTimeline;
	import com.li.dc.sebc.turboFSE.view.component.ResizableBoxFiltri;
	import com.li.dc.sebc.turboFSE.view.component.TimelineFilter;
	import com.li.dc.sebc.turboFSE.view.nodeView.RootTimeLine;
	
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
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
	
	import mx.core.UIComponent;
	import mx.events.CloseEvent;
	import mx.utils.ColorUtil;
	
	use namespace sebwebsiss;
	public class RootTimeLineMediator_old extends Mediator
	{
		//////////////////////////////////////////////////////
		private var enableLabel:Dictionary;
		// il canvas vuoto che fa da segna posto per i tab
		private var rootTimeline:RootTimeLine;
		// la popup dove all'interno c'è la timeline
		private var popup:PopupTimeline;
		// la popup interna alla timeline che visualizza i valori del data
		private var pop:Popup;
		// la timeline vera e propria
		private var timeline:TimeLine;
		// i filtri della popup
		private var filtri:TimelineFilter;
		private var tr:TransformDataTimeLine;

		private var docs:Array;
		private var listWrap:Array;

		private var changedDataTimeLine:Boolean = false;
		 
		public function RootTimeLineMediator()
		{
			super();
		}
		override protected function initialize( ):void
		{
			rootTimeline = (this.view as RootTimeLine);
			initializeData();
		}
		private function initializeData():void
		{
			enableLabel 		= new Dictionary();
			var model:FSEModel 	= FSEModel.getInstance();
			model.retrieveProxy(ConstDataProxy.DATA_TIMELINE).addEventListener(DataProxyEvent.DATA_UPDATE,onUpdateDataTimeline);
			model.retrieveProxy(ConstDataProxy.OPENPOPUPTIMELINE).addEventListener(DataProxyEvent.DATA_UPDATE,onOpenTab);
		}
		/**
		 * quando arrivano i nuovi dati da remoto
		 * @param e
		 * 
		 */		
		private function onUpdateDataTimeline(e:DataProxyEvent):void
		{
			tr							 	= new TransformDataTimeLine(e.getData() as Array);
			// la lista dei dataDocument
			docs 			 				= tr.execute();
			// la lista dei wrap dei dataDocument
			listWrap						= tr.getListWrap();
			if(docs!=null)
			{
				changedDataTimeLine = true;
				setPopUp(docs);
			}
		}
		private function onOpenTab(e:DataProxyEvent):void
		{
			recursivePopup();
			/*if(ViewMessageManager.getInstance().popUpBusy())
			{
			
			}*/
			
		}
		private function recursivePopup():void
		{
			if(ViewMessageManager.getInstance().popUpBusy())
			{
				recursivePopup();
			}else
			{
				// apro (visualizzo) la popup della timeline
				openPopup( );
				// aspetto un frame
				Later.doLater(setPopUp,0,docs);
			}
		}
		private function openPopup():void
		{
			var model:FSEModel 	= FSEModel.getInstance();
			if(popup==null)
			{
				popup 					= new PopupTimeline();
				popup.showCloseButton 	= true;
				popup.addEventListener(CloseEvent.CLOSE,onCloseTab);
			}
			//popUpBusy
			ViewMessageManager.getInstance().showPanel(popup,HTMLTabColor.AQUA,{horizontal:0,vertical:0});
			//popup.width		= rootTimeline.width;
			//popup.height	= rootTimeline.height;
			//rootTimeline.addChild( popup );
		 	
		 	if(timeline==null)
			{
				timeline = popup.timeline;
				initTimeline();
			}
			if(filtri==null)
			{
				filtri = popup.filt;
				initFilter();
				createDataFilter(tr);
			}		
		}
		private function setPopUp(docs:Array):void
		{
			if(changedDataTimeLine && popup!=null)
			{ 
				// aspetto un frame
				Later.doLater(setDataDocument);
				changedDataTimeLine = false;
			}
		}
		private function setDataDocument():void
		{
			timeline.dataDocument	= docs; 
		}
		private function onCloseTab(e:CloseEvent):void
		{
			//ViewMessageManager.getInstance().closeDisplayer();
			if(popup!=null)
			{
				//rootTimeline.removeChild( popup );
				ViewMessageManager.getInstance().closeDisplayer();
				var model:FSEModel = FSEModel.getInstance();
				model.retrieveProxy(ConstDataProxy.DATA_AREATAB).update(FSEModel.getInstance().oldIndexTab);
			}
		}
		private function initFilter():void
		{
			 filtri.lab_tipologie_dati 	= "Tipologie Dati";
			 filtri.lab_tipologie_DCE 	= "Tipologie DCE";
			 filtri.lab_PDT				= "PDT";
			 filtri.lab_farmaci			= "Elenco Farmaci";
			 filtri.lab_discipline		= "Elenco Discipline";
			 filtri.lab_prestazioni		= "Elenco Prestzioni";
			 filtri.addEventListener(TLFilterEvent.TLFILTER_EVENT,onFilterApplica);
			 filtri.addEventListener(TurboEvent.RESET_EVENT,onResetFiltri);
		} 
	 	private function initTimeline():void
		{
			timeline.addEventListener(DataLabelEvent.DATA_LABEL_CHANGE_ENABLED,onChangeEnabledDataLabel);
			timeline.addEventListener(DataDocumentEvent.CHANGE_STATE_EVENT,onChangeStateEvent);
			timeline.addEventListener(DataDocumentEvent.CLICK_DOCUMENT_EVENT,onClickDocument);
			timeline.addEventListener(MenuItemSelect.MENU_ITEM_SELECT,onMenuItemSelect);
			timeline.addEventListener(TLHelpEvent.TL_HELP_EVENT,onHelpEvent);
			//timeline.buttonInfo = rootTimeline.info;
			timeline.setStyle("windowScroll",6);
			timeline.setStyle("calendarStyle","small"); 
			timeline.setStyle("effectCalendarBlur","none");
	  		timeline.setStyle("columnYearColor",HTMLTabColor.WHITESMOKE);  	
	  		timeline.setStyle("formatColorYear",HTMLTabColor.BLANCHEDALMOND);
	  		timeline.setStyle("columnDayColor",HTMLTabColor.ALICEBLUE);  	
			timeline.setStyle("columnWeekColor",HTMLTabColor.YELLOW);  	   
			timeline.setStyle("columnMonthColor",HTMLTabColor.WHITESMOKE);  	   
			timeline.setStyle("rollOutScrollColor",HTMLTabColor.WHITESMOKE);  	  
			timeline.setStyle("rollOverScrollColor",HTMLTabColor.AZURE);  	  
			timeline.setStyle("colorLineCalendar",HTMLTabColor.YELLOW);  	  
			timeline.setStyle("themeColor",HTMLTabColor.DARKSEAGREEN);  	  
			timeline.setStyle("bckColor",HTMLTabColor.WHITESMOKE);  	  
			timeline.setStyle("bckAlpha",0.5);
			
			var dt:Date 			= new Date();
			var model:FSEModel 		= FSEModel.getInstance();
			model.startYearTimeline	= dt.fullYear-4;
			model.endYearTimeline	= dt.fullYear+1; 
			

			var dif:int 			= model.endYearTimeline + 1 - model.startYearTimeline;
			var dilay:int 			= (dif > 5) ? 5 :((dif<1)?1:dif);
			timeline.setStyle("visibleYear",dilay);
			// da quale punto inizia la timeline
			timeline.startYear		= model.startYearTimeline;
			timeline.endYear		= model.endYearTimeline;
			
			timeline.dataLabels = getDataLabels();
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
  			var col:Array = UtilsColor.dilayColors(HTMLTabColor.BLUE,HTMLTabColor.GREEN,4);
  			var t:Array = new Array();
  			for(var i:uint = 0;i<4;i++)
  			{
  				var dt:DataLabel = new DataLabel(); 	
  				dt.color	= col[i];
  				dt.idBand	= i;	
  				dt.label	= getLabelDLabel(i);
  				enableLabel[dt.idBand] = true;
  				t.push( dt );
  			} 
  			return t;
  			// TurboEvent
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
		/**
		 * estrae i dati per i filtri 
		 * @param docs
		 * 
		 */		
		private function createDataFilter(tr:TransformDataTimeLine):void
		{
			 filtri.list_tipologie_dati 	= tr.getTipologieDati();
			 filtri.list_tipologie_DCE 		= tr.getTipologieDCE();
			 filtri.list_PDT 				= tr.getElencoPDT();
			 filtri.list_farmaci 			= tr.getElencoFarmaci();
			 filtri.list_discipline 		= tr.getElencoDiscipline();
			 filtri.list_prestazione		= tr.getElencoPrestazione();
			 addListenerRoll();
		}
		private function addListenerRoll():void
		{
			addRoll(filtri.tDati);
			addRoll(filtri.tDCE);
			addRoll(filtri.pdt);
			addRoll(filtri.discipline);
			addRoll(filtri.farmaci);
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
  			var p:Point			= popup.globalToLocal( new Point(e.stageX,e.stageY) ); 
			var cx:Number 		= timeline.x + timeline.width/2;
			var lt:Boolean 		= (p.x >= cx);
			var r:Rectangle		= new Rectangle(lt ? timeline.x : p.x,
												timeline.y,
												lt ? ( p.x-timeline.x):((timeline.x + timeline.width)-p.x),
												timeline.height);
			    
		 	if(pop==null)
		 	{
		 		pop 		= new Popup();
		 		 
		 		pop.addEventListener(CloseEvent.CLOSE,onClose);
		 	}
		 	
		 	pop.x = r.x + (r.width-pop.width)/2;
		 	pop.y = (r.height-pop.height)/2;
		 	
		 	pop.titolo		= getTitolo(e.dataDocument);
		 	pop.body		= BodyPopUpVT.getBody(  e.dataDocument );
		  
		 	pop.bckColor	= ColorUtil.adjustBrightness( e.dataDocument.getStyle("themeColor") ,100);
		 	// vedremo in seguito
		 	//popup.addChild( getFoglioTrasparente() );
		 	popup.addChild( pop );
		}
		
		private function onClose(e:CloseEvent):void
		{
			var pop:Popup 	= e.target as Popup;
			popup.removeChild( pop );
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
					 	return setDoc.tipoDocumento.descrizione; 
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
								return "EVENTO RICOVERO";
							case TransformDataTimeLineBase.PRONTO_SOCCORSO:
								return "EVENTO PRONTO SOCCORSO";
							case TransformDataTimeLineBase.DIAGNOSTICO:
								return "EVENTO DIAGNOSTICO";
							case TransformDataTimeLineBase.FARMACEUTICO:
								return "EVENTO FARMACEUTICO";
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
			 					return "PROGRAMMAZIONE FARMACEUTICA"; 
			 				case  ConstPrestazioni.SPECIALISTICA_AMBULATORIALE:
			 				case  ConstPrestazioni.MMG:
			 					return "PROGRAMMAZIONE SPECIALISTICA"; 
			 				case  ConstPrestazioni.VACCINALE:
			 				case  ConstPrestazioni.ALTRE:
			 				case  ConstPrestazioni.AUTORILEVAZIONE:
			 				case  ConstPrestazioni.PROTESICA:
			 				case  ConstPrestazioni.ASSISTENZA:
			 				case  ConstPrestazioni.EDUCAZIONE:
			 				case  ConstPrestazioni.PRESTAZIONI:
			 				 	return "PROGRAMMAZIONE"; 
			 			}
			 		}
			 	}
			 }
			return "";
		}
		  
	}
}