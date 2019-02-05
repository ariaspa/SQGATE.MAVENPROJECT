<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    version = "1.0"
    xmlns:xsl = "http://www.w3.org/1999/XSL/Transform"
    xmlns:t = "http://www.crs.lombardia.it/schemas/mw/2004-01/coopcontext/">
    <xsl:output
        method = "text"
        version = "1.0"
        encoding = "UTF-8"
        indent = "yes"/>
    <xsl:template match = "/">
        <xsl:variable name = "appoIUP"></xsl:variable>
        <xsl:apply-templates select = "Document"/>
    </xsl:template>
    <xsl:template match = "/version">005</xsl:template>
    <xsl:template match = "//Security/FunContext">
        <xsl:apply-templates select = "credential"/>
    </xsl:template>
    <xsl:template match = "Document">
        <xsl:apply-templates select = "refertoSpecialisticoAutorizzato"/>
        <xsl:apply-templates select = "refertoRicoveroAutorizzato"/>
        <xsl:apply-templates select = "refertoProntoSoccorsoAutorizzato"/>
        <xsl:apply-templates select = "registraRefertiAggiornamentoAutorizzato"/>
        <xsl:apply-templates select = "refertoSpecialisticoAutorizzazione"/>
        <xsl:apply-templates select = "refertoRicoveroAutorizzazione"/>
        <xsl:apply-templates select = "refertoProntoSoccorsoAutorizzazione"/>
        <xsl:apply-templates select = "refertoAggiornamentoAutorizzazione"/>
    </xsl:template>
    <xsl:template name = "riferimentiDoc">
    
           Riferimenti del Documento Clinico:
	         <xsl:choose>
            <xsl:when test = "idTipoReferto= '01'">
                VISITA SPECIALISTICA
                <xsl:if test = "//numeroNosologico!= ''">NEL CONTESTO RICOVERO</xsl:if>
                <xsl:if test = "//numeroPratica!= ''">NEL CONTESTO PRONTO SOCCORSO</xsl:if>
                <xsl:if test = "//numeroNosologico!= ''">
                    Numero Nosologico:
                    <xsl:value-of select = "//numeroNosologico"/>
                </xsl:if>
                <xsl:if test = "//numeroPratica!= ''">
		   Numero Pratica di Pronto Soccorso:
                    <xsl:value-of select = "//numeroPratica"/>
                </xsl:if>
                <xsl:call-template name = "prestazioni"/>
            </xsl:when>
            <xsl:when test = "idTipoReferto= '02'">
                SPECIALISTICO LABORATORIO
                <xsl:if test = "//numeroNosologico!= ''">NEL CONTESTO RICOVERO</xsl:if>
                <xsl:if test = "//numeroPratica!= ''">NEL CONTESTO PRONTO SOCCORSO</xsl:if>
                <xsl:if test = "//numeroNosologico!= ''">
                    Numero Nosologico:
                    <xsl:value-of select = "//numeroNosologico"/>
                </xsl:if>
                <xsl:if test = "//numeroPratica!= ''">
		 Numero Pratica di Pronto Soccorso:
                    <xsl:value-of select = "//numeroPratica"/>
                </xsl:if>
                <xsl:call-template name = "prestazioni"/>
            </xsl:when>
            <xsl:when test = "idTipoReferto= '03'">
                SPECIALISTICO RADIOLOGIA
                <xsl:if test = "//numeroNosologico!= ''">NEL CONTESTO RICOVERO</xsl:if>
                <xsl:if test = "//numeroPratica!= ''">NEL CONTESTO PRONTO SOCCORSO</xsl:if>
                <xsl:if test = "//numeroNosologico!= ''">
                    Numero Nosologico:
                    <xsl:value-of select = "//numeroNosologico"/>
                </xsl:if>
                <xsl:if test = "//numeroPratica!= ''">
		  Numero Pratica di Pronto Soccorso:
                    <xsl:value-of select = "//numeroPratica"/>
                </xsl:if>
                <xsl:call-template name = "prestazioni"/>
            </xsl:when>
            <xsl:when test = "idTipoReferto= '04'">
	                    VERBALE DI PRONTO SOCCORSO
                <xsl:if test = "//numeroPratica!= ''">
                    Numero pratica:
                    <xsl:value-of select = "//numeroPratica"/>
                </xsl:if>
            </xsl:when>
            <xsl:when test = "idTipoReferto= '05'">
                LETTERA DIMISSIONI
                <xsl:if test = "//numeroNosologico!= ''">
                    Numero Nosologico:
                    <xsl:value-of select = "//numeroNosologico"/>
                </xsl:if>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    <xsl:template name = "strutturaReferto">
            Documento Clinico emesso da
    <xsl:value-of select = "idStruttura"/>,
        <xsl:value-of select = "idSubStruttura"/>,
    </xsl:template>
    <xsl:template name = "fmtData">
        In data
        <xsl:value-of select = "concat('',substring(data, 7, 2))"/>
        <xsl:value-of select = "concat('/',substring(data, 5, 2))"/>
        <xsl:value-of select = "concat('/',substring(data, 1, 4))"/>
        -
        <xsl:value-of select = "concat('',substring(ora, 1, 5))"/>
    </xsl:template>
    <xsl:template name = "datiCittadino">
        Interessato:
        <xsl:value-of select = "cittadino/nomeCittadino"/>
        <xsl:value-of select = "concat (' - ',//cognomeCittadino)"/>
        <xsl:value-of select = "concat (' - ',//codiceFiscaleCittadino)"/>
    </xsl:template>
    <xsl:template name = "prestazioni">
        <xsl:for-each select = "//prestazione">
			<xsl:sort
                select = "idPrestazione"
                data-type = "text"
                order = "ascending"/>
            <xsl:text></xsl:text>
            <xsl:if test = "idPrestazione!=''">
                Prestazione:
                <xsl:value-of select = "idPrestazione"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
    <xsl:template name = "datiMedicoAutorizzante">
        <xsl:choose>
            <xsl:when test = "//nomeAutorizzante">
                Redatto  da:
                <xsl:value-of select = "//nomeAutorizzante"/>
                <xsl:value-of select = "concat (' - ',//cognomeAutorizzante)"/>
                <xsl:value-of select = "concat (' - ',//codiceFiscaleAutorizzante)"/>
            </xsl:when>
            <xsl:otherwise>
                Redatto  da:
                <xsl:value-of select = "//FirstName"/>
                <xsl:value-of select = "concat (' - ',//LastName)"/>
                <xsl:value-of select = "concat (' - ',//userId)"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name = "autorizzazione">
        <xsl:text>
            Sezione Autorizzazione
            In conformita' con l'art. 84 del d. lgs. 196/2003, con la presente
        </xsl:text>
        <xsl:if test = "autorizzazioneConsultazione='SI'">autorizzo</xsl:if>
        <xsl:if test = "autorizzazioneConsultazione='NO'">non autorizzo</xsl:if>
	<xsl:text>
	la consultazione in autonomia del Documento Clinico in oggetto da parte dell'Interessato.
	</xsl:text>
    </xsl:template>
    <xsl:template name = "causaliOscuramento">
            Sezione Oscuramento per Leggi Speciali
	    In osservanza a quanto previsto dalle Leggi 
	    speciali (art. 11 della l. 22 maggio 1978, n. 194; art. 5 della
        l. 5 giugno 1990 n. 135; art. 120 del d.p.r. 9 ottobre 1990, n. 
	309; art. 734-bis del codice penale), dichiaro il Documento 
	Clinico in oggetto:
        <xsl:call-template name = "processaCausale">
            <xsl:with-param name = "codiceCausale" select = "20"/>
        </xsl:call-template>
	<xsl:text>
	, per quanto riguarda la norma che disciplina il Trattamento dei 
	dati relativi alla sieropositivita';
	</xsl:text>
        <xsl:call-template name = "processaCausale">
            <xsl:with-param name = "codiceCausale" select = "10"/>
        </xsl:call-template>
	<xsl:text>
	, per quanto riguarda la norma che disciplina il Trattamento dei 
	dati relativi alla tossicodipendenza;
	</xsl:text>
       <xsl:call-template name = "processaCausale">
            <xsl:with-param name = "codiceCausale" select = "40"/>
        </xsl:call-template>
        <xsl:text>, per quanto riguarda la norma che disciplina il Trattamento dei dati relativi alla interruzione volontaria di gravidanza;</xsl:text>
        <xsl:call-template name = "processaCausale">
            <xsl:with-param name = "codiceCausale" select = "30"/>
        </xsl:call-template>
	        <xsl:text>
		, per quanto riguarda la norma che disciplina il Trattamento dei 
	dati relativi a violenza subite.
	</xsl:text>
        <xsl:call-template name = "processaCausale">
            <xsl:with-param name = "codiceCausale" select = "50"/>
        </xsl:call-template>
	    </xsl:template>
	        <xsl:template name = "processaCausale">
		            <xsl:param name = "codiceCausale"/>
		<xsl:for-each select = "//tipoOscuramento">            
		
		<xsl:if test = "codiceCausaleOscuramento=$codiceCausale">
                <xsl:choose>
                    <xsl:when test = "codiceCausaleOscuramento='50'">
                        <xsl:text>
                            Sezione Oscuramento per richiesta del Cittadino
                            Il Cittadino
                        </xsl:text>
                        <xsl:if test = "valoreOscuramento='NO'">non</xsl:if>
			<xsl:text>
			ha richiesto l'oscuramento del Documento Clinico in oggetto.
			</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:if test = "valoreOscuramento='SI'">- 
			Oscurato</xsl:if>
                        <xsl:if test = "valoreOscuramento='NO'">
			- Non oscurato</xsl:if>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
    <xsl:template name = "hashDoc">
            <xsl:text>IDDCE:</xsl:text>
	           <xsl:if test = "hashReferto">
            <xsl:value-of select = "hashReferto"/>
        </xsl:if>
        <xsl:if test = "CRSdocRef/hashReferto">
            <xsl:value-of select = "//hashReferto"/>
        </xsl:if>
    </xsl:template>
    <xsl:template name = "corpoDOC">
        <xsl:call-template name = "strutturaReferto"/>
        <xsl:call-template name = "fmtData"/>
        <xsl:call-template name = "datiCittadino"/>
        <xsl:call-template name = "datiMedicoAutorizzante"/>
        <xsl:call-template name = "riferimentiDoc"/>
        <xsl:call-template name = "autorizzazione"/>
        <xsl:call-template name = "causaliOscuramento"/>
        <xsl:call-template name = "hashDoc"/>
    </xsl:template>
    <xsl:template match = "refertoSpecialisticoAutorizzato">
        <xsl:call-template name = "corpoDOC"/>
    </xsl:template>
    <xsl:template match = "refertoRicoveroAutorizzato">
        <xsl:call-template name = "corpoDOC"/>
    </xsl:template>
    <xsl:template match = "refertoProntoSoccorsoAutorizzato">
        <xsl:call-template name = "corpoDOC"/>
    </xsl:template>
    <xsl:template match = "registraRefertiAggiornamentoAutorizzato">
        <xsl:call-template name = "corpoDOC"/>
    </xsl:template>
    <xsl:template match = "refertoSpecialisticoAutorizzazione">
        <xsl:call-template name = "corpoDOC"/>
    </xsl:template>
    <xsl:template match = "refertoRicoveroAutorizzazione">
        <xsl:call-template name = "corpoDOC"/>
    </xsl:template>
    <xsl:template match = "refertoProntoSoccorsoAutorizzazione">
        <xsl:call-template name = "corpoDOC"/>
    </xsl:template>
    <xsl:template match = "refertoAggiornamentoAutorizzazione">
        <xsl:call-template name = "corpoDOC"/>
    </xsl:template>
</xsl:stylesheet>
