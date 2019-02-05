package it.lisit.siss.flex.communication.impl.soap.fse
{
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoEvent;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoListaEventi;
	
	internal class ParserEventi
	{
		private var listEventi:XMLList;
		public function ParserEventi(eventi:XMLList)
		{
			this.listEventi = eventi;
		}
		public function execute():VoListaEventi
		{
			var temp:Array = new Array();
			var parsingAttributi:IParserAttributiFolder = new ParserAttributiFolder();
			for(var i:uint = 0;i<this.listEventi.length();i++)
			{
				var evento:XML = this.listEventi[i];
				var voEvento:VoEventImpl = new VoEventImpl(evento,parsingAttributi);
				temp.unshift( voEvento );
			}
			return new VoListaEventiImpl( temp );
		}
	}
}
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoEvent;
	import it.lisit.siss.flex.communication.impl.soap.fse.IParserAttributiFolder;
	import it.lisit.siss.flex.communication.ClonableValueObject;
class VoEventImpl extends VoEvent
{
	private var parsingAttributi:IParserAttributiFolder;
	public function VoEventImpl(evento:XML,parsingAttributi:IParserAttributiFolder)
	{
		super();
		this.parsingAttributi = parsingAttributi;
		parsing(evento);
	}
	private function parsing(evento:XML):void
	{
		if(evento.length()==0)return;
		 
		var attrFolder:XMLList		= evento.child( "attributiSpecificiFolder" );
		if(attrFolder!=null && attrFolder.length()>0)
		{
			this.attributiFolder	= parsingAttributi.getAttributi( attrFolder[0] );
		}
		this.dataErogazioneEvento	= evento.child( "dataErogazioneEvento" );
		this.descrizioneTipoEvento	= evento.child( "descrizioneTipoEvento" );
		this.idEvento				= evento.child( "idEvento" );
		this.idTipoEvento			= evento.child( "idTipoEvento" );
	}
	override public function clone():ClonableValueObject
	{
		var clone:VoEventImpl 		= new VoEventImpl(new XML(),parsingAttributi);
		if(this.attributiFolder!=null)
			this.attributiFolder	= this.attributiFolder.clone() as VoAttributiFolder;		
		this.dataErogazioneEvento	= this.dataErogazioneEvento;
		this.descrizioneTipoEvento	= this.descrizioneTipoEvento;
		this.idEvento				= this.idEvento;
		this.idTipoEvento			= this.idTipoEvento;
		return clone;
	}
}
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoListaEventi;
	import it.lisit.siss.flex.utility.ArrayIterator;
	import it.lisit.siss.flex.utility.IIterator;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoAttributiFolder;
	 
class VoListaEventiImpl extends VoListaEventi
{
	private var listIterator:ArrayIterator;
	public function VoListaEventiImpl(lista:Array)
	{
		super();
		listIterator = new ArrayIterator( lista ); 
	}
	override public function get iterator():IIterator
	{
		return listIterator;
	}
}