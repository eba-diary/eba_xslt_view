<xsl:stylesheet version="1.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:x="http://www.tei-c.org/ns/1.0">
 <xsl:strip-space elements="*"/>

<xsl:key name="place_ref" match="text/body/div/p/placeName" use="@ref" />
<xsl:key name="place_name" match="text/body/div/p/placeName" use="." />

<xsl:template match="/">
	<table border="1">
		<tr>
			<th>Places</th>
		</tr>
		<xsl:apply-templates/>
	</table>
</xsl:template>

<!-- default rule: copy any node beneath <p> -->
<xsl:template match="text/body/div/p//*">        
	<xsl:copy>
		<xsl:copy-of select="@*" />
		<xsl:apply-templates />
	</xsl:copy>
</xsl:template>

<!-- default rule: ignore any unspecific text node -->
<xsl:template match="text()" />

<!-- override rule: copy any persName beneath p -->
<xsl:template match="text/body/div/p">    
	<xsl:for-each select="placeName[generate-id() = generate-id(key('place_ref', @ref)[1])]">	
		<xsl:sort select="@ref" />
		<tr><td>
			<strong><xsl:value-of select="@ref" /></strong><br />
			<xsl:for-each select="key('place_ref', @ref)[generate-id() = generate-id(key('place_name', .)[1])]">	   
				<xsl:sort select="." />
				<xsl:value-of select="." /><br />				
			</xsl:for-each>
		</td></tr>
	</xsl:for-each>
</xsl:template>

</xsl:stylesheet>