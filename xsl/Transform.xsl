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
	xmlns="http://www.opengis.net/citygml/2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xalan="http://xml.apache.org/xslt">
    
    <!-- 
    exclude-result-prefixes="xalan xlink xsi xAl bldg gml gen con"
    
    xmlns:bldgN="http://www.opengis.net/citygml/building/3.0" 
    xmlns:gmlN="http://www.opengis.net/gml/3.2" 
    xmlns:genN="http://www.opengis.net/citygml/generics/3.0" 
    xmlns:defaultN="http://www.opengis.net/citygml/3.0"  
    xsi:schemaLocationN="http://www.opengis.net/citygml/3.0 ../xsds/cityGMLBase.xsd http://www.opengis.net/citygml/building/3.0 ../xsds/building.xsd http://www.opengis.net/citygml/construction/3.0 ../xsds/construction.xsd http://www.opengis.net/citygml/generics/3.0 ../xsds/generics.xsd"-->

    <!-- Post processing texts -->
	<xsl:strip-space elements="*" />
	<xsl:output
		method="xml"
		indent="yes"
		xalan:indent-amount="4"
		standalone="yes" />
    
    <!-- Identity transformation -->
	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()" />
		</xsl:copy>
	</xsl:template>
	
<!-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
<!-- ++++++++++++++++++++++++ CITY MODEL ++++++++++++++++++++++++ -->
<!-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
	<xsl:template match="*[local-name()='CityModel']">
		<CityModel
			xmlns:con="http://www.opengis.net/citygml/construction/3.0" 
			xmlns:dyn="http://www.opengis.net/citygml/dynamizer/3.0" 
			xmlns:pcl="http://www.opengis.net/citygml/pointcloud/3.0" 
			xmlns:ver="http://www.opengis.net/citygml/versioning/3.0">
			<xsl:call-template name="core:AbstractFeatureWithLifespanType" />
			<xsl:apply-templates select="*[local-name()='cityObjectMember']" />
			<xsl:apply-templates select="app:appearanceMember" />
		</CityModel>
	</xsl:template>
	
	<xsl:template name="gml:StandardObjectProperties">
		<xsl:apply-templates select="gml:metaDataProperty" />
		<xsl:apply-templates select="gml:description" />
		<xsl:apply-templates select="gml:descriptionReference" />
		<xsl:apply-templates select="gml:identifier" />
		<xsl:apply-templates select="gml:name" />
	</xsl:template>

	<xsl:template match="gml:metaDataProperty | gml:description | gml:descriptionReference | gml:identifier | gml:name">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()" />
		</xsl:copy>
	</xsl:template>

	<xsl:template name="gml:AbstractGMLType">
		<!-- These elements have custom IDs in their templates, exclude them here to avoid overriding custom IDs -->
		<xsl:if test="name()!=gml:Solid and name()!=gml:MultiSurface">
			<xsl:copy-of select="@gml:id" />
		</xsl:if>
		
		<xsl:call-template name="gml:StandardObjectProperties" />
	</xsl:template>

	<xsl:template name="gml:AbstractFeatureType">
		<xsl:call-template name="gml:AbstractGMLType" />
		<xsl:apply-templates select="gml:boundedBy" />
		<xsl:apply-templates select="gml:location" />
	</xsl:template>

	<xsl:template match="gml:boundedBy | gml:location">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()" />
		</xsl:copy>
	</xsl:template>

	<xsl:template name="core:AbstractFeatureWithLifespanType">
		<xsl:call-template name="gml:AbstractFeatureType" />
		<xsl:apply-templates select="*[local-name()='creationDate']" />
		<xsl:apply-templates select="*[local-name()='terminationDate']" />
		<xsl:apply-templates select="*[local-name()='validFrom']" />
		<xsl:apply-templates select="*[local-name()='validTo']" />
	</xsl:template>

	<xsl:template match="*[local-name()='creationDate']">
		<xsl:copy>
			<xsl:choose>
				<xsl:when test="contains(text(), 'T')">
					<xsl:value-of select="text()" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat(text(), 'T00:00:00')" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="*[local-name()='terminationDate']">
		<xsl:copy>
			<xsl:choose>
				<xsl:when test="contains(text(), 'T')">
					<xsl:value-of select="text()" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat(text(), 'T00:00:00')" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="*[local-name()='validFrom']">
		<xsl:copy>
			<xsl:choose>
				<xsl:when test="contains(text(), 'T')">
					<xsl:value-of select="text()" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat(text(), 'T00:00:00')" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="*[local-name()='validTo']">
		<xsl:copy>
			<xsl:choose>
				<xsl:when test="contains(text(), 'T')">
					<xsl:value-of select="text()" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat(text(), 'T00:00:00')" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="*[local-name()='cityObjectMember']">
		<xsl:copy>
			<xsl:apply-templates select="bldg:Building" />
		</xsl:copy>
	</xsl:template>

	<!-- Transform app:appearanceMember -->
	<xsl:template match="app:appearanceMember">
		<appearanceMember>
			<xsl:apply-templates select="app:Appearance" />
		</appearanceMember>
	</xsl:template>
    
<!-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
<!-- +++++++++++++++++++++++++ BUILDING +++++++++++++++++++++++++ -->
<!-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
	<xsl:template name="core:AbstractCityObjectType">
		<xsl:call-template name="core:AbstractFeatureWithLifespanType" />
		<xsl:apply-templates select="*[local-name()='externalReference']" />
		<xsl:apply-templates select="*[local-name()='generalizesTo']" />
		<xsl:apply-templates select="*[local-name()='relativeToTerrain']" />
		<xsl:apply-templates select="*[local-name()='relativeToWater']" />
		<xsl:apply-templates select="gen:stringAttribute | gen:intAttribute | gen:doubleAttribute | gen:dateAttribut | gen:uriAttribute | gen:measureAttribute" />
		<xsl:apply-templates select="dyn:dynamizer" />
	</xsl:template>

	<xsl:template match="*[local-name()='externalReference']">
		<xsl:element name="externalReference">
			<xsl:element name="ExternalReference">
				<xsl:element name="targetResource">
					<xsl:value-of select="concat('urn:adv:oid:', *[local-name()='externalObject']/*[local-name()='name'])" />
				</xsl:element>
				<xsl:element name="informationSystem">
					<xsl:value-of select="*[local-name()='informationSystem']/text()" />
				</xsl:element>
			</xsl:element>
		</xsl:element>
	</xsl:template>

	<xsl:template match="*[local-name()='generalizesTo']">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()" />
		</xsl:copy>
	</xsl:template>

	<xsl:template match="*[local-name()='relativeToTerrain']">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()" />
		</xsl:copy>
	</xsl:template>

	<xsl:template match="*[local-name()='relativeToWater']">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()" />
		</xsl:copy>
	</xsl:template>

	<xsl:template match="app:appearance">
		<xsl:element name="core:appearance">
			<xsl:element name="app:Appearance">
				<xsl:copy-of select="app:Appearance/@*" />
				<xsl:element name="app:theme">
					<xsl:value-of select="app:Appearance/app:theme/text()" />
				</xsl:element>
				<xsl:for-each select="app:Appearance/app:surfaceDataMember">
					<xsl:element name="app:surfaceDataMember">
						<xsl:choose>
							<xsl:when test="app:ParameterizedTexture">
								<xsl:element name="app:ParameterizedTexture">
									<xsl:copy-of select="app:ParameterizedTexture/@*" />
									<xsl:copy-of select="app:ParameterizedTexture/child::node()[name()!='app:target']" />
									<xsl:element name="app:target">
										<xsl:element name="app:TextureAssociation">
											<xsl:element name="app:uri">
												<xsl:value-of select="app:ParameterizedTexture/app:target/@uri" />
											</xsl:element>
											<xsl:element name="app:target">
												<xsl:if test="app:ParameterizedTexture/app:target/app:TexCoordList">
													<xsl:element name="app:TexCoordList">
														<xsl:element name="app:textureCoordinates">
															<xsl:value-of select="app:ParameterizedTexture/app:target/app:TexCoordList/app:textureCoordinates/text()" />
														</xsl:element>
														<xsl:element name="app:ring">
															<xsl:value-of select="app:ParameterizedTexture/app:target/app:TexCoordList/app:textureCoordinates/@ring" />
														</xsl:element>
													</xsl:element>
												</xsl:if>
											</xsl:element>
										</xsl:element>
									</xsl:element>
								</xsl:element>
							</xsl:when>
							<xsl:otherwise>
								<xsl:copy-of select="@*|node()" />
							</xsl:otherwise>
						</xsl:choose>
					</xsl:element>
				</xsl:for-each>
			</xsl:element>
		</xsl:element>
	</xsl:template>

	<xsl:template match="gen:stringAttribute">
		<xsl:element name="genericAttribute">
			<xsl:element name="gen:StringAttribute">
				<xsl:element name="gen:name">
					<xsl:value-of select="@name" />
				</xsl:element>
				<xsl:element name="gen:value">
					<xsl:value-of select="gen:value" />
				</xsl:element>
			</xsl:element>
		</xsl:element>
	</xsl:template>

	<xsl:template match="gen:intAttribute">
		<xsl:element name="genericAttribute">
			<xsl:element name="gen:IntAttribute">
				<xsl:element name="gen:name">
					<xsl:value-of select="@name" />
				</xsl:element>
				<xsl:element name="gen:value">
					<xsl:value-of select="gen:value" />
				</xsl:element>
			</xsl:element>
		</xsl:element>
	</xsl:template>

	<xsl:template match="gen:doubleAttribute">
		<xsl:element name="genericAttribute">
			<xsl:element name="gen:DoubleAttribute">
				<xsl:element name="gen:name">
					<xsl:value-of select="@name" />
				</xsl:element>
				<xsl:element name="gen:value">
					<xsl:value-of select="gen:value" />
				</xsl:element>
			</xsl:element>
		</xsl:element>
	</xsl:template>

	<xsl:template match="gen:dateAttribute">
		<xsl:element name="genericAttribute">
			<xsl:element name="gen:DateAttribute">
				<xsl:element name="gen:name">
					<xsl:value-of select="@name" />
				</xsl:element>
				<xsl:element name="gen:value">
					<xsl:value-of select="gen:value" />
				</xsl:element>
			</xsl:element>
		</xsl:element>
	</xsl:template>

	<xsl:template match="gen:uriAttribute">
		<xsl:element name="genericAttribute">
			<xsl:element name="gen:UriAttribute">
				<xsl:element name="gen:name">
					<xsl:value-of select="@name" />
				</xsl:element>
				<xsl:element name="gen:value">
					<xsl:value-of select="gen:value" />
				</xsl:element>
			</xsl:element>
		</xsl:element>
	</xsl:template>

	<xsl:template match="gen:measureAttribute">
		<xsl:element name="genericAttribute">
			<xsl:element name="gen:MeasureAttribute">
				<xsl:element name="gen:name">
					<xsl:value-of select="@name" />
				</xsl:element>
				<xsl:element name="gen:value">
					<xsl:copy-of select="gen:value/@*" />
					<xsl:value-of select="gen:value" />
				</xsl:element>
			</xsl:element>
		</xsl:element>
	</xsl:template>

	<xsl:template match="dyn:dynamizer">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()" />
		</xsl:copy>
	</xsl:template>

	<xsl:template name="core:AbstractTopLevelCityObjectType">
		<xsl:call-template name="core:AbstractCityObjectType" />
	</xsl:template>

	<xsl:template name="simpleAttrs">
		<xsl:copy-of select="@xlink:type | @xlink:href | @xlink:role | @xlink:arcrole | @xlink:title | @xlink:show | @xlink:actuate" />
	</xsl:template>

	<xsl:template name="gml:AssociationAttributeGroup">
		<xsl:call-template name="simpleAttrs" />
		<xsl:copy-of select="@gml:nilReason" />
		<xsl:copy-of select="@gml:remoteSchema" />
	</xsl:template>

	<xsl:template name="gml:OwnershipAttributeGroup">
		<xsl:param
			name="currentNode"
			select="." />
		<xsl:copy-of select="@gml:owns" />
	</xsl:template>

	<xsl:template name="core:AbstractSpaceType">
		<xsl:call-template name="core:AbstractCityObjectType" />
		<xsl:apply-templates select="gml:occupancyDaytime" />
		<xsl:apply-templates select="gml:occupancyNighttime" />
		<xsl:apply-templates select="gml:spaceType" />
		<xsl:apply-templates select="bldg:lod0Point" />
		<xsl:apply-templates select="bldg:lod0MultiSurface" />
		<xsl:apply-templates select="bldg:lod1Solid" />
		<xsl:apply-templates select="bldg:lod2Solid" />
		<xsl:apply-templates select="bldg:lod2MultiSurface" />
		<xsl:apply-templates select="bldg:lod2MultiCurve" />
		<xsl:apply-templates select="bldg:boundedBy" />
		<xsl:apply-templates select="bldg:lod3Solid" />
		<xsl:apply-templates select="bldg:lod3MultiSurface" />
		<xsl:apply-templates select="bldg:lod3MultiCurve" />
		<!-- TODO LOD4 does not exists anymore, change them in LOD3? -->
		<xsl:apply-templates select="bldg:lod4Solid" />
		<xsl:apply-templates select="bldg:lod4MultiSurface" />
		<xsl:apply-templates select="bldg:lod4MultiCurve" />
	</xsl:template>

	<xsl:template name="core:AbstractPhysicalSpaceType">
		<xsl:call-template name="core:AbstractSpaceType" />
		<xsl:apply-templates select="bldg:lod1TerrainIntersectionCurve" />
		<xsl:apply-templates select="bldg:lod2TerrainIntersectionCurve" />
		<xsl:apply-templates select="bldg:lod3TerrainIntersectionCurve" />
		<xsl:apply-templates select="pointCloud" />
	</xsl:template>

	<xsl:template name="core:AbstractOccupiedSpaceType">
		<xsl:call-template name="core:AbstractPhysicalSpaceType" />
		<xsl:apply-templates select="bldg:opening" />
		<xsl:apply-templates select="bldg:lod1ImplicitRepresentation" />
		<xsl:apply-templates select="bldg:lod2ImplicitRepresentation" />
		<xsl:apply-templates select="bldg:lod3ImplicitRepresentation" />
	</xsl:template>

	<xsl:template name="con:ConstructionSpace">
		<xsl:call-template name="core:AbstractOccupiedSpaceType" />
	</xsl:template>

	<xsl:template name="con:AbstractConstructionType">
		<xsl:call-template name="core:AbstractOccupiedSpaceType" />
		<xsl:apply-templates select="bldg:conditionOfConstruction" />
		<xsl:apply-templates select="bldg:dateOfConstruction" />
		<xsl:apply-templates select="bldg:dateOfRenovation" />
		<xsl:apply-templates select="bldg:dateOfDemolition" />
		<xsl:apply-templates select="bldg:elevation" />
		<xsl:apply-templates select="bldg:measuredHeight" />
	</xsl:template>

	<xsl:template match="bldg:conditionOfConstruction">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()" />
		</xsl:copy>
	</xsl:template>

	<xsl:template match="bldg:dateOfConstruction | bldg:dateOfRenovation | bldg:dateOfDemolition">
		<xsl:copy>
			<xsl:choose>
				<xsl:when test="contains(text(), 'T')">
					<xsl:value-of select="text()" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat(text(), 'T00:00:00')" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="bldg:elevation">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()" />
		</xsl:copy>
	</xsl:template>

	<!-- Transform bldg:measuredHeight -->
	<xsl:template match="bldg:measuredHeight">
		<xsl:element name="con:heightAboveGround">
			<xsl:element name="con:HeightAboveGround">
				<xsl:element name="con:heightReference">highestRoofEdge</xsl:element>
				<xsl:element name="con:lowReference">lowestGroundPoint</xsl:element>
				<xsl:element name="con:status">measured</xsl:element>
				<xsl:element name="con:value">
					<xsl:if test="@uom">
						<xsl:attribute name="uom">
							<xsl:value-of select="@uom" />
						</xsl:attribute>
					</xsl:if>
					<xsl:value-of select="text()" />
				</xsl:element>
			</xsl:element>
		</xsl:element>
	</xsl:template>

	<xsl:template match="bldg:Building">
		<xsl:copy>
			<xsl:call-template name="con:AbstractConstructionType" />

			<xsl:apply-templates select="bldg:class" />
			<xsl:apply-templates select="bldg:function" />
			<xsl:apply-templates select="bldg:usage" />
			<xsl:apply-templates select="bldg:roofType" />
			<xsl:apply-templates select="bldg:storeysAboveGround" />
			<xsl:apply-templates select="bldg:storeysBelowGround" />
			<xsl:apply-templates select="bldg:storeyHeightsAboveGround" />
			<xsl:apply-templates select="bldg:storeyHeightsBelowGround" />

			<!-- TODO -->
			<xsl:apply-templates select="bldg:buildingConstructiveElement" />
			<xsl:apply-templates select="bldg:buildingInstallation" />

			<!-- TODO -->
			<xsl:apply-templates select="bldg:interiorRoom" />
			<xsl:apply-templates select="bldg:buildingFurniture" />
			<xsl:apply-templates select="bldg:buildingSubdivision" />

			<xsl:apply-templates select="bldg:address" />

			<xsl:apply-templates select="bldg:buildingPart" />
		</xsl:copy>
	</xsl:template>

	<xsl:template match="bldg:class | bldg:function | bldg:usage | bldg:roofType | bldg:storeysAboveGround | bldg:storeysBelowGround | bldg:storeyHeightsAboveGround | bldg:storeyHeightsBelowGround">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()" />
		</xsl:copy>
	</xsl:template>

	<xsl:template match="bldg:buildingConstructiveElement | bldg:buildingInstallation" />

	<!-- Change namespace bldg of WallSurface to con -->
	<xsl:template match="bldg:WallSurface">
		<xsl:element name="con:WallSurface">
			<xsl:apply-templates select="@*|node()" />
		</xsl:element>
	</xsl:template>
    
    <!-- Change namespace bldg of RoofSurface to con -->
	<xsl:template match="bldg:RoofSurface">
		<xsl:element name="con:RoofSurface">
			<xsl:apply-templates select="@*|node()" />
		</xsl:element>
	</xsl:template>
    
    <!-- Change namespace bldg of GroundSurface to con -->
	<xsl:template match="bldg:GroundSurface">
		<xsl:element name="con:GroundSurface">
			<xsl:apply-templates select="@*|node()" />
		</xsl:element>
	</xsl:template>
    
    <!-- Change gml:CompositeSurface to gml:Shell -->
	<xsl:template match="gml:CompositeSurface">
		<xsl:element name="gml:Shell">
			<xsl:apply-templates select="@*|node()" />
		</xsl:element>
	</xsl:template>
    
    <!-- Remove namespace bldg of lodXMultiSurface -->
	<xsl:template match="bldg:lod1MultiSurface">
		<xsl:element name="lod1MultiSurface">
			<xsl:apply-templates select="@*|node()" />
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="bldg:lod2MultiSurface">
		<xsl:element name="lod2MultiSurface">
			<xsl:apply-templates select="@*|node()" />
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="bldg:lod3MultiSurface">
		<xsl:element name="lod3MultiSurface">
			<xsl:apply-templates select="@*|node()" />
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="bldg:lod4Solid" />
	
	<xsl:template match="bldg:lod4MultiSurface" />
	
	<xsl:template match="bldg:lod4MultiCurve" />
    
    <!-- Generate uniquely identified IDs for gml:MultiSurface -->
	<xsl:template match="gml:MultiSurface">
		<xsl:element name="gml:MultiSurface">
			<xsl:attribute name="gml:id">
                <xsl:value-of select="concat(../../@gml:id, '_msl_', generate-id())" />
            </xsl:attribute>
			<xsl:apply-templates select="@*|node()" />
		</xsl:element>
	</xsl:template>
    
    <!-- Generate uniquely identified IDs for gml:Solid -->
	<xsl:template match="gml:Solid">
		<xsl:element name="gml:Solid">
			<xsl:attribute name="gml:id">
                <xsl:value-of select="concat(../../@gml:id, '_sl_', generate-id())" />
            </xsl:attribute>
			<xsl:apply-templates select="@*|node()" />
		</xsl:element>
	</xsl:template>

	<xsl:template match="lod1TerrainIntersectionCurve | lod2TerrainIntersectionCurve | lod3TerrainIntersectionCurve | pointCloud">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()" />
		</xsl:copy>
	</xsl:template>

	<xsl:template match="lod1ImplicitRepresentation | lod2ImplicitRepresentation | lod3ImplicitRepresentation">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()" />
		</xsl:copy>
	</xsl:template>

	<xsl:template match="bldg:lod0Footprint">
		<xsl:element name="lod0MultiSurface">
			<xsl:apply-templates select="@*|node()" />
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="bldg:lod1Solid">
		<xsl:element name="lod1Solid">
			<xsl:apply-templates select="@*|node()" />
		</xsl:element>
	</xsl:template>

	<xsl:template match="bldg:lod2Solid">
		<xsl:element name="lod2Solid">
			<xsl:apply-templates select="@*|node()" />
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="bldg:lod3Solid">
		<xsl:element name="lod3Solid">
			<xsl:apply-templates select="@*|node()" />
		</xsl:element>
	</xsl:template>

	<xsl:template match="bldg:boundedBy">
		<xsl:element name="boundary">
			<xsl:apply-templates select="@*|node()" />
		</xsl:element>
	</xsl:template>
	
	<!-- TODO -->
	<xsl:template match="bldg:opening" />

	<xsl:template match="bldg:interiorRoom | bldg:buildingFurniture | bldg:buildingSubdivision" />

	<xsl:template match="bldg:address">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()" />
		</xsl:copy>
	</xsl:template>

	<xsl:template match="bldg:buildingPart">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()" />
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>
