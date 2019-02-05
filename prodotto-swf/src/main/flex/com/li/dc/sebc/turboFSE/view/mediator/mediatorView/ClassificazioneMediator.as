package com.li.dc.sebc.turboFSE.view.mediator.mediatorView
{
	import com.li.dc.sebc.turboFSE.model.ConstDataProxy;
	import com.li.dc.sebc.turboFSE.model.FSEModel;
	import com.li.dc.sebc.turboFSE.model.vo.FolderTree;
	import com.li.dc.sebc.turboFSE.util.UtilDate;
	import com.li.dc.sebc.turboFSE.view.nodeView.Classificazione;
	
	import it.lispa.siss.sebc.flex.debug.Debug;
	import it.lispa.siss.sebc.flex.mvc.model.proxy.DataProxyEvent;
	import it.lispa.siss.sebc.flex.mvc.view.Mediator;
	import it.lispa.siss.sebc.middleground.entity.AttributiFolderClassificazionePatologie;

	public class ClassificazioneMediator extends Mediator
	{
		private var classifica:Classificazione
		public function ClassificazioneMediator()
		{
			super();
			Debug.logDebug("instance ClassificazioneMediator create");
		}
		override protected function finalize():void
		{
			
		}
		override protected function initialize( ):void
		{
			classifica = (this.view as Classificazione);
			FSEModel.getInstance().retrieveProxy( ConstDataProxy.CLASSIFICAZIONI).addEventListener(DataProxyEvent.DATA_UPDATE,onUpdate);
		}
		private function onUpdate(e:DataProxyEvent):void
		{
			classifica.txtArea 				= "Nessuna classificazione presente";
			classifica.txtSelectable		= false;
			classifica.txtEditable			= false;
			var ft:FolderTree = e.getData() as FolderTree;
			var afc:AttributiFolderClassificazionePatologie = ft.attributiSpecificiFolder as AttributiFolderClassificazionePatologie; 
			if(afc.elencoCategorie!=null && afc.elencoCategorie.length>0)
			{
				classifica.txtArea			= "Il dato viene desunto da elaborazioni realizzate dalla Regione Lombardia a partire dalle erogazioni sanitarie al cittadino effettuate negli anni da Farmacie, Ambulatori, Ospedali. Il dato è indicativo e non certifica lo stato di patologia"
				classifica.txtSelectable	= true;
				classifica.txtEditable		= true;
				classifica.lblValue			= UtilDate.getStringData(afc.dataElaborazione);
				classifica.update( afc.elencoCategorie.toArray() );
			}	
		}
	}
}













