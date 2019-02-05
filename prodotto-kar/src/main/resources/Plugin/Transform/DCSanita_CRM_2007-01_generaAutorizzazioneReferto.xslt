<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:t="http://www.crs.lombardia.it/schemas/mw/2004-01/coopcontext/">

	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="yes"/>
	<xsl:template match="/">

		<xsl:if test="Document/refertoSpecialisticoAutorizzazione">
			<xsl:apply-templates select="//Security/FunContext/credential"/>
		</xsl:if>
		<xsl:if test="Document/refertoRicoveroAutorizzazione">
			<xsl:apply-templates select="//Security/FunContext/credential"/>
		</xsl:if>
		<xsl:if test="Document/refertoProntoSoccorsoAutorizzazione">
			<xsl:apply-templates select="//Security/FunContext/credential"/>
		</xsl:if>
		<xsl:if test="Document/refertoAggiornamentoAutorizzazione">
			<xsl:apply-templates select="//Security/FunContext/credential"/>
		</xsl:if>
		<xsl:apply-templates select="Document"/>
	</xsl:template>
	<xsl:template match="/version">001</xsl:template>
	<xsl:template match="//Security/FunContext">
		<xsl:apply-templates select="credential"/>
	</xsl:template>
	<xsl:template match="Document">
		<xsl:apply-templates select="refertoSpecialisticoAutorizzato"/>
		<xsl:apply-templates select="refertoRicoveroAutorizzato"/>
		<xsl:apply-templates select="refertoProntoSoccorsoAutorizzato"/>
		<xsl:apply-templates select="registraRefertiAggiornamentoAutorizzato"/>
		<xsl:apply-templates select="refertoSpecialisticoAutorizzazione"/>
		<xsl:apply-templates select="refertoRicoveroAutorizzazione"/>
		<xsl:apply-templates select="refertoProntoSoccorsoAutorizzazione"/>
		<xsl:apply-templates select="refertoAggiornamentoAutorizzazione"/>
	</xsl:template>
	<xsl:template name="datiMedicoAutorizzante">
Io sottoscritto <xsl:value-of select="medicoAutorizzante/nomeAutorizzante"/>
		<xsl:value-of select="concat ('-',medicoAutorizzante/cognomeAutorizzante)"/>
		<xsl:value-of select="concat ('-',medicoAutorizzante/codiceFiscaleAutorizzante)"/>
	</xsl:template>
	<xsl:template name="datiCittadino">

autorizzo il sig. <xsl:value-of select="cittadino/cognomeCittadino"/>
		<xsl:value-of select="concat ('-',cittadino/nomeCittadino)"/>
		<xsl:value-of select="concat ('-',cittadino/codiceFiscaleCittadino)"/>
	</xsl:template>
	<xsl:template name="fmtData">
		<xsl:param name="data"/>
		<xsl:value-of select="concat('',substring($data, 7, 2))"/>
		<xsl:value-of select="concat('/',substring($data, 5, 2))"/>
		<xsl:value-of select="concat('/',substring($data, 1, 4))"/>
	</xsl:template>
	<xsl:template name="prtPrestazione">
		<xsl:for-each select="prestazioniAssociate/prestazione">
			<xsl:sort select="idPrestazione" data-type="text" order="ascending"/>
			<xsl:value-of select="concat(idPrestazione, ', ')"/>
		</xsl:for-each>
	</xsl:template>
	<xsl:template match="refertoSpecialisticoAutorizzato">
		<xsl:call-template name="datiMedicoAutorizzante"/>
		<xsl:call-template name="datiCittadino"/> alla visualizzazione del proprio referto, 

associato alla prestazione/i <xsl:call-template name="prtPrestazione"/>redatto in data <xsl:call-template name="fmtData">
			<xsl:with-param name="data" select="data"/>
		</xsl:call-template> - <xsl:value-of select="ora"/>

presso <xsl:value-of select="idStruttura"/> - <xsl:value-of select="idSubStruttura"/>
		<xsl:text>&#xD;&#xD;&#xD;&#xD;</xsl:text>
		<xsl:value-of select="hashReferto"/>
	</xsl:template>
	<xsl:template match="refertoRicoveroAutorizzato">
		<xsl:call-template name="datiMedicoAutorizzante"/>
		<xsl:call-template name="datiCittadino"/> alla visualizzazione della lettera di dimissione, 

associata al ricovero <xsl:value-of select="numeroNosologico"/>, redatto in data <xsl:call-template name="fmtData">
			<xsl:with-param name="data" select="data"/>
		</xsl:call-template> - <xsl:value-of select="ora"/> 

presso <xsl:value-of select="idStruttura"/> - <xsl:value-of select="idSubStruttura"/>
		<xsl:text>&#xD;&#xD;&#xD;&#xD;</xsl:text>
		<xsl:value-of select="hashReferto"/>
	</xsl:template>
	<xsl:template match="refertoProntoSoccorsoAutorizzato">
		<xsl:call-template name="datiMedicoAutorizzante"/>
		<xsl:call-template name="datiCittadino"/> alla visualizzazione del verbale, 

associato all'accesso in pronto soccorso con numero <xsl:value-of select="numeroPratica"/>, 

redatto in data <xsl:call-template name="fmtData">
			<xsl:with-param name="data" select="data"/>
		</xsl:call-template> - <xsl:value-of select="ora"/> 

presso <xsl:value-of select="idStruttura"/> - <xsl:value-of select="idSubStruttura"/>
		<xsl:text>&#xD;&#xD;&#xD;&#xD;</xsl:text>
		<xsl:value-of select="hashReferto"/>
	</xsl:template>
	<xsl:template match="registraRefertiAggiornamentoAutorizzato">
		<xsl:call-template name="datiMedicoAutorizzante"/>
		<xsl:call-template name="datiCittadino"/> alla visualizzazione del proprio referto, 

associato al referto <xsl:value-of select="uriRefertoPadre"/>, 

redatto in data <xsl:call-template name="fmtData">
			<xsl:with-param name="data" select="data"/>
		</xsl:call-template> - <xsl:value-of select="ora"/> 

presso <xsl:value-of select="idStruttura"/> - <xsl:value-of select="idSubStruttura"/>
		<xsl:text>&#xD;&#xD;&#xD;&#xD;</xsl:text>
		<xsl:value-of select="hashReferto"/>
	</xsl:template>
	<xsl:template match="credential">
Io sottoscritto <xsl:value-of select="FirstName"/>
		<xsl:value-of select="concat ('-',LastName)"/>
		<xsl:value-of select="concat ('-',userId)"/>
	</xsl:template>
	<xsl:template match="refertoSpecialisticoAutorizzazione">
		<xsl:call-template name="datiCittadino"/> alla visualizzazione del proprio referto, 

associato alla prestazione/i <xsl:call-template name="prtPrestazione"/>redatto in data <xsl:call-template name="fmtData">
			<xsl:with-param name="data" select="data"/>
		</xsl:call-template> - <xsl:value-of select="ora"/>

presso <xsl:value-of select="idStruttura"/> - <xsl:value-of select="idSubStruttura"/>
		<xsl:text>&#xD;&#xD;&#xD;&#xD;</xsl:text>
		<xsl:value-of select="CRSdocRef/hashReferto"/>
	</xsl:template>
	<xsl:template match="refertoRicoveroAutorizzazione">
		<xsl:call-template name="datiCittadino"/> alla visualizzazione della lettera di dimissione, 

associata al ricovero <xsl:value-of select="numeroNosologico"/>, redatto in data <xsl:call-template name="fmtData">
			<xsl:with-param name="data" select="data"/>
		</xsl:call-template> - <xsl:value-of select="ora"/> 

presso <xsl:value-of select="idStruttura"/> - <xsl:value-of select="idSubStruttura"/>
		<xsl:text>&#xD;&#xD;&#xD;&#xD;</xsl:text>
		<xsl:value-of select="CRSdocRef/hashReferto"/>
	</xsl:template>
	<xsl:template match="refertoProntoSoccorsoAutorizzazione">
		<xsl:call-template name="datiCittadino"/> alla visualizzazione del verbale, 

associato all'accesso in pronto soccorso con numero <xsl:value-of select="numeroPratica"/>, 

redatto in data <xsl:call-template name="fmtData">
			<xsl:with-param name="data" select="data"/>
		</xsl:call-template> - <xsl:value-of select="ora"/> 

presso <xsl:value-of select="idStruttura"/> - <xsl:value-of select="idSubStruttura"/>
		<xsl:text>&#xD;&#xD;&#xD;&#xD;</xsl:text>
		<xsl:value-of select="CRSdocRef/hashReferto"/>
	</xsl:template>
	<xsl:template match="refertoAggiornamentoAutorizzazione">
		<xsl:call-template name="datiCittadino"/> alla visualizzazione del proprio referto, 

associato al referto <xsl:value-of select="uriRefertoPadre"/>, 

redatto in data <xsl:call-template name="fmtData">
			<xsl:with-param name="data" select="data"/>
		</xsl:call-template> - <xsl:value-of select="ora"/> 

presso <xsl:value-of select="idStruttura"/> - <xsl:value-of select="idSubStruttura"/>
		<xsl:text>&#xD;&#xD;&#xD;&#xD;</xsl:text>
		<xsl:value-of select="CRSdocRef/hashReferto"/>
	</xsl:template>
</xsl:stylesheet>