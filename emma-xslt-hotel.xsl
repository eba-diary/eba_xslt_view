<xsl:stylesheet version="1.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:x="http://www.tei-c.org/ns/1.0"
 xmlns:sk="http://www.faculty.washington.edu/ketchley/ns/1.0">
 <xsl:strip-space elements="*"/>

<xsl:key name="hotel_ref" match="text/body/div/p/sk:hotel/name" use="@ref" />
<xsl:key name="hotel_name" match="text/body/div/p/sk:hotel/name" use="." />

<xsl:template match="/">
	<table border="1">
		<tr>
			<th>Hotels</th>
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
<xsl:template match="text/body/div/p/sk:hotel">    
	<xsl:for-each select="name[generate-id() = generate-id(key('hotel_ref', @ref)[1])]">	
		<xsl:sort select="@ref" />
		<tr><td>
			<strong><xsl:value-of select="@ref" /></strong><br />
			<xsl:for-each select="key('hotel_ref', @ref)[generate-id() = generate-id(key('hotel_name', .)[1])]">	   
				<xsl:sort select="." />
				<xsl:value-of select="." /><br />				
			</xsl:for-each>
		</td></tr>
	</xsl:for-each>
</xsl:template>

</xsl:stylesheet>