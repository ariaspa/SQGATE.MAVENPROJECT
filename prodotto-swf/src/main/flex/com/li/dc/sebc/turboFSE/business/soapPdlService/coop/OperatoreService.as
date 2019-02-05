package com.li.dc.sebc.turboFSE.business.soapPdlService.coop
{
	import it.lisit.siss.flex.communication.AbstractServiceSEB;
	import it.lisit.siss.flex.communication.coop.service.AbstractServiceLeggiCredenziali;
	import it.lisit.siss.flex.communication.coop.voLeggiCredenziali.VoOutputLeggiCredenziali;
	import it.lispa.siss.sebc.flex.debug.Debug;
	import it.lispa.siss.sebc.middleground.entity.Operatore;

	public class OperatoreService extends COOPService
	{
		public function OperatoreService( )
		{
			super( );
		}
		override protected function getService():AbstractServiceSEB
		{
			return factoryCoop.getServiceLeggiCredenziali() as AbstractServiceSEB;
		}	
		override protected function executeService( ):void
		{
			Debug.logDebug( "OperatoreService . executeService " );
			(this.serviceSEB as AbstractServiceLeggiCredenziali).getOperatore();
		}
		override protected function getDataResult(esitiPositivi:Array):Object
		{
			Debug.logDebug( "OperatoreService . getDataResult ASSOLUTAMENTE INCOMPLETO " + esitiPositivi);
			// ASSOLUTAMENTE INCOMPLETO la trasformazione della risposta è parziale
			var ope:Operatore = new Operatore();
			try{
				if(esitiPositivi!=null && esitiPositivi.length>0)
				{
					var res:VoOutputLeggiCredenziali = esitiPositivi[0] as VoOutputLeggiCredenziali;
					ope.ruolo.codice 	= res.credential.security.credential.role.code;
					var split:Array 	= res.credential.coop.value.split("/");
					ope.nome			= split[0];
					ope.cognome			= split[1];
					ope.codiceFiscale	= split[2];
					Debug.logDebug( "OperatoreService  nome" + ope.nome+", ope.cognome : "+ope.cognome );
				}
			}catch(err:Error)
			{
				Debug.logError("ERROR : "+err.message);
			}
			return ope as Object;
		}
	}
}