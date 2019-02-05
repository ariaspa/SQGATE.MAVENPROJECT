package com.li.dc.sebc.turboFSE.view.viste
{
	import com.li.dc.sebc.turboFSE.events.TurboEvent;
	import com.li.dc.sebc.turboFSE.view.component.ButtonFolder;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	
	import it.lispa.siss.sebc.flex.collection.DictionaryIteratorKey;
	import it.lispa.siss.sebc.flex.collection.IIterator;
	import it.lispa.siss.sebc.flex.debug.Debug;
	
	import mx.containers.VBox;
	
	public class VistaDisciplina extends Vista
	{
		private var dictDisciplina:Dictionary;
		private var oldAgree:AgreDisciplina;
		private var counter:uint;
		private var listAggAdd:Array;
		private var listAggRem:Array;
		private var box:VBox;
		public function VistaDisciplina()
		{
			super();
			counter			= 0;
			listAggRem		= new Array();
			listAggAdd		= new Array();
			dictDisciplina 	= new Dictionary();
			addBox();
		}
		private function addBox():void
		{
			//<mx:VBox id="box" verticalGap="4" horizontalAlign="left" verticalAlign="top" borderStyle="none" width="100%" height="100%"/>
			box = new VBox();
			box.setStyle("verticalGap",4);
			box.setStyle("horizontalAlign","left");
			box.setStyle("verticalAlign","top");
			box.setStyle("borderStyle","none");
			box.percentHeight	= 100;
			box.percentWidth	= 100;
			
			this.addChild( box );
		} 
		private function getButtonFolder(name:String):ButtonFolder
		{
			var buttonfolder:ButtonFolder 	= new ButtonFolder();
			buttonfolder.label				= name;
			buttonfolder.toolTip			= name;
			buttonfolder.buttonMode			= true;
			buttonfolder.toggle				= true;
			buttonfolder.percentWidth		= 100;
			buttonfolder.height				= 30;
			buttonfolder.setStyle("cornerRadius",0);
			buttonfolder.addEventListener(MouseEvent.CLICK, onClickButtonFolder );
			return buttonfolder;
		}
		private function onClickButtonFolder(e:MouseEvent):void
		{
			var btn:ButtonFolder 		= e.target as ButtonFolder;
			var agre:AgreDisciplina		= dictDisciplina[ btn ];
			if(agre!=null)
			{
				/* apre o chiude AgreDisciplina associato a questo bottone */
				agre.open( btn.selected );
				/* solo nel caso il vecchio non sia il corrente e che l'azione sul corrente sia di apertura */
				if(oldAgree !=null && agre != oldAgree && btn.selected )
				{
					var oldBtn:ButtonFolder = dictDisciplina[ oldAgree ];
					oldBtn.selected 		= false;
					oldAgree.open( false );
				}	
				oldAgree 					= agre;
			}
		}
		override protected function updateData():void
	 	{
	 		if(this.dataVista is Dictionary)
			{
				var iter:IIterator = new DictionaryIteratorKey(this.dataVista as Dictionary);
				while(iter.hasNext())
				{
					var name:String 				= iter.next() as String;
					/* creo il bottone etichettato con la disciplina */
					var buttonfolder:ButtonFolder 	= getButtonFolder( name );
					/* creo l'area espandibile con all'interno la lista dei documenti */ 
					var agre:AgreDisciplina			= new AgreDisciplina( );
					/* mi metto in ascolto per sapere quando è completo */
					agre.addEventListener(TurboEvent.COMPLETE_EVENT,onCompleteAgree);
					agre.setDataVista( this.dataVista[name] );
					/* conservo gli elementi in un dizionario per poter avere un riferimento incrociato */
					dictDisciplina[buttonfolder] 	= agre;
					dictDisciplina[ agre ]			= buttonfolder;
					/* li aggiungo al vertical box */
					box.addChild( buttonfolder );
					box.addChild( agre );
					/* li aggiungo alla lista che userò per sapere se tutti si sono completati*/
					listAggRem.push( agre );
				}
			}
	 	}
	 	
		
		private function onCompleteAgree(e:Event):void
		{
			if(e.target is AgreDisciplina)
			{
				for(var i:uint = 0;i<listAggRem.length;i++)
				{
					if(listAggRem[i] == e.target)
					{
						var temp:Array			= listAggRem.splice(i,1);
						if(temp!=null && temp.length>0)
						{
							var item:AgreDisciplina = temp[0];
							listAggAdd = listAggAdd.concat( item.getListButton() );	
							Debug.logDebug("onCompleteAgree :listAggAdd.length: "+listAggAdd.length);
						}
						break;
					}
				}
			}
			Debug.logDebug("onCompleteAgree :listAggRem.length: "+listAggRem.length);
			/* se la lista è a zero, tutti gli elementi espandibili sono completati */
			if(listAggRem.length==0)
			{
				Debug.logDebug("onCompleteAgree TURBOEVENT.COMPLETE_EVENT MANDATO" );
				this.dispatchEvent( new TurboEvent(TurboEvent.COMPLETE_EVENT) );
			}
		}
		
		public function getListButton():Array /*BarraAgregazione*/
		{
			return listAggAdd;
		}
	}
}

 