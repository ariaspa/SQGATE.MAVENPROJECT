package it.lisit.siss.flex.communication.impl.soap.fse
{
	import it.lisit.siss.flex.communication.fse.voRichiediUrlTestoReferto.VoOutputRichiediUrlTestoReferto;

	public class ParseRichiediUrlTestoReferto
	{
		private var _body:XML;

		public function ParseRichiediUrlTestoReferto(body:XML)
		{
			this._body = body;
		}

		public function execute():VoOutputRichiediUrlTestoReferto
		{
			return new VoOutputRichiediUrlTestoRefertoImpl(_body);
		}
	}
}

import it.lisit.siss.flex.communication.fse.voRichiediUrlTestoReferto.VoOutputRichiediUrlTestoReferto;
import it.lisit.siss.flex.utility.xml.XPathUtility;

class VoOutputRichiediUrlTestoRefertoImpl extends VoOutputRichiediUrlTestoReferto
{
	public function VoOutputRichiediUrlTestoRefertoImpl(body:XML)
	{
		super();
		this.urlTestoReferto = XPathUtility.getNodeValue(body, "//URLDCE");
		this.testoReferto = XPathUtility.getNodeValue(body, "//testoDCE");
		this.tipoReferto = XPathUtility.getNodeValue(body, "//tipoTestoDCE");
	}
}