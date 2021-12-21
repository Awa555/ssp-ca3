<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
	<xsl:output method="html" doctype-public="XSLT-compat" omit-xml-declaration="yes" encoding="UTF-8" indent="yes"/>
	<xsl:template match="/">
		<html>
			<head>
				<title>Frutea</title>
				<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
				<style>
				body{font-family:Arial,Helvetica,sans-serif;background-color:#fff;margin:5px;text-align:left;color:#523819}
				h2{font-size:140%;color:#0d3427;margin-top:10px}
				p{font-size:80%;color:#523819}
				table{background-color:#dacfe5;border-color:#000;border-width:thin;border-collapse:collapse;width:75%}
				th{border-color:#000;font-size:120%;color:#0d3427}
				td{border-color:#000;font-size:100%;color:#523819;padding:5px}
				img{float:left;margin-left:10px;margin-right:10px;border:0}
				.indent{margin-left:78px}
				</style>
				<script><![CDATA[
				var gEntreeCount = 0;
				// returns a number that represents the sum of all the selected menu
				// item prices.
				function calculateBill(idMenuTable) {
					var fBillTotal = 0.0;
					var i = 0;
					// find the table tag
					var oTable = document.getElementById(idMenuTable);
					// go through the table and add up the prices of all
					// the selected items. The code takes advantage of the 
					// fact that each checkbox has a corresponding row in
					// the table, and the only INPUT tags are the checkboxes.
					var aCBTags = oTable.getElementsByTagName('INPUT');
					for (i = 0; i < aCBTags.length; i++) {
						// is this menu item selected? it is if the checkbox is checked
						if (aCBTags[i].checked) {
							// get the checkbox' parent table row
							var oTR = getParentTag(aCBTags[i], 'TR');
							// retrieve the price from the price column, which is the third column in the table
							var oTDPrice = oTR.getElementsByTagName('TD')[2];
							// the first child text node of the column contains the price
							fBillTotal += parseFloat(oTDPrice.firstChild.data);
						};
					};
					// return the price as a decimal number with 2 decimal places
					return Math.round(fBillTotal * 100.0) / 100.0;
				};
				// This function either turns on or off the row highlighting for vegetarian
				// items (depending on the value of bShowVeg)
				function highlightVegetarian(idTable, bShowVeg) {
					// if bShowVeg is true, then we're highlighting vegetarian
					//	meals, otherwise we're unhighlighting them.
					var i = 0;
					var oTable = document.getElementById(idTable);
					var oTBODY = oTable.getElementsByTagName('TBODY')[0];
					var aTRs = oTBODY.getElementsByTagName('TR');
					// walk through each of the table rows and see if it has a 
					// "vegetarian" attribute on it.
					for (i = 0; i < aTRs.length; i++) {
						if (aTRs[i].getAttribute('vegetarian') && aTRs[i].getAttribute('vegetarian') == "true") {
							if (bShowVeg) {
								aTRs[i].style.backgroundColor = "lightGreen";
							} else {
								aTRs[i].style.backgroundColor = "";
							};
						};
					};
				};
				// Utility function for getting the parent tag of a given tag
				// but only of a certain type (i.e. a TR, a TABLE, etc.)
				function getParentTag(oNode, sParentType) {
					var oParent = oNode.parentNode;
					while (oParent) {
						if (oParent.nodeName == sParentType)
							return oParent;
						oParent = oParent.parentNode;
					};
					return oParent;
				};
				window.addEventListener("load", function() {
					document.forms[0].txtBillAmt.value = calculateBill('menuTable');
					document.querySelector("#calcBill").addEventListener("click", function() {
						document.forms[0].txtBillAmt.value = calculateBill('menuTable');
					});
					document.querySelector("#showVeg").addEventListener("click", function() {
						highlightVegetarian('menuTable', this.checked);
					});
				}); ]]>
				</script>
			</head>
			<body>
				<h2><img src="https://storage.cloud.google.com/myawabigbucket123/frutea_logo.png?authuser=1" alt="Frutea Logo" width="120px"/>Welcome to Frutea</h2>
				<p>Select your entrees from the menu below. To calculate the amount of the bill, click the Calculate Bill button. Check the "Highlight Vegetarian Meals" box to highlight vegetarian dishes.</p>
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
                <input type="text" name="txtBillAmt"/><input type="checkbox" name="cbOpts" value="isVeg" id="showVeg"/><label for="showVeg">Highlight Vegetarian Meals</label></p>
				</form>
			</body>
		</html>
	</xsl:template>
</xsl:transform> 