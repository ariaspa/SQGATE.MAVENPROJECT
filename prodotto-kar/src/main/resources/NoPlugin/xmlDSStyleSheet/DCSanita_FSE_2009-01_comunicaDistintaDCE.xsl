<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html"/>
	<xsl:template match="/">
		<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
			<head>
				<title>distintaDCE</title>
			</head>
			<body>
				<p align="right">Data 
					<xsl:call-template name="fmtDate">
						<xsl:with-param name="data" select="distintaDCE/dataOraInvio"/>
					</xsl:call-template>
				</p>
				<p>Oggetto: Distinta della Conservazione emessa da 
					<xsl:value-of select="distintaDCE/descrizioneEnteErogatore"/> 
					(<xsl:value-of select="distintaDCE/idEnteErogante"/>)
				</p>
				<p>Con la presente si comunica la variazione dello stato di Conservazione dei documenti sotto elencati per le finalita' proprie di esibizione degli stessi su Fascicolo Sanitario Elettronico.
				</p>
				<p>
					<xsl:for-each select="distintaDCE/listaDCE/DCE">
						<xsl:value-of select="position()"/>. Il documento avente URI 
						<xsl:value-of select="URIDCE"/> e' da ritenersi  
						<xsl:choose>
							<xsl:when test="flagConservato='S'">  
								<xsl:text>conservato</xsl:text> 
							</xsl:when>
							<xsl:when test="flagConservato='N'">
								<xsl:text>non piu' conservato</xsl:text> 
							</xsl:when>    
						</xsl:choose>  a far data da 
						<xsl:call-template name="fmtDate">		
							<xsl:with-param name="data" select="dataOraConservazione"/>
						</xsl:call-template> 
						<br/>
					</xsl:for-each>
				</p>
				<p>Tutti i documenti sopra indicati afferiscono al repository: 
					(<xsl:value-of select="distintaDCE/idRepository"/>).
				</p>
				<p>Data e ora emissione: 
					<xsl:call-template name="fmtDateOra">		
						<xsl:with-param name="data" select="distintaDCE/dataOraInvio"/>
					</xsl:call-template>
				</p>	
			</body>
		</html>
	</xsl:template>

	<xsl:template name="fmtDate">
		<xsl:param name="data"/>
		<xsl:value-of select="substring($data,7,2)"/>/
		<xsl:value-of select="substring($data,5,2)"/>/
		<xsl:value-of select="substring($data,1,4)"/>
	</xsl:template>	

	<xsl:template name="fmtDateOra">
		<xsl:param name="data"/>
		<xsl:value-of select="substring($data,7,2)"/>/
		<xsl:value-of select="substring($data,5,2)"/>/
		<xsl:value-of select="substring($data,1,4)"/>
		<xsl:text> </xsl:text>
		<xsl:value-of select="substring($data,9,2)"/>:
		<xsl:value-of select="substring($data,11,2)"/>
	</xsl:template>	
</xsl:stylesheet>