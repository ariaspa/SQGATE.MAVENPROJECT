package it.lisit.siss.flex.communication.impl.soap.coop
{
	import it.lisit.siss.flex.communication.ValueObject;
	import it.lisit.siss.flex.communication.coop.voLeggiCredenziali.VoOutputLeggiCredenziali;
	
	internal class ParserLeggiCredenziali
	{
		private var _body:XML;
		public function ParserLeggiCredenziali(body:XML)
		{
			_body = body;
		}
		public function execute():ValueObject
		{
			return new VoOutputLeggiCredenzialiImpl(_body);
		}
	}
}
	import it.lisit.siss.flex.communication.coop.voLeggiCredenziali.VoOutputLeggiCredenziali;
	import it.lisit.siss.flex.communication.coop.voLeggiCredenziali.VoCredential;
	import it.lisit.siss.flex.communication.coop.voLeggiCredenziali.VoCoop;
	import it.lisit.siss.flex.communication.coop.voLeggiCredenziali.VoSecurity;
	import it.lisit.siss.flex.communication.ClonableValueObject;
	import it.lisit.siss.flex.communication.coop.voLeggiCredenziali.VoCredentialSecurity;
	import it.lisit.siss.flex.utility.ArrayIterator;
	import it.lisit.siss.flex.communication.coop.voLeggiCredenziali.VoAttributo;
	import it.lisit.siss.flex.communication.coop.voLeggiCredenziali.VoIteratorAttributo;
	import it.lisit.siss.flex.communication.coop.voLeggiCredenziali.VoCtf;
	import it.lisit.siss.flex.communication.coop.voLeggiCredenziali.VoPrv;
	import it.lisit.siss.flex.communication.coop.voLeggiCredenziali.VoRole;
	import it.lisit.siss.flex.communication.coop.voLeggiCredenziali.VoItem;
	import it.lisit.siss.flex.communication.coop.voLeggiCredenziali.VoIteratorServices;
	import it.lisit.siss.flex.communication.coop.voLeggiCredenziali.VoService;
	import it.lisit.siss.flex.communication.coop.voLeggiCredenziali.VoValidity;
	import it.lisit.siss.flex.communication.coop.voLeggiCredenziali.VoVrs;
	

class VoOutputLeggiCredenzialiImpl extends VoOutputLeggiCredenziali
{
	public function VoOutputLeggiCredenzialiImpl(body:XML)
	{
		super();
		var cred:XMLList = body.child("CREDENTIAL");
		if(cred!=null && cred.length()>0)
			this.credential = new VoCredentialImpl( cred[0] );
	}
}

class VoCredentialImpl extends VoCredential
{
	public function VoCredentialImpl(body:XML)
	{
		super();
		parsing(body);
	}
	private function parsing(body:XML):void
	{
		if(body.length()==0)return;
		var coopXml:XMLList		= body.child("COOP");
		if(coopXml!=null)
		{
			var copxm:XML				= coopXml[0];
			this.coop 					= new VoCoopImpl();
			this.coop.cit_auth			= copxm.attribute("cit_auth");
			this.coop.operator_logged	= copxm.attribute("operator_logged");
			this.coop.pdc_present		= copxm.attribute("pdc_present");
			this.coop.value				= copxm.toString();
		}
		this.security			= new VoSecurity();
		var secXml:XMLList		= body.child("SECURITY");
		if(secXml!=null && secXml.length()>0)
		{
			var cred:XMLList	= secXml[0].child("credential");
			if(cred!=null)
			{
				this.security.credential = new VoCredentialSecurityImpl(cred[0]);
			}	
		}	
	} 
	override public function clone():ClonableValueObject
	{
		var clone:VoCredentialImpl = new VoCredentialImpl(new XML());
		if(this.coop != null)
			clone.coop			= this.coop.clone() as VoCoop;
		if(this.security != null)	
			clone.security		= this.security.clone() as VoSecurity;
		return clone;
	}
}

class VoCoopImpl extends VoCoop
{
	public function VoCoopImpl()
	{
		super();
	}	
	override public function clone():ClonableValueObject
	{
		var clone:VoCoopImpl 	= new VoCoopImpl();
		clone.cit_auth			= this.cit_auth;
		clone.operator_logged	= this.operator_logged;
		clone.pdc_present		= this.pdc_present;
		clone.value				= this.value;
		return clone;
	}  
}

class VoCredentialSecurityImpl extends VoCredentialSecurity
{
	public function VoCredentialSecurityImpl(security:XML)
	{
		super();
		parsing(security);
	}	
	private function parsing(security:XML):void
	{
		var attXml:XMLList = security.child( "attributi" );
		if(attXml!=null && attXml.length()>0)
		{
			var list:Array = getListAttributi( attXml[0] );
			this.attributi = new VoIteratorAttributoImlp( list );	
		}
		//================= 
		var atfXml:XMLList	= security.child( "ctf" );
		if(atfXml!=null && atfXml.length()>0)
		{
			this.ctf 	= new VoCtfImpl( atfXml[0] );
		}
		//================= 
		this.funContext			= security.child( "funContext" );
		this.numericFunContext	= security.child( "numericFunContext" );
		var prvXml:XMLList		= security.child( "prv" );
		if(prvXml!=null && prvXml.length()>0)
		{
			this.prv			= new VoPrvImpl( prvXml[0] );
		}
		var rl:XMLList			= security.child( "role" );
		if(rl!=null && rl.length()>0)
		{
			this.role 			= new VoRoleimpl(rl[0]);
		}
		var listServ:XMLList	= security.child( "sServices" );
		if(listServ!=null && listServ.length()>0)
		{
			var listse:Array  = getServices(listServ[0]);
			this.sServices    = new VoIteratorServicesImpl(listse);	
		}		
		
		this.userId			= security.child( "userId" );
		var valid:XMLList  	= security.child( "validity" );
		if(valid!=null && valid.length()>0)
		{
			this.validity 	= new VoValidityImpl( valid[0] );
		}
		var vrsXm:XMLList	= security.child( "vrs" );
		if(vrsXm!=null && vrsXm.length()>0)
		{
			this.vrs 	    = new VoVrsImpl( vrsXm[0] ); 
		}
	}
	override public function clone():ClonableValueObject
	{
		var clone:VoCredentialSecurityImpl = new VoCredentialSecurityImpl( new XML() );
		if(this.attributi!=null)
		{
			clone.attributi = this.attributi.clone() as VoIteratorAttributo;
		}
		if(this.ctf!=null)
		{
			clone.ctf = this.ctf.clone() as VoCtf;
		}
		if(this.role!=null)
		{
			clone.role 	= this.role.clone() as VoRole;
		}
		if(this.sServices!=null)
		{
			clone.sServices = this.sServices.clone() as VoIteratorServices;
		}
		if(this.validity!=null)
		{
			clone.validity = this.validity.clone() as VoValidity;
		}
		if(this.validity!=null)
		{
			clone.validity = this.validity.clone() as VoValidity;
		}
		if(this.vrs != null)
		{
			clone.vrs    		= this.vrs.clone() as VoVrs;
		}
		clone.funContext		= this.funContext;
		clone.numericFunContext	= this.numericFunContext;
		clone.userId			= this.userId;	
		return clone;
	}
	private function getServices(list:XML):Array
	{
		var temp:Array = new Array();
		var listxml:XMLList	= list.child( "service" );
		for(var i:uint = 0;i<listxml.length();i++)
		{
			var vo:VoServiceImpl  = new VoServiceImpl( listxml[i] );
			temp.push( vo ); 
		}
		return temp;
	}
	private function getListAttributi(att:XML):Array
	{
		var temp:Array = new Array();
		var attri:XMLList	= att.child( "attributo" );
		for(var i:uint = 0;i<attri.length();i++)
		{
			var vo:VoAttributoImpl = new VoAttributoImpl( attri[i] );
			temp.push( vo );
		}
		return temp;
	}
}
class VoVrsImpl extends VoVrs
{
	public function VoVrsImpl(vrs:XML)
	{
		super();
		parsing(vrs);
	} 
	private function parsing(vrs:XML):void
	{
		this.min	= vrs.child( "min" );	
		this.mjr 	= vrs.child( "mjr" );
	} 
	override public function clone():ClonableValueObject
	{
		var cl:VoVrsImpl = new VoVrsImpl(new XML());
		cl.min		= this.min;
		cl.mjr		= this.mjr;
		return cl;
	}
}
class VoValidityImpl extends VoValidity
{
	public function VoValidityImpl(val:XML)
	{
		super();
		parsing(val);
	}
	private function parsing(val:XML):void
	{
		if(val.length()==0)return;
		this.elapsedTime	= val.child( "elapsedTime" );	
		this.emittedDate	= val.child( "emittedDate" );
		this.sessionMaxTime	= val.child( "sessionMaxTime" );
	}
	override public function clone():ClonableValueObject
	{
		var cl:VoValidityImpl = new VoValidityImpl( new XML() );
		cl.elapsedTime		= this.elapsedTime;	
		cl.emittedDate		= this.emittedDate;
		cl.sessionMaxTime	= this.sessionMaxTime;
		return cl; 	
	}
}
class VoIteratorServicesImpl extends VoIteratorServices
{
	private var orig:Array;
	public function VoIteratorServicesImpl(list:Array)
	{
		super();
		orig = list;
		this.iterator = new ArrayIterator( orig ); 
	}
	override public function clone():ClonableValueObject
	{
		var temp:Array = new Array()
		var iter:ArrayIterator  = new ArrayIterator( orig );
		while(iter.hasNext()){
			var vo:VoService = iter.next() as VoService;
			temp.push( vo.clone() );
		}
		return new VoIteratorServicesImpl(temp);
	}
}
class VoServiceImpl extends VoService
{
	public function VoServiceImpl(serv:XML)
	{
		super();
		parsing(serv);
	}
	private function parsing(serv:XML):void
	{
		if(serv.length()==0)return;
		this.code		= serv.child( "code");
		this.utContext	= serv.child( "utContext");
	}
	override public function clone():ClonableValueObject
	{
		var cl:VoServiceImpl = new VoServiceImpl(new XML());
		cl.code			= this.code;
		cl.utContext	= this.utContext;
		return cl;
	}
}
class VoCtfImpl extends VoCtf	
{
	public function VoCtfImpl(ctf:XML)
	{
		super();
		parsing(ctf);
		// clone già implementato
	}
	private function parsing(ctf:XML):void
	{
		var appXm:XMLList = ctf.child( "app" );
		if(appXm!=null && appXm.length()>0)
		{
			var apx:XML     = appXm[0]; 
			this.app = new VoItem();
			this.app.codice	= apx.child( "cod" );		
			this.app.descrizione	= apx.child( "des" );
		}
		//=======================
		var proXm:XMLList	= ctf.child( "pro" );
		if(proXm!=null && proXm.length()>0)
		{
			var pr:XML	= proXm[0];
			this.pro	= new VoItem();
			this.pro.codice			= pr.child( "cod" );
			this.pro.descrizione	= pr.child( "des" );
		}
		var rgXm:XMLList	= ctf.child( "reg" );
		if(rgXm!=null && rgXm.length()>0)
		{
			var rg:XML	= rgXm[0];
			this.reg	= new VoItem();
			this.reg.codice			= rg.child( "cod" );
			this.reg.descrizione	= rg.child( "des" );
		}
		var strXm:XMLList = ctf.child( "str" ); 
		if(strXm!=null && strXm.length()>0)
		{
			var st:XML	= strXm[0];
			this.str	= new VoItem();
			this.str.codice			= st.child( "cod" );
			this.str.descrizione	= st.child( "des" );
		}
		var terXm:XMLList =  ctf.child( "ter" );
		if(terXm!=null && terXm.length()>0)
		{
			var tr:XML	= terXm[0];
			this.ter	= new VoItem();
			this.ter.codice			= tr.child( "cod" );
			this.ter.descrizione	= tr.child( "des" );
		}
	}
}
class VoRoleimpl extends VoRole
{
	public function VoRoleimpl(rl:XML)
	{
		super()
		if(rl.length()>0)
		{
			this.code 	= rl.child( "code" );
			this.description 	= rl.child( "description" );
		}
	}
	override public function clone():ClonableValueObject
	{
		var clone:VoRoleimpl = new VoRoleimpl(new XML());
		clone.code			= this.code;	
		clone.description	= this.description;
		return clone;
	}
}
class VoPrvImpl extends VoPrv
{
	public function VoPrvImpl(prv:XML)
	{
		super();
		parsing(prv);
	}
	private function parsing(prv:XML):void
	{
		if(prv.length()==0)return;
		this.DF			= prv.child( "DF" );
		this.iupSeed	= prv.child( "iupSeed" );	
	}
	override public function clone():ClonableValueObject
	{
		var clone:VoPrvImpl = new VoPrvImpl(new XML());
		clone.DF		= this.DF;
		clone.iupSeed	= this.iupSeed;
		return clone;	
	} 
}
class VoIteratorAttributoImlp extends VoIteratorAttributo
{
	private var orig:Array;
	public function VoIteratorAttributoImlp(list:Array)
	{
		super();
		orig = list;
		this.iterator = new ArrayIterator(orig);
	}
	override public function clone():ClonableValueObject
	{
		var temp:Array = new Array();
		var iteraAr:ArrayIterator = new ArrayIterator(orig);
		while(iteraAr.hasNext())
		{
			var vo:VoAttributoImpl = iteraAr.next() as VoAttributoImpl;
			temp.push( vo.clone() );
		}
		return new VoIteratorAttributoImlp( temp );
	}
}
class VoAttributoImpl extends VoAttributo
{
	public function VoAttributoImpl(att:XML)
	{
		super();
		parsing(att);
	}
	private function parsing(att:XML):void
	{
		if(att.length()==0)return;
		this.cod 	= att.child( "cod" );
		this.des	= att.child( "des" );
		this.tipo	= att.attribute( "tipo" );
	}
	override public function clone():ClonableValueObject
	{
		var clone:VoAttributoImpl = new VoAttributoImpl(new XML());
		clone.cod		= this.cod;
		clone.des		= this.des;
		clone.tipo		= this.tipo;
		return clone;
	}
}