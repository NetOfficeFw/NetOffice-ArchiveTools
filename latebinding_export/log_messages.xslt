<?xml version="1.0" encoding="UTF-8"?>
<?altova_samplexml file:///C:/dev/codeplex/NetOfficeGit/netoffice.xml?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:exsl="http://exslt.org/common">
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="yes"/>
	<xsl:preserve-space elements="msg" />

	<xsl:template match="/">
		<xsl:apply-templates select="log/logentry"/>
	</xsl:template>

	<xsl:template match="logentry">
		<xsl:result-document method="text" href="log/message_r{@revision}.txt">
			 <xsl:apply-templates select="msg"/>
		</xsl:result-document>
	</xsl:template>
</xsl:stylesheet>
