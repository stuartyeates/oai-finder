<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="@*|*|processing-instruction()|comment()">
    <xsl:copy>
      <xsl:apply-templates select="*|@*|text()|processing-instruction()|comment()"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="/">
    <xsl:copy>
      .
      <xsl:apply-templates select="//repository"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="repository">
    <xsl:value-of select="rUrl"/>
    <xsl:text>,</xsl:text>
    <xsl:value-of select="rOaiBaseUrl"/>
    <xsl:text>,</xsl:text>
    <xsl:value-of select="oUrl"/>
    <xsl:text>,</xsl:text>
    <xsl:value-of select="@rID"/>
    <xsl:text>,</xsl:text>
    <xsl:value-of select="rName"/>
    <xsl:text>,
</xsl:text>
  </xsl:template>

</xsl:stylesheet>
