<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:t="http://www.crs.lombardia.it/schemas/mw/2004-01/coopcontext/">
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="yes"/>
	<xsl:template match="/">		
		<xsl:apply-templates select="Document/CoopContext/Security/FunContext"/>
		<xsl:apply-templates select="Document"/>
	</xsl:template>

	<xsl:template match="Document">
		<xsl:apply-templates select="registraAutorizzazioniCittadino"/>
	</xsl:template>

	<xsl:template match="Document/CoopContext/Security/FunContext/credential">
		
Il/la dr./dr.ssa <xsl:value-of select="FirstName"/>
		<xsl:value-of select="concat (' ',LastName)"/>, <xsl:value-of select="userId"/>

	</xsl:template>

	<xsl:template match="registraAutorizzazioniCittadino">

dichiara l'autorizzazione alla visualizzazione del referto  

<xsl:value-of select="uriReferto"/>

Note:

<xsl:value-of select="noteReperibilita"/>
	</xsl:template>
</xsl:stylesheet>
