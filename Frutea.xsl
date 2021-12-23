<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
	<xsl:output method="html" doctype-public="XSLT-compat" omit-xml-declaration="yes" encoding="UTF-8" indent="yes"/>
	<xsl:template match="/">
		<html>
			<head>
				<title>Frutea</title>
				<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
				<link rel="stylesheet" href="css/Frutea.css" />
				<script type="text/javascript" src="js/Frutea.js">x</script>
			</head>
			<body>
				<h2><img src="img/frutea_logo.png" alt="Frutea Logo" width="120px"/>Welcome to Frutea</h2>
				<p>Select your entrees from the menu below. To calculate the amount of the bill, click the Calculate Bill button.</p>
				<table id="menuTable" border="1" class="indent">
					<thead>
						<tr>
							<th colspan="3">Frutea</th>
						</tr>
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
                                <td colspan="3">
                                    <!-- Output name -->
                                    <xsl:value-of select="@name" />
                                </td>
                            </tr>
                            <!-- Go to every entry and loop it. -->
                            <xsl:for-each select="entry">
                                <tr id="{position()}">
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
				<form class="indent">
					<p><input type="button" name="btnCalcBill" value="Calculate Bill" id="calcBill"/>
                Total: €
                <input type="text" name="txtBillAmt"/></p>
				</form>
			</body>
		</html>
	</xsl:template>
</xsl:transform> 