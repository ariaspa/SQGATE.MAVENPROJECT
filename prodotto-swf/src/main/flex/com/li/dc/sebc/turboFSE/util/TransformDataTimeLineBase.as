package com.li.dc.sebc.turboFSE.util
{
	import com.li.dc.sebc.turboFSE.model.ConstPrestazioni;
	import com.li.dc.sebc.turboFSE.model.ConstTimeLine;
	import com.li.dc.sebc.turboFSE.view.skin.tl.SkinDocument;
	import com.li.dc.sebc.turboFSE.view.skin.tl.SkinLine;
	import com.li.dc.sebc.turboFSE.view.skin.tl.SkinRectThick;
	import com.li.dc.sebc.turboFSE.view.skin.tl.SkinRectThickSelect;
	import com.li.dc.sebc.turboFSE.view.skin.tl.SkinTriangular;
	import com.li.dc.sebc.turboFSE.view.skin.tl.SkinTriangularSelect;
	
	import it.lispa.siss.sebc.flex.collection.ArrayIterator;
	import it.lispa.siss.sebc.flex.collection.IIterator;
	import it.lispa.siss.sebc.flex.color.HTMLTabColor;
	import it.lispa.siss.sebc.flex.graphic.timeline.model.DataDocument;
	import it.lispa.siss.sebc.flex.graphic.timeline.model.ItemMenu;
	import it.lispa.siss.sebc.middleground.entity.Evento;
	import it.lispa.siss.sebc.middleground.entity.Programmazione;
	import it.lispa.siss.sebc.middleground.entity.SetDocumentale;
	
	public class TransformDataTimeLineBase
	{
		public static const FARMACEUTICO:int		= 1;
		public static const DIAGNOSTICO:int			= 2;
		public static const RICOVERO:int			= 3;
		public static const PRONTO_SOCCORSO:int		= 5;
		//////////////////////////////////////////////////////
		private var _tml:Array;
		private var minYear:int = 1000000;
		private var maxYear:int = 0;
		protected  function get tml():Array
		{
			return _tml; 
		}
		public function TransformDataTimeLineBase(tmlin:Array)
		{
			_tml = tmlin;
		}
		public function execute():Array
		{
			var res:Array		= new Array();   
			var iter:IIterator 	= new ArrayIterator(this.tml);
			while(iter.hasNext())
			{
				var item:Object  	 	= iter.next();
				var datestart:String 	= item.dateStart;
				 
				var dateIni:Date		= getDateIni(datestart);
				if(dateIni!=null)
				{
					//checkData(dateIni);
					var band:int 				= getBand( item );
				 	if(band>=0)
				 	{
					 	var id:String			= item.id;
						var doc:DataDocument    = new DataDocument(id ,band,dateIni,DataDocument.DEFAULT);
						doc.dateEnd				= getDateEnd(item.dateEnd);
							
						doc.data				= item.data;
						setSkines(doc,item);
						//doc.setStyle("skin",ButtonSkin);
						doc.tooltip				= item.tooltip; 
						doc.idFather			= item.father;
						doc.visible				= true; 
						if(item.children!=null && item.children.length>0)
						{
							doc.children		= item.children.toArray();
						}
						doc.feedbackClass		= getFeedbackClass(item);
						setItemsMenu(doc,item);
						setStyles(doc,item); 
						setFilter(doc);
						  
						if(doc.dateEnd==null && !isIcon(doc))
						{
							doc.dateEnd	= new Date(dateIni.fullYear,dateIni.month,dateIni.date + 1);
						}
						res.push( doc );
				 	}
				}
			}
			return res;
		}
		/* refuso da controllare l'utilizzo 
		protected final function checkData(dateIni:Date):void
		{
			if(minYear>dateIni.fullYear)
			{
				minYear = dateIni.fullYear;
			}
			if(maxYear<dateIni.fullYear)
			{
				maxYear = dateIni.fullYear;
			}
		}  */
		public function grtMaxYear():Number
		{
			return maxYear;
		}
		public function grtMinYear():Number
		{
			return minYear;
		}
		protected function getDateEnd(dt:String):Date
		{
			return getDateFromString(dt);
		}
		protected function getDateIni(dt:String):Date
		{
			return getDateFromString(dt);
		}
		private function getDateFromString(dt:String):Date
		{
			if(dt==null || dt.length<8)
			{
				return null;
			}
			return UtilDate.fromStringToDate(dt);
		}
		protected function getFeedbackClass(item:Object):Class
		{
			return null;
		}
		protected function setStyles(doc:DataDocument,item:Object):void
		{
			// sono gli styles dei bottoni
			var theme:uint	=  getThemeColor(doc);
			doc.setStyle("themeColor", theme);
  			doc.setStyle("fillColors",[0xFFFFFF,theme]);
  			doc.setStyle("fillAlphas",[0.2,0.7]);
  			doc.setStyle("cornerRadius",0);
		}
		protected function setFilter(doc:DataDocument):void{}
		//../resources/images/ico_copia_18.gif
		protected function setSkines(doc:DataDocument,item:Object):void
		{
			var clazz:Class 		= null;
			var clazzSelect:Class 	= null;
			if(isTriangular(doc))
			{
				clazz 		= SkinTriangular;
				clazzSelect = SkinTriangularSelect;
			// setDocumentale eccetto tipo 26
			}else if(isIcon(doc))
			{
				clazz 		= SkinDocument;
				clazzSelect = SkinDocument;
				// programmazione +tipo 26
			}else if(isLinear(doc))
			{
				clazz 		= SkinLine;
				clazzSelect = SkinRectThickSelect;
				 
			}else if(isRectThin(doc))
			{
				clazz = SkinRectThick;
				clazzSelect = SkinRectThickSelect;
			}
			
			// vecchia gestione
			/*  if(isCircleThick(doc))
			{
				clazz = SkinCircleThick;
				clazzSelect = SkinCircleThickSelect;
			}else if(isCircleThin(doc))
			{
				clazz = SkinCircleThin;
				clazzSelect = SkinCircleThinSelect;
			}else if(isRectThick(doc))
			{
				clazz = SkinRectThick;
				clazzSelect = SkinRectThickSelect;
			}else if(isRectThin(doc))
			{
				clazz = SkinRectThin;
				clazzSelect = SkinRectThinSelect;
			}else if(isRectDashed(doc))
			{
				clazz = SkinRectDashed;
				clazzSelect = SkinRectDashedSelect;
			}  */
			if(clazz!=null)
			{
				doc.addSkin(DataDocument.DEFAULT,clazz); 
				doc.addSkin("select",clazzSelect); 
			}
		}
		 
		private function isLinear(doc:DataDocument):Boolean
		{
			return (doc.data!=null && (doc.data is Programmazione || (doc.data is SetDocumentale && !isIcon(doc))));
		}
		private function isIcon(doc:DataDocument):Boolean
		{
			if(doc.data!=null && doc.data is SetDocumentale)
			{
				var setDoc:SetDocumentale = doc.data as SetDocumentale;
				if(setDoc.tipoDocumento!=null && setDoc.tipoDocumento.codice!=null && setDoc.tipoDocumento.codice.length>0)
				{
					return !(Number(setDoc.tipoDocumento.codice) == 26);	
				}
			}
			return false;
		}
		private function isTriangular(doc:DataDocument):Boolean
		{
			return (doc.data!=null && doc.data is Evento && !isRectThin(doc));
		}
		
		
		
		protected function setItemsMenu(doc:DataDocument,item:Object):void
		{
			if(item.children!=null && item.children.length>0)
			{
				// è un padre
				doc.addItemMenu(new ItemMenu("seleziona programmazione"));
				doc.addItemMenu(new ItemMenu("deseleziona programmazione",false,false));
			}else if(item.father!=null && item.father.length>0)
			{
				// è un figlio
				doc.addItemMenu(new ItemMenu("seleziona padre"));
				doc.addItemMenu(new ItemMenu("deseleziona padre",false,false));
			}
		}
		private function isCircleThick(doc:DataDocument):Boolean
		{
			if(doc.data!=null)
			{
				if(doc.data is SetDocumentale)
				{
					var setDoc:SetDocumentale = (doc.data as SetDocumentale);
					if(setDoc.tipoDocumento!=null && setDoc.tipoDocumento.codice!=null && setDoc.tipoDocumento.codice.length>0)
					{
						var cod:int	= Number(setDoc.tipoDocumento.codice);
						if(cod>5)
						{
							if(doc.dateEnd==null)
							{
								return true;
							}
						}
						switch(cod)
						{
							case 1:
							case 2:
							case 3:
							case 4:
							case 5:
							return true;
						}
					}
				} 
			}
			return false;
		}
		private function isCircleThin(doc:DataDocument):Boolean
		{
			if(doc.data!=null)
			{
				if(doc.data is Evento)
				{
					var evento:Evento = doc.data as Evento;
					if(evento!=null && evento.tipoEvento!=null && evento.tipoEvento.codice!=null && evento.tipoEvento.codice.length>0)
					{
						var cod:int = Number(evento.tipoEvento.codice);
						switch(cod)
						{
							case FARMACEUTICO:
							case PRONTO_SOCCORSO:
							case DIAGNOSTICO:
							return true; 
						}
					}
				}
			}
			return false;
		}
	 
		private function isRectThick(doc:DataDocument):Boolean
		{
			if(doc.data!=null)
			{
				if(doc.data is SetDocumentale)
				{
					var setDoc:SetDocumentale = (doc.data as SetDocumentale);
					if(setDoc.tipoDocumento!=null && setDoc.tipoDocumento.codice!=null && setDoc.tipoDocumento.codice.length>0)
					{
						var cod:int	= Number(setDoc.tipoDocumento.codice);
						if(cod>5)
						{
							if(doc.dateEnd!=null)
							{
								return true;
							}
						}
					}
				} 
			}
			return false;
		}
		private function isRectThin(doc:DataDocument):Boolean
		{
			if(doc.data!=null)
			{
				if(doc.data is Evento)
				{
					var evento:Evento = doc.data as Evento;
					if(evento!=null && evento.tipoEvento!=null && evento.tipoEvento.codice!=null && evento.tipoEvento.codice.length>0)
					{
						var cod:int = Number(evento.tipoEvento.codice);
						if(cod==RICOVERO)
						{
							return true;
						}
					}
				}
			}
			return false;
		}
		private function isRectDashed(doc:DataDocument):Boolean
		{
			if(doc.data!=null)
			{
			  	if(doc.data is Programmazione)
				{
					return true;
				} 
			}
			return false;
		}
		private function getThemeColor(doc:DataDocument):uint
  		{
  			 
  			if(isAzure(doc))
  			{
  				return 0x0E2BE6;
  			}else if(isRed(doc))
  			{
  				return HTMLTabColor.RED;
  			}else if(isOrange(doc))
  			{
  				return HTMLTabColor.ORANGE;
  			}else if(isGreen(doc))
  			{
  				return HTMLTabColor.GREEN;
  			}
  			// unknow
  			return 0x707538;
  		} 
		
  		private function isAzure(doc:DataDocument):Boolean
  		{
  			if(doc.data!=null)
			{
				var cod:int;	
				if(doc.data is SetDocumentale)
				{
					var setDoc:SetDocumentale = (doc.data as SetDocumentale);
					if(setDoc.tipoDocumento!=null && setDoc.tipoDocumento.codice!=null && setDoc.tipoDocumento.codice.length>0)
					{
						cod	= Number(setDoc.tipoDocumento.codice);
						switch(cod)
						{
							case 1:
							case 2:
							case 3:
							return true;
						}
					}
				}else if(doc.data is Evento)
				{
					var evento:Evento = doc.data as Evento;
					cod = -1;
					if(evento!=null && evento.tipoEvento!=null && evento.tipoEvento.codice!=null && evento.tipoEvento.codice.length>0)
					{
						cod = Number(evento.tipoEvento.codice);
						if(cod==DIAGNOSTICO)
						{
							return true;
						}
					}
				}else 	if(doc.data is Programmazione)
				{
					var prog:Programmazione = doc.data as Programmazione;
					if(prog!=null && prog.tipoPrestazione.codice!=null && prog.tipoPrestazione.codice!=null && prog.tipoPrestazione.codice.length>0)
					{
						var code:String = prog.tipoPrestazione.codice;
						if(code == ConstPrestazioni.SPECIALISTICA_AMBULATORIALE
						|| code == ConstPrestazioni.MMG)
						{
							return true;
						}
					}
				} 
			}
			return false;
  		}
  		private function isRed(doc:DataDocument):Boolean
  		{
  			if(doc.data!=null)
			{
				if(doc.data is SetDocumentale)
				{
					var setDoc:SetDocumentale = (doc.data as SetDocumentale);
					if(setDoc.tipoDocumento!=null && setDoc.tipoDocumento.codice!=null && setDoc.tipoDocumento.codice.length>0)
					{
						var cod:int	= Number(setDoc.tipoDocumento.codice);
						if(cod==4)
						{
							return true;
						}
					}
				}else if(doc.data is Evento)
				{
					var evento:Evento = doc.data as Evento;
					if(evento!=null && evento.tipoEvento!=null && evento.tipoEvento.codice!=null && evento.tipoEvento.codice.length>0)
					{
						var cod:int = Number(evento.tipoEvento.codice);
						if(cod==PRONTO_SOCCORSO)
						{
							return true;
						}
					}
				}
			}
			return false;
  		}
  		private function isGreen(doc:DataDocument):Boolean
  		{
  			if(doc.data!=null)
			{
				if(doc.data is Evento)
				{
					var evento:Evento = doc.data as Evento;
					if(evento!=null && evento.tipoEvento!=null && evento.tipoEvento.codice!=null && evento.tipoEvento.codice.length>0)
					{
						var cod:int = Number(evento.tipoEvento.codice);
						if(cod==FARMACEUTICO)
						{
							return true;
						}
					}
				}else 	if(doc.data is Programmazione)
				{
					//var prog:Programmazione = doc.data as Programmazione;
					// programmazione farmaci
					//return true;
					var prog:Programmazione = doc.data as Programmazione;
					if(prog!=null && prog.tipoPrestazione!=null && prog.tipoPrestazione.codice!=null && prog.tipoPrestazione.codice.length>0)
					{
						var code:String = prog.tipoPrestazione.codice;
						if(code == ConstPrestazioni.FARMACEUTICA)
						{
							return true;
						}
					}
				} 
			}
			return false;
  		}
  		private function isOrange(doc:DataDocument):Boolean
  		{
  			if(doc.data!=null)
			{
				if(doc.data is SetDocumentale)
				{
					var setDoc:SetDocumentale = (doc.data as SetDocumentale);
					if(setDoc.tipoDocumento!=null && setDoc.tipoDocumento.codice!=null && setDoc.tipoDocumento.codice.length>0)
					{
						var cod:int	= Number(setDoc.tipoDocumento.codice);
						if(cod==5)
						{
							return true;
						}
					}
				}else if(doc.data is Evento)
				{
					var evento:Evento = doc.data as Evento;
					if(evento!=null && evento.tipoEvento!=null && evento.tipoEvento.codice!=null && evento.tipoEvento.codice.length>0)
					{
						var cod:int = Number(evento.tipoEvento.codice);
						if(cod==RICOVERO)
						{
							return true;
						}
					}
				}else if(doc.data is Programmazione)
				{
					//var prog:Programmazione = doc.data as Programmazione;
					// programmazione ricovero
					//return true;
					/*var prog:Programmazione = doc.data as Programmazione;
					if(prog!=null && prog.prestazione!=null && prog.prestazione.codice!=null && prog.prestazione.codice.length>0)
					{
						var code:String = prog.prestazione.codice;
						if(code == ConstPrestazioni.
						|| code == ConstPrestazioni.MMG)
						{
							return true;
						}
					}*/
				} 
			}
			return false;
  		}
		protected function getBand(item:Object):int
		{
			 if(item.data!=null)
			 {
			 	if(item.data is SetDocumentale)
			 	{
			 		var setDoc:SetDocumentale = item.data as SetDocumentale;
					if(setDoc.tipoDocumento!=null && setDoc.tipoDocumento.codice!=null && setDoc.tipoDocumento.codice.length>0)
					{
						var cod:int	= Number(setDoc.tipoDocumento.codice);
						if(cod==5 || cod == 4)
						{
							return ConstTimeLine.RICOVERO_PS_BAND; 
						}else if(cod==1 || cod == 2 || cod == 3)
						{
							return ConstTimeLine.SPECIALISTICO_BAND; 
						}else
						{
							return ConstTimeLine.ALTRO_BAND; 
						}
					}
			 	}else if(item.data is Evento)
			 	{
			 		var evento:Evento = item.data as Evento;
			 		if(evento!=null && evento.tipoEvento!=null && evento.tipoEvento.codice!=null && evento.tipoEvento.codice.length>0)
					{
						var cod:int = Number(evento.tipoEvento.codice);
						if(cod==RICOVERO || cod == PRONTO_SOCCORSO)
						{
							return ConstTimeLine.RICOVERO_PS_BAND; 
						}else if(cod==DIAGNOSTICO)
						{
							return ConstTimeLine.SPECIALISTICO_BAND; 
						}else if(cod==FARMACEUTICO || cod==4 )
						{
							return ConstTimeLine.FARMACEUTICO_BAND; 
						}else
						{
							return ConstTimeLine.ALTRO_BAND; 
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
			 					return ConstTimeLine.FARMACEUTICO_BAND; 
			 				case  ConstPrestazioni.SPECIALISTICA_AMBULATORIALE:
			 				case  ConstPrestazioni.MMG:
			 					return ConstTimeLine.SPECIALISTICO_BAND; 
			 				case  ConstPrestazioni.VACCINALE:
			 				case  ConstPrestazioni.ALTRE:
			 				case  ConstPrestazioni.AUTORILEVAZIONE:
			 				case  ConstPrestazioni.PROTESICA:
			 				case  ConstPrestazioni.ASSISTENZA:
			 				case  ConstPrestazioni.EDUCAZIONE:
			 				case  ConstPrestazioni.PRESTAZIONI:
			 				 	return ConstTimeLine.ALTRO_BAND; 
			 			}
			 		}
			 	}
			 }
			return -1;
		}
		
	}
}