package com.li.dc.sebc.turboFSE.view.viste
{

	import com.li.dc.sebc.turboFSE.model.Costanti;
	import com.li.dc.sebc.turboFSE.model.vo.DataAgregazione;
	import com.li.dc.sebc.turboFSE.view.component.BarraAgregazione;

	import it.lispa.siss.sebc.flex.debug.Debug;
	import it.lispa.siss.sebc.middleground.entity.SetDocumentale;

	import mx.containers.VBox;

	public class VistaBodyAgregazione extends Vista
	{
		private var listButtons:Array;
		public var vbox:VBox;
		public function VistaBodyAgregazione()
		{
			super();
			createVBox();
			Debug.logInfo(" VistaBodyAgregazione ");
		}
		private function createVBox():void
		{
			vbox = new VBox();
			vbox.setStyle("horizontalAlign","left" );
			vbox.setStyle("verticalAlign","top" );
			vbox.setStyle("verticalGap",4 );
			vbox.setStyle("borderStyle","none" );
			vbox.setStyle("backgroundColor",0xADF0A6);
			vbox.setStyle("backgroundAlpha",0.2);
			vbox.percentHeight	= 100;
			vbox.percentWidth	= 100;
			this.addChild( vbox );
		}
		override protected function updateData():void
		{
			Debug.logInfo(" VistaBodyAgregazione.updateData ");
			createAgregazione(this.dataVista as Array);
		}
		public function getListButton():Array
		{
			return listButtons;
		}
		private function createAgregazione(listAgregazioni:Array):void
		{
			if(listButtons==null)
			{
				listButtons = new Array();
			}
			if(listAgregazioni!=null && listAgregazioni.length>0)
			{
				for(var i:uint = 0;i<listAgregazioni.length;i++)
				{
					var barraAgregazione:BarraAgregazione	= new BarraAgregazione();
					var dataAgrega:DataAgregazione = listAgregazioni[i];
					var setDoc:SetDocumentale = dataAgrega.agregazione[0] as SetDocumentale;
					barraAgregazione.dataAgregazione		= listAgregazioni[i];
					listButtons.push( barraAgregazione );
					if (setDoc.tipoDocumento.codice == Costanti.TIPO_DOC_TACUINO)
					{
						barraAgregazione.setStyle("color", "#FF0000");
					}

					Debug.logInfo(" VistaBodyAgregazione.createAgregazione "+barraAgregazione);
					this.vbox.addChild( barraAgregazione );
				}
			}
		}
	}
}