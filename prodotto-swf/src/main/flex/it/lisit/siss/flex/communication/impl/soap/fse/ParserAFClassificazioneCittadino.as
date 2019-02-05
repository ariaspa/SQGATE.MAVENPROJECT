package it.lisit.siss.flex.communication.impl.soap.fse
{
	internal class ParserAFClassificazioneCittadino
	{
		private var attributi:XML;
		public function ParserAFClassificazioneCittadino(attributi:XML)
		{
			this.attributi = attributi;
		}
		public function execute():VoAFClassificazioneCittadinoImpl
		{
			return new VoAFClassificazioneCittadinoImpl(attributi);
		}
	}
}
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoAFClassificazioneCittadino;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoElencoCategorie;
	import it.lisit.siss.flex.utility.ArrayIterator;
	
/////////////////////////////////////////////////////////////////////////
class VoAFClassificazioneCittadinoImpl extends VoAFClassificazioneCittadino
{
	public function VoAFClassificazioneCittadinoImpl(attCittadino:XML)
	{
		super();
		parsing(attCittadino);
	}
	private function parsing(attCittadino:XML):void
	{
		this.dataElaborazione 	= attCittadino.child( "dataElaborazione" );
		var list:XMLList 		= attCittadino.child( "elencoCategorie" ); 
		if(list!=null && list.length()>0)
		{
			var listVo:Array = getCategorie(list[0]);
			this.elencoCategorie = new VoElencoCategorieImpl(listVo);
		}
	}
	private function getCategorie(list:XML):Array
	{
		var temp:Array = new Array();
		var children:XMLList = list.child( "categoria" );
		for(var i:uint = 0;i<children.length();i++)
		{
			var vo:VoCategoriaImpl = new VoCategoriaImpl(children[0]);
			temp.unshift( vo );
		}	
		return temp;
	}
	override public function clone():ClonableValueObject
	{
		var clone:VoAFClassificazioneCittadinoImpl = new VoAFClassificazioneCittadinoImpl(new XML());
		clone.dataElaborazione = this.dataElaborazione;
		if(this.elencoCategorie !=null)
			clone.elencoCategorie  = this.elencoCategorie.clone() as VoElencoCategorie;	
		return clone
	}
}
/////////////////////////////////////////////////////////////////////////
class VoElencoCategorieImpl extends VoElencoCategorie
{
	private var orig:Array;
	private var listIt:ArrayIterator;
	public function VoElencoCategorieImpl(list:Array)
	{
		super();
		orig = list;
		listIt = new ArrayIterator( orig );
	}
	override public function get iterator():IIterator
	{
		return listIt;
	}
	override public function clone():ClonableValueObject
	{
		var temp:Array = new Array();
		var newIterator:ArrayIterator = new ArrayIterator(orig);
		while(newIterator.hasNext())
		{
			var item:ClonableValueObject = newIterator.next() as ClonableValueObject;
			temp.unshift( item.clone() );
		}
		return new VoElencoCategorieImpl(temp);
	}
}
/////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoCategoria;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoElencoCategorie;
	import it.lisit.siss.flex.utility.IIterator;
	import it.lisit.siss.flex.communication.ClonableValueObject;
class VoCategoriaImpl extends VoCategoria
{
	public function VoCategoriaImpl(cat:XML)
	{
		super();
		parsing(cat);
	}
	private function parsing(cat:XML):void
	{
		if(cat.length()==0)return;
		this.descrizioneCategoria 	= cat.child( "descrizioneCategoria" );
		this.idCategoria			= cat.child( "idCategoria" );		
		var elenco:XMLList			= cat.child( "elencoSottoCategorie" );
		if(elenco!=null && elenco.length()>0)
		{
			var lista:Array			  = getSottoCategorie(elenco[0]);
			this.elencoSottoCategorie = new VoElencoSottoCategorieImpl( lista );
		}
	}
	private function getSottoCategorie(elenco:XML):Array
	{
		var temp:Array = new Array()
		var children:XMLList = elenco.child( "sottoCategoria" );
		for(var i:uint = 0;i<children.length();i++)
		{
			var vo:VoSottoCategoriaImpl = new VoSottoCategoriaImpl(children[i]);
			temp.unshift( vo );
		}
		return temp;
	}
	override public function clone():ClonableValueObject
	{
		var clone:VoCategoriaImpl 	= new VoCategoriaImpl(new XML());
		clone.descrizioneCategoria 	= this.descrizioneCategoria;
		clone.idCategoria			= this.idCategoria;		
		if(this.elencoSottoCategorie!=null)
		{
			clone.elencoSottoCategorie = this.elencoSottoCategorie.clone() as VoElencoSottoCategorie;
		}
		return clone;
	}
}
class VoSottoCategoriaImpl extends VoSottoCategoria
{
	public function VoSottoCategoriaImpl(sottoCat:XML)
	{
		super();
		if(sottoCat.length()>0)
		{
			this.descrizioneSottoCategoria   =  sottoCat.child( "descrizioneSottoCategoria" );
			this.idSottoCategoria			 =  sottoCat.child( "idSottoCategoria" );
		}
	}
	override public function clone():ClonableValueObject
	{
		var clone:VoSottoCategoriaImpl  = new VoSottoCategoriaImpl(new XML());
		clone.descrizioneSottoCategoria = this.descrizioneSottoCategoria; 
		clone.idSottoCategoria			= this.idSottoCategoria; 
		return clone;
	} 
}
/////////////////////////////////////////////////////////////////////////
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoElencoCategorie;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoSottoCategoria;
	import it.lisit.siss.flex.communication.fse.voConsultaFascicolo.VoElencoSottoCategorie;
class VoElencoSottoCategorieImpl extends VoElencoSottoCategorie
{
	private var orig:Array;
	private var listIt:ArrayIterator;
	public function VoElencoSottoCategorieImpl(list:Array)
	{
		super();
		orig = list;
		listIt = new ArrayIterator(orig);
	}
	override public function get iterator():IIterator
	{
		return  listIt;
	}
	override public function clone():ClonableValueObject
	{
		var temp:Array = new Array();
		var newIterator:ArrayIterator = new ArrayIterator( orig );
		while(newIterator.hasNext())
		{
			var item:ClonableValueObject = newIterator.next() as ClonableValueObject;
			temp.unshift(  item.clone() );
		} 
		return new VoElencoSottoCategorieImpl( temp );
	}
}