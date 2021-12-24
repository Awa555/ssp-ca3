<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
<xsl:output method="html" doctype-public="XSLT-compat" omit-xml-declaration="yes" encoding="UTF-8" indent="yes"/>
<xsl:template match="/">
	<table id="menuTable" border="1" class="indent">
		<thead class="headBg">
			<tr>
				<th>Select</th>
				<th>Item</th>
				<th>Price</th>
			</tr>
		</thead>
		<tbody>
			<!-- Allow to loop over. Go to every section and loop it. -->
			<xsl:for-each select="//section">
				<tr>
					<td colspan="3" class="titleBg">
						<!-- Output name -->
						<xsl:value-of select="@name" />
					</td>
				</tr>
				<!-- Go to every entry and loop it. -->
				<xsl:for-each select="entry">
					<!-- Position for each table -->
					<tr id="{position()}"> 
						<xsl:attribute name="specialoffer">
                            <xsl:value-of select="boolean(@specialoffer)" />
                        </xsl:attribute>
                        <td align="center">
                            <input name="item0" type="checkbox" />
                        </td>
						<td>
							<!-- Output item -->
							<xsl:value-of select="item" />
						</td>
						<td align="right">
							<!-- Output price -->
							<xsl:value-of select="price" />
						</td>
					</tr>
				</xsl:for-each>
			</xsl:for-each>
		</tbody>
	</table>
</xsl:template>
</xsl:transform> 