package com.li.dc.sebc.turboFSE.view.viste
{
	import com.li.dc.sebc.turboFSE.util.ArrayCollectionIterator;
	import com.li.dc.sebc.turboFSE.util.CreateComp;
	
	import it.lispa.siss.sebc.flex.collection.IIterator;
	import it.lispa.siss.sebc.middleground.entity.Patologia;
	
	import mx.collections.ArrayCollection;
	import mx.containers.VBox;
	import mx.controls.DataGrid;
	import mx.controls.HRule;
	import mx.controls.Label;
	import mx.controls.dataGridClasses.DataGridColumn;
	import mx.formatters.DateFormatter;
	import com.li.dc.sebc.turboFSE.util.UtilDate;
	
	public class VaccinazioniVista extends Vista
	{
		public var vbox:VBox;
		public function VaccinazioniVista( )
		{
			super();
			createVBox();
		}
		private function createVBox():void
		{
		  	vbox = CreateComp.getBoxWithScroll(); 
			this.addChild( vbox );
		} 
		override protected function updateData():void
		{
			if(dataVista!=null)
			{
				createVBox();
				createTitolo();
				var iter:IIterator = new ArrayCollectionIterator( dataVista as ArrayCollection );
			 	while(iter.hasNext())
			 	{
			 		var pat:Patologia = iter.next() as Patologia;
			 		try{
				 		if(pat.patologia.descrizione != null && pat.patologia.descrizione.length>0)
						{
							var vaccinazioni:ArrayCollection = pat.elencoVaccinazioni;
							if(vaccinazioni.length>0)
							{
								var bxgrid:VBox 		= getBoxDescrizione(pat.patologia.descrizione);
								var dataGrid:DataGrid 	= getDataGrid();
								dataGrid.verticalScrollPolicy = "off";
								var col1:DataGridColumn = new DataGridColumn();
								var col2:DataGridColumn = new DataGridColumn();
								col1.setStyle( "textAlign","left" );
								col2.setStyle( "textAlign","left" );
								
								col1.headerText 		= "Data somministrazione";
								col1.dataField  		= "dataErogazione";
								col1.labelFunction = formatVaccinazioneDate;
								col1.width				= 165;
								col2.headerText 		= "Vaccini";
								col2.dataField  		= "descrizioneVaccinazione"
								//
								dataGrid.columns 		= [col1,col2];
								dataGrid.rowCount 		= vaccinazioni.length;
								dataGrid.dataProvider 	= vaccinazioni;
								bxgrid.addChild(  dataGrid ); 
								vbox.addChild( bxgrid );
							}
						}
			 		}catch(e:Error){}
			 	}
			}
		}
		private function getDataGrid():DataGrid
		{
			var dataGrid:DataGrid = new DataGrid();
			dataGrid.percentWidth = 100;
			dataGrid.editable = false; 
			dataGrid.selectable = false; 
			dataGrid.resizableColumns = true; 
			dataGrid.variableRowHeight = true; 
			dataGrid.setStyle("verticalAlign","middle");
			dataGrid.setStyle("textAlign","center");
			return dataGrid;
		}
		private function getBoxDescrizione(descrizione:String):VBox
		{
			var bxgrid:VBox 		= CreateComp.createBox();
			//bxgrid.styleName		= "vaccBox";
			bxgrid.setStyle("backgroundColor",0xeff1f2);
			bxgrid.percentHeight 	= 100;
			var lb:Label   			= CreateComp.getLabelLabel();
			lb.setStyle("color",0);
			lb.text					= descrizione;
			bxgrid.addChild( lb );
			return bxgrid;
		}
		private function createTitolo():void
		{
			var lab:Label 	= CreateComp.getLabelValue();
			lab.setStyle("fontSize",12);
			lab.text 		= "Elenco Patologie";
			vbox.addChild( lab );
			var hrule:HRule 	= new HRule()
			hrule.percentWidth 	= 100;
			hrule.height		= 2;
			vbox.addChild( hrule );
		}
		
		public  function formatVaccinazioneDate(rowItem:Object,column:DataGridColumn):String
		{
			/*var formatterTo:DateFormatter = new DateFormatter();
			formatterTo.formatString	= "DD/MM/YYYY";
			
			var formatterFrom:DateFormatter = new DateFormatter();
			formatterFrom.formatString	= "YYYYMMDD";*/
			
			if(rowItem.dataErogazione == ""){
				return "";	
			}
			
			/*var myDate:Date = DateFormatter.parseDateString(rowItem.dataErogazione);*/
			
			return 	UtilDate.getStringData(rowItem.dataErogazione);
		}
		
		
		
	}
}