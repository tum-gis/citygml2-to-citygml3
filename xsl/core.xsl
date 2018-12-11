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

	<xsl:template name="core:AbstractFeatureWithLifespanType">
		<xsl:call-template name="gml:AbstractFeatureType" />
		<xsl:apply-templates select="*[local-name()='creationDate']" />
		<xsl:apply-templates select="*[local-name()='terminationDate']" />
		<xsl:apply-templates select="*[local-name()='validFrom']" />
		<xsl:apply-templates select="*[local-name()='validTo']" />
		<xsl:apply-templates select="core:AbstractGenericApplicationPropertyOfAbstractFeatureWithLifespan" />
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

	<xsl:template name="core:AbstractCityObjectType">
		<xsl:call-template name="core:AbstractFeatureWithLifespanType" />
		<xsl:apply-templates select="*[local-name()='externalReference']" />
		<xsl:apply-templates select="*[local-name()='generalizesTo']" />
		<xsl:apply-templates select="*[local-name()='relativeToTerrain']" />
		<xsl:apply-templates select="*[local-name()='relativeToWater']" />
		<xsl:apply-templates select="*[local-name()='relatedTo']" /> <!-- NEW -->
		<xsl:apply-templates select="app:appearance" />
		<xsl:apply-templates select="gen:stringAttribute | gen:intAttribute | gen:doubleAttribute | gen:dateAttribut | gen:uriAttribute | gen:measureAttribute" />
		<xsl:apply-templates select="dyn:dynamizer" /> <!-- NEW -->
		<xsl:apply-templates select="core:AbstractGenericApplicationPropertyOfAbstractCityObject" />
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

	<xsl:template name="core:AbstractTopLevelCityObjectType">
		<xsl:call-template name="core:AbstractCityObjectType" />
	</xsl:template>

	<xsl:template name="core:AbstractSpaceType">
		<xsl:call-template name="core:AbstractCityObjectType" />
		<xsl:apply-templates select="gml:occupancyDaytime" />
		<xsl:apply-templates select="gml:occupancyNighttime" />
		<xsl:apply-templates select="gml:spaceType" />
		<xsl:apply-templates select="lod0Point" /> <!-- NEW -->
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
		<xsl:apply-templates select="bldg:lod4MultiCurve" />
		<xsl:apply-templates select="bldg:consistsOfBuildingPart" />
	</xsl:template>

	<xsl:template name="core:AbstractPhysicalSpaceType">
		<xsl:call-template name="core:AbstractSpaceType" />
		<!-- NEW -->
		<xsl:apply-templates select="bldg:lod1TerrainIntersection" /> <!-- lod1TerrainIntersectionCurve -->
		<xsl:apply-templates select="bldg:lod2TerrainIntersection" /> <!-- lod2TerrainIntersectionCurve -->
		<xsl:apply-templates select="bldg:lod3TerrainIntersection" /> <!-- lod3TerrainIntersectionCurve -->
		<xsl:apply-templates select="pointCloud" />
		<xsl:apply-templates select="core:AbstractGenericApplicationPropertyOfAbstractPhysicalSpace" />
	</xsl:template>

	<xsl:template name="core:AbstractOccupiedSpaceType">
		<xsl:call-template name="core:AbstractPhysicalSpaceType" />
		<xsl:apply-templates select="bldg:opening" />
		<!-- NEW -->
		<xsl:apply-templates select="lod1ImplicitRepresentation" />
		<xsl:apply-templates select="lod2ImplicitRepresentation" />
		<xsl:apply-templates select="lod3ImplicitRepresentation" />
		<xsl:apply-templates select="core:AbstractGenericApplicationPropertyOfAbstractOccupiedSpace" />
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

						
	<!-- ++++++++++++++++++++++++++++++++++++++++ -->
	<!-- ++++++++++++++ NEW IN 3.0 ++++++++++++++ -->
	<!-- ++++++++++++++++++++++++++++++++++++++++ -->
	<xsl:template match="lod0Point" />

</xsl:stylesheet>
