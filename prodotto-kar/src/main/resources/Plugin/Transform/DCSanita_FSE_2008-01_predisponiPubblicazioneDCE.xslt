<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:t="http://www.crs.lombardia.it/schemas/mw/2004-01/coopcontext/">
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="yes"/>
	<xsl:template match="/">
		<xsl:apply-templates select="Document/documentoClinicoElettronico"/>
		<xsl:apply-templates select="Document/documentoClinicoElettronico/oscuramento"/>
		<xsl:apply-templates select="Document/documentoClinicoElettronico/listaDocumenti/documento"/>
	</xsl:template>
	<xsl:template match="/version">005</xsl:template>
	<xsl:template match="//Security/FunContext">
		<xsl:apply-templates select="credential"/>
	</xsl:template>
	<xsl:template match="documentoClinicoElettronico">Documento Clinico emesso da <xsl:choose>
			<xsl:when test="idTipoDocumento!= '09'">
				<xsl:value-of select="strutturaCreazione/idEnte"/>, 
				<xsl:value-of select="strutturaCreazione/idPresidio"/>, 
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="autoreDocumento/codiceFiscale"/>
			</xsl:otherwise>
		</xsl:choose>
In data <xsl:value-of select="concat('',substring(dataOraCreazione, 7, 2))"/>
		<xsl:value-of select="concat('/',substring(dataOraCreazione, 5, 2))"/>
		<xsl:value-of select="concat('/',substring(dataOraCreazione, 1, 4))"/>
		<xsl:value-of select="concat(' - ',substring(dataOraCreazione, 9, 2))"/>
		<xsl:value-of select="concat(':',substring(dataOraCreazione, 11, 2))"/>
Interessato: <xsl:value-of select="cittadino/nomeCittadino"/>
		<xsl:value-of select="concat (' - ',cittadino/cognomeCittadino)"/>
		<xsl:value-of select="concat (' - ',cittadino/idCittadino)"/>
Redatto da: <xsl:value-of select="autoreDocumento/nome"/>
		<xsl:value-of select="concat (' - ',autoreDocumento/cognome)"/>
		<xsl:value-of select="concat (' - ',autoreDocumento/codiceFiscale)"/>    
Riferimenti del Documento Clinico: 
<xsl:choose>
			<xsl:when test="idTipoDocumento= '01'">VISITA SPECIALISTICA <xsl:if test="//numeroNosologico!= ''">NEL CONTESTO RICOVERO</xsl:if>
				<xsl:if test="//numeroPraticaPS!= ''">NEL CONTESTO PRONTO SOCCORSO</xsl:if>
				<xsl:if test="//numeroNosologico!= ''">
            Numero Nosologico: <xsl:value-of select="//numeroNosologico"/>
				</xsl:if>
				<xsl:if test="//numeroPraticaPS!= ''">
            Numero Pratica di Pronto Soccorso: <xsl:value-of select="//numeroPraticaPS"/>
				</xsl:if>
				<xsl:call-template name="listaPrestazioni"/>
			</xsl:when>
			<xsl:when test="idTipoDocumento= '02'">SPECIALISTICO LABORATORIO <xsl:if test="//numeroNosologico!= ''">NEL CONTESTO RICOVERO</xsl:if>
				<xsl:if test="//numeroPraticaPS!= ''">NEL CONTESTO PRONTO SOCCORSO</xsl:if>
				<xsl:if test="//numeroNosologico!= ''">
            Numero Nosologico: <xsl:value-of select="//numeroNosologico"/>
				</xsl:if>
				<xsl:if test="//numeroPraticaPS!= ''">
            Numero Pratica di Pronto Soccorso: <xsl:value-of select="//numeroPraticaPS"/>
				</xsl:if>
				<xsl:call-template name="listaPrestazioni"/>
			</xsl:when>
			<xsl:when test="idTipoDocumento= '03'">SPECIALISTICO RADIOLOGIA <xsl:if test="//numeroNosologico!= ''">NEL CONTESTO RICOVERO</xsl:if>
				<xsl:if test="//numeroPraticaPS!= ''">NEL CONTESTO PRONTO SOCCORSO</xsl:if>
				<xsl:if test="//numeroNosologico!= ''">
            Numero Nosologico: <xsl:value-of select="//numeroNosologico"/>
				</xsl:if>
				<xsl:if test="//numeroPraticaPS!= ''">
            Numero Pratica di Pronto Soccorso: <xsl:value-of select="//numeroPraticaPS"/>
				</xsl:if>
				<xsl:call-template name="listaPrestazioni"/>
			</xsl:when>
			<xsl:when test="idTipoDocumento= '04'">VERBALE DI PRONTO SOCCORSO
            <xsl:if test="//numeroPraticaPS!= ''">
            Numero pratica: <xsl:value-of select="//numeroPraticaPS"/>
				</xsl:if>
			</xsl:when>
			<xsl:when test="idTipoDocumento= '05'">LETTERA DIMISSIONI
            <xsl:if test="//numeroNosologico!= ''">
            Numero Nosologico: <xsl:value-of select="//numeroNosologico"/>
				</xsl:if>
			</xsl:when>
			<xsl:when test="idTipoDocumento= '08'">EVALUATION NOTE
            Numero Nosologico: <xsl:value-of select="//numeroNosologico"/>
			</xsl:when>
			<xsl:when test="idTipoDocumento= '09'">PATIENT SUMMARY
            Codice Fiscale Cittadino: <xsl:value-of select="cittadino/idCittadino"/>
			</xsl:when>
			<xsl:when test="idTipoDocumento= '10'">SCHEDA DI PATOLOGIA
            Codice Fiscale Cittadino: <xsl:value-of select="cittadino/idCittadino"/>
			</xsl:when>
			<xsl:when test="idTipoDocumento= '11'">VERBALE DI CONTATTO TELEFONICO
            Codice Fiscale Cittadino: <xsl:value-of select="cittadino/idCittadino"/>
			</xsl:when>
			<xsl:when test="idTipoDocumento= '12'">ESITO TELECONSULTO
            Codice Fiscale Cittadino: <xsl:value-of select="cittadino/idCittadino"/>
			</xsl:when>
			<xsl:when test="idTipoDocumento= '13'">REFERTO DI RETE
            Codice Fiscale Cittadino: <xsl:value-of select="cittadino/idCittadino"/>
			</xsl:when>
			<xsl:when test="idTipoDocumento= '14'">VERBALE DI RACCOLTA DATI SPECIALISTICI DI PATOLOGIA
            Codice Fiscale Cittadino: <xsl:value-of select="cittadino/idCittadino"/>
			</xsl:when>
			<xsl:when test="idTipoDocumento= '15'">LETTERA DI INVIO
            Codice Fiscale Cittadino: <xsl:value-of select="cittadino/idCittadino"/>
			</xsl:when>
			<xsl:when test="idTipoDocumento= '16'">CERTIFICATO DI MALATTIA
            Codice Fiscale Cittadino: <xsl:value-of select="cittadino/idCittadino"/>
			</xsl:when>
			<xsl:when test="idTipoDocumento= '17'">PERCORSO TERAPEUTICO INDIVIDUALE
            Codice Fiscale Cittadino: <xsl:value-of select="cittadino/idCittadino"/>
			</xsl:when>
			<xsl:when test="idTipoDocumento= '18'">PIANO RIABILITATIVO
            Codice Fiscale Cittadino: <xsl:value-of select="cittadino/idCittadino"/>
			</xsl:when>
			<xsl:when test="idTipoDocumento= '19'">SCHEDA DI DIAGNOSI
            Codice Fiscale Cittadino: <xsl:value-of select="cittadino/idCittadino"/>
			</xsl:when>
			<xsl:when test="idTipoDocumento= '20'">REFERTO DI PROTESICA
            Codice Fiscale Cittadino: <xsl:value-of select="cittadino/idCittadino"/>
			</xsl:when>
			<xsl:when test="idTipoDocumento= '21'">PIANO DI CONTROLLO DEL DISPOSITIVO
            Codice Fiscale Cittadino: <xsl:value-of select="cittadino/idCittadino"/>
			</xsl:when>			
		</xsl:choose>

Sezione Autorizzazione<xsl:if test="statoAutorizzazioneDocumento='SI' or statoAutorizzazioneConsultazione='SI'">
    In conformita' con l'art. 84 del d. lgs. 196/2003, con la presente autorizzo la consultazione in autonomia del Documento Clinico in oggetto da parte dell'Interessato.</xsl:if>
		<xsl:if test="statoAutorizzazioneDocumento='NO' or statoAutorizzazioneConsultazione='NO'">
    In conformita' con l'art. 84 del d. lgs. 196/2003, con la presente non autorizzo la consultazione in autonomia del Documento Clinico in oggetto da parte dell'Interessato.</xsl:if>

Sezione Oscuramento per Leggi Speciali
    In osservanza a quanto previsto dalle Leggi speciali (art. 11 della l. 22 maggio 1978, n. 194; art. 5 della
    l. 5 giugno 1990 n. 135; art. 120 del d.p.r. 9 ottobre 1990, n. 309; art. 734-bis del codice penale), dichiaro il Documento Clinico in oggetto:    </xsl:template>
	<xsl:template match="Document/documentoClinicoElettronico/oscuramento">
		<xsl:call-template name="processaCausale">
			<xsl:with-param name="codiceCausale" select="20"/>
		</xsl:call-template>
		<xsl:call-template name="processaCausale">
			<xsl:with-param name="codiceCausale" select="10"/>
		</xsl:call-template>
		<xsl:call-template name="processaCausale">
			<xsl:with-param name="codiceCausale" select="40"/>
		</xsl:call-template>
		<xsl:call-template name="processaCausale">
			<xsl:with-param name="codiceCausale" select="30"/>
		</xsl:call-template>
		<xsl:call-template name="processaCausale">
			<xsl:with-param name="codiceCausale" select="50"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="processaCausale">
		<xsl:param name="codiceCausale"/>
		<xsl:for-each select="tipoOscuramento">
			<xsl:if test="idCausaleOscuramento=$codiceCausale">
				<xsl:choose>
					<xsl:when test="idCausaleOscuramento='50'">

Sezione Oscuramento per richiesta del Cittadino
<xsl:choose>
							<xsl:when test="valoreOscuramento='SI'">         Il Cittadino ha richiesto l'oscuramento del Documento Clinico in oggetto.</xsl:when>
							<xsl:otherwise>         Il Cittadino non ha richiesto l'oscuramento del Documento Clinico in oggetto.</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="valoreOscuramento='SI'">
         - Oscurato</xsl:when>
							<xsl:otherwise>
         - Non oscurato</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:if test="idCausaleOscuramento='20'">, per quanto riguarda la norma che disciplina il Trattamento dei dati relativi alla sieropositivita';</xsl:if>
				<xsl:if test="idCausaleOscuramento='10'">, per quanto riguarda la norma che disciplina il Trattamento dei dati relativi alla tossicodipendenza;</xsl:if>
				<xsl:if test="idCausaleOscuramento='40'">, per quanto riguarda la norma che disciplina il Trattamento dei dati relativi alla interruzione volontaria di gravidanza;</xsl:if>
				<xsl:if test="idCausaleOscuramento='30'">, per quanto riguarda la norma che disciplina il Trattamento dei dati relativi a violenza subite.</xsl:if>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="listaPrestazioni">
		<xsl:for-each select="//prestazione">
			<!--xsl:sort select="IUP" data-type="text" order="ascending"/>-->
			<xsl:sort select="idPrestazioneSISS" data-type="text" order="ascending"/>
			<xsl:text>
            </xsl:text>
			<!--xsl:if test="IUP!=''">IUP: <xsl:value-of select="IUP"/> - </xsl:if>-->
			<xsl:if test="idPrestazioneSISS!=''">Prestazione: <xsl:value-of select="idPrestazioneSISS"/>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	<xsl:template match="documentoClinicoElettronico/listaDocumenti/documento">
		<xsl:if test="firmato='S'">

IDDCE: <xsl:value-of select="hashDocumento"/>
		</xsl:if>
	</xsl:template>
	<xsl:template match="credential">
		<xsl:value-of select="FirstName"/>
		<xsl:value-of select="concat (' - ',LastName)"/>
		<xsl:value-of select="concat (' - ',userId)"/>
	</xsl:template>
</xsl:stylesheet>
