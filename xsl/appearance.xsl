<?xml version="1.0" encoding="UTF-8"?>
<!-- 
citygml2-to-citygml3

Developer:
Son H. Nguyen (son.nguyen@tum.de)

With support regarding CityGML encodings from
Thomas H. Kolbe (thomas.kolbe@tum.de)
Tatjana Kutzner (kutzner@tum.de)

MIT License

Copyright (c) 2018 Chair of Geoinformatics, Technical University of Munich

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
-->
<xsl:stylesheet
	version="2.0"
	xmlns:app="http://www.opengis.net/citygml/appearance/2.0"
	xmlns:brid="http://www.opengis.net/citygml/bridge/2.0"
	xmlns:bldg="http://www.opengis.net/citygml/building/2.0"
	xmlns:frn="http://www.opengis.net/citygml/cityfurniture/2.0"
	xmlns:grp="http://www.opengis.net/citygml/cityobjectgroup/2.0"
	xmlns:con="http://www.opengis.net/citygml/construction/3.0"
	xmlns:pcl="http://www.opengis.net/citygml/pointcloud/3.0"
	xmlns:core="http://www.opengis.net/citygml/2.0"
	xmlns:dyn="http://www.opengis.net/citygml/dynamizer/3.0"
	xmlns:gen="http://www.opengis.net/citygml/generics/2.0"
	xmlns:luse="http://www.opengis.net/citygml/landuse/2.0"
	xmlns:dem="http://www.opengis.net/citygml/relief/2.0"
	xmlns:tex="http://www.opengis.net/citygml/texturedsurface/2.0"
	xmlns:tran="http://www.opengis.net/citygml/transportation/2.0"
	xmlns:tun="http://www.opengis.net/citygml/tunnel/2.0"
	xmlns:veg="http://www.opengis.net/citygml/vegetation/2.0"
	xmlns:vers="http://www.opengis.net/citygml/versioning/3.0"
	xmlns:wtr="http://www.opengis.net/citygml/waterbody/2.0"
	xmlns:tsml="http://www.opengis.net/tsml/1.0"
	xmlns:sos="http://www.opengis.net/sos/2.0"
	xmlns:xAL="urn:oasis:names:tc:ciq:xsdschema:xAL:2.0"
	xmlns:xlink="http://www.w3.org/1999/xlink"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:gml="http://www.opengis.net/gml"
	xmlns:ade="http://www.3dcitydb.org/citygml-ade/3.0/citygml/1.0"
	xmlns="http://www.opengis.net/citygml/2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xalan="http://xml.apache.org/xslt">

    <xsl:template match="app:appearanceMember">
		<appearanceMember>
			<xsl:element name="app:Appearance">
				<xsl:copy-of select="app:Appearance/@*" />
				<xsl:element name="app:theme">
					<xsl:value-of select="app:Appearance/app:theme/text()" />
				</xsl:element>
				<xsl:for-each select="app:Appearance/app:surfaceDataMember">
					<xsl:element name="app:surfaceData">
						<xsl:choose>
							<xsl:when test="app:ParameterizedTexture">
								<xsl:element name="app:ParameterizedTexture">
									<xsl:copy-of select="app:ParameterizedTexture/@*" />
									<xsl:copy-of select="app:ParameterizedTexture/child::node()[name()!='app:target']" />
									<xsl:for-each select="app:ParameterizedTexture/app:target">
										<xsl:element name="app:textureParameterization">
											<xsl:element name="app:TextureAssociation">
												<xsl:element name="app:uri">
													<xsl:value-of select="./@uri" />
												</xsl:element>
												<xsl:element name="app:textureParameterization">
													<xsl:if test="./app:TexCoordList">
														<xsl:element name="app:TexCoordList">
															<xsl:element name="app:textureCoordinates">
																<xsl:value-of select="./app:TexCoordList/app:textureCoordinates/text()" />
															</xsl:element>
															<xsl:element name="app:ring">
																<xsl:value-of select="./app:TexCoordList/app:textureCoordinates/@ring" />
															</xsl:element>
														</xsl:element>
													</xsl:if>
												</xsl:element>
											</xsl:element>
										</xsl:element>
									</xsl:for-each>
								</xsl:element>
							</xsl:when>
							<xsl:otherwise>
								<xsl:copy-of select="@*|node()" />
							</xsl:otherwise>
						</xsl:choose>
					</xsl:element>
				</xsl:for-each>
			</xsl:element>
		</appearanceMember>
	</xsl:template>

	<xsl:template match="app:appearance">
		<appearance>
			<xsl:element name="app:Appearance">
				<xsl:copy-of select="app:Appearance/@*" />
				<xsl:element name="app:theme">
					<xsl:value-of select="app:Appearance/app:theme/text()" />
				</xsl:element>
				<xsl:for-each select="app:Appearance/app:surfaceDataMember">
					<xsl:element name="app:surfaceData">
						<xsl:choose>
							<xsl:when test="app:ParameterizedTexture">
								<xsl:element name="app:ParameterizedTexture">
									<xsl:copy-of select="app:ParameterizedTexture/@*" />
									<xsl:copy-of select="app:ParameterizedTexture/child::node()[name()!='app:target']" />
									<xsl:for-each select="app:ParameterizedTexture/app:target">
										<xsl:element name="app:textureParameterization">
											<xsl:element name="app:TextureAssociation">
												<xsl:element name="app:uri">
													<xsl:value-of select="./@uri" />
												</xsl:element>
												<xsl:element name="app:textureParameterization">
													<xsl:if test="./app:TexCoordList">
														<xsl:element name="app:TexCoordList">
															<xsl:element name="app:textureCoordinates">
																<xsl:value-of select="./app:TexCoordList/app:textureCoordinates/text()" />
															</xsl:element>
															<xsl:element name="app:ring">
																<xsl:value-of select="./app:TexCoordList/app:textureCoordinates/@ring" />
															</xsl:element>
														</xsl:element>
													</xsl:if>
												</xsl:element>
											</xsl:element>
										</xsl:element>
									</xsl:for-each>
								</xsl:element>
							</xsl:when>
							<xsl:otherwise>
								<xsl:copy-of select="@*|node()" />
							</xsl:otherwise>
						</xsl:choose>
					</xsl:element>
				</xsl:for-each>
			</xsl:element>
		</appearance>
	</xsl:template>
    
</xsl:stylesheet>
