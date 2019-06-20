<?xml version="1.0" encoding="UTF-8"?>
<?altova_samplexml file:///C:/dev/codeplex/NetOfficeGit/netoffice.xml?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:exsl="http://exslt.org/common">
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="yes"/>

	<xsl:function name="exsl:node-set">
	  <xsl:param name="rtf"/>
	  <xsl:sequence select="$rtf"/>
	</xsl:function>

	<xsl:variable name="abbreviations">
		<abbreviation key="RNO\_MCLWEB">TFS &lt;tfs@codeplex.com&gt;</abbreviation>
		<abbreviation key="SND\SebastianDotNet_cp">SebastianDotNet &lt;SebastianDotNet@codeplex.com&gt;</abbreviation>
		<abbreviation key="vstfs:///Framework/IdentityDomain/2327b42d-5241-43d6-9e2a-de5ac946f064\Project Collection Service Accounts">TFS &lt;tfs@codeplex.com&gt;</abbreviation>
	</xsl:variable>

	<xsl:template match="/">
		<xsl:apply-templates select="log/logentry">
			<xsl:sort select="number(@revision)" data-type="number" order="ascending"/>
		</xsl:apply-templates>
	</xsl:template>

	<xsl:template match="logentry">
		<xsl:value-of select="@revision"/>
		<xsl:text>|</xsl:text>
		<xsl:apply-templates select="author"/>
		<xsl:text>|</xsl:text>
		<xsl:value-of select="date"/>
		<xsl:text>
</xsl:text>
	</xsl:template>

	<xsl:template match="author">
		<xsl:variable name="text" select="."/>
		<xsl:value-of select="exsl:node-set($abbreviations)/abbreviation[@key=$text]"/>
	</xsl:template>
</xsl:stylesheet>
