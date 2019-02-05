<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
	<xsl:output method="xml" version="1.0" encoding="iso-8859-1" indent="yes" />
	<xsl:template match="/">
		<distintaDCE>
			<dataOraInvio><xsl:value-of select="/Document/distintaDCE/dataOraInvio"/></dataOraInvio>
			<idEnteErogante><xsl:value-of select="/Document/distintaDCE/idEnteErogante"/></idEnteErogante>
			<descrizioneEnteErogatore><xsl:value-of select="/Document/distintaDCE/descrizioneEnteErogatore"/></descrizioneEnteErogatore>
			<idRepository><xsl:value-of select="/Document/distintaDCE/idRepository"/></idRepository>			
			<listaDCE>
				<xsl:for-each select="Document/distintaDCE/listaDCE/DCE">
					<DCE>
						<URIDCE><xsl:value-of select="URIDCE"/></URIDCE>
						<hashDocumento><xsl:value-of select="hashDocumento"/></hashDocumento>
						<algoritmoHash><xsl:value-of select="algoritmoHash"/></algoritmoHash>
						<dataOraConservazione><xsl:value-of select="dataOraConservazione"/></dataOraConservazione>
						<flagConservato><xsl:value-of select="flagConservazione"/></flagConservato>
					</DCE>
				</xsl:for-each>
			</listaDCE>
		</distintaDCE>
	</xsl:template>
</xsl:stylesheet>