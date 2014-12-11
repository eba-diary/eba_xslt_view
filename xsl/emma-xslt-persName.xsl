<xsl:stylesheet version="1.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:x="http://www.tei-c.org/ns/1.0">
 <xsl:strip-space elements="*"/>

<xsl:key name="person_ref" match="text/body/div/p/persName" use="@ref" />
<xsl:key name="person_name" match="text/body/div/p/persName" use="." />

<xsl:template match="/">
    <html>
    <head>
    	<title>EBA XSLT View</title>
    </head>
    <body>
    	<h1>EBA XSLT View</h1>
    	<p>This view of the Emma B. Andrews TEI XML file is provided using an XSLT script that was built by one of the projects undergraduate researchers, Pranav Shivanna. This view is a dynamic listing of all the person name attributes in the volume 19 XML file. Underneath each name attribute are the different spellings of that name that occur in the text of the diary.</p>
		<table border="1">
			<tr>
				<th>Name</th>
			</tr>
			<xsl:apply-templates/>
		</table>
    </body>
    </html>
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
<!-- Uses Muenchian Grouping to group the occurences of persName by their unique refs --> 
<xsl:template match="text/body/div/p">    
	<xsl:for-each select="persName[generate-id() = generate-id(key('person_ref', @ref)[1])]">	
		<xsl:sort select="@ref" />
		<tr><td>
			<strong><xsl:value-of select="@ref" /></strong><br />
			<xsl:for-each select="key('person_ref', @ref)[generate-id() = generate-id(key('person_name', .)[1])]">	   
				<xsl:sort select="." />
				<xsl:value-of select="." /><br />				
			</xsl:for-each>
		</td></tr>
	</xsl:for-each>
</xsl:template>

</xsl:stylesheet>