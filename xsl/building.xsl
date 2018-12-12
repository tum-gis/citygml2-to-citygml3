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
	
	<xsl:template name="bldg:AbstractBuildingType">
		<xsl:call-template name="con:AbstractConstructionType" />

		<xsl:apply-templates select="bldg:class" />
		<xsl:apply-templates select="bldg:function" />
		<xsl:apply-templates select="bldg:usage" />
		<xsl:apply-templates select="bldg:roofType" />
		<xsl:apply-templates select="bldg:storeysAboveGround" />
		<xsl:apply-templates select="bldg:storeysBelowGround" />
		<xsl:apply-templates select="bldg:storeyHeightsAboveGround" />
		<xsl:apply-templates select="bldg:storeyHeightsBelowGround" />

		<xsl:apply-templates select="bldg:buildingConstructiveElement" />
		<xsl:apply-templates select="bldg:buildingInstallation" />

		<xsl:apply-templates select="bldg:interiorRoom" />
		<xsl:apply-templates select="bldg:buildingFurniture" />
		<xsl:apply-templates select="bldg:buildingSubdivision" />

		<xsl:apply-templates select="bldg:address" />

		<xsl:apply-templates select="bldg:AbstractGenericApplicationPropertyOfAbstractBuilding" />
	</xsl:template>
	
	<xsl:template match="bldg:Building">
		<xsl:copy>
			<xsl:attribute name="gml:id">
                <xsl:value-of select="@gml:id" />
            </xsl:attribute>
	            
			<xsl:call-template name="bldg:AbstractBuildingType" />
			<xsl:apply-templates select="bldg:consistsOfBuildingPart" />
			<xsl:apply-templates select="bldg:AbstractGenericApplicationPropertyOfBuilding" />
		</xsl:copy>
	</xsl:template>

	<xsl:template match="bldg:yearOfConstruction">
		<xsl:element name="con:dateOfConstruction">
			<xsl:choose>
				<xsl:when test="contains(text(), 'T')">
					<xsl:value-of select="concat(text(), '-01-01')" /> <!-- Convert from year to date -->
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat(text(), '-01-01T00:00:00')" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="bldg:yearOfRenovation">
		<xsl:element name="con:dateOfRenovation">
			<xsl:choose>
				<xsl:when test="contains(text(), 'T')">
					<xsl:value-of select="concat(text(), '-01-01')" /> <!-- Convert from year to date -->
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat(text(), '-01-01T00:00:00')" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="bldg:yearOfDemolition">
		<xsl:element name="con:dateOfDemolition">
			<xsl:choose>
				<xsl:when test="contains(text(), 'T')">
					<xsl:value-of select="concat(text(), '-01-01')" /> <!-- Convert from year to date -->
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat(text(), '-01-01T00:00:00')" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:element>
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

	<!-- Change namespace bldg to con -->
	<xsl:template match="bldg:GroundSurface">
		<xsl:element name="con:GroundSurface">
			<xsl:copy-of select="@*" />
			<xsl:call-template name="con:AbstractConstructionSurfaceType" />
			<xsl:apply-templates select="con:AbstractGenericApplicationPropertyOfGroundSurface" />
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="bldg:RoofSurface">
		<xsl:element name="con:RoofSurface">
			<xsl:copy-of select="@*" />
			<xsl:call-template name="con:AbstractConstructionSurfaceType" />
			<xsl:apply-templates select="con:AbstractGenericApplicationPropertyOfRoofSurface" />
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="bldg:CeilingSurface">
		<xsl:element name="con:CeilingSurface">
			<xsl:copy-of select="@*" />
			<xsl:call-template name="con:AbstractConstructionSurfaceType" />
			<xsl:apply-templates select="con:AbstractGenericApplicationPropertyOfCeilingSurface" />
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="bldg:OuterCeilingSurface">
		<xsl:element name="con:OuterCeilingSurface">
			<xsl:copy-of select="@*" />
			<xsl:call-template name="con:AbstractConstructionSurfaceType" />
			<xsl:apply-templates select="con:AbstractGenericApplicationPropertyOfOuterCeilingSurface" />
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="bldg:Door">
		<xsl:element name="con:DoorSurface">
			<xsl:copy-of select="@*" />
			<xsl:call-template name="con:AbstractConstructionSurfaceType" />
			<xsl:apply-templates select="bldg:address" />
			<xsl:apply-templates select="con:AbstractGenericApplicationPropertyOfDoorSurface" />
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="bldg:FloorSurface">
		<xsl:element name="con:FloorSurface">
			<xsl:copy-of select="@*" />
			<xsl:call-template name="con:AbstractConstructionSurfaceType" />
			<xsl:apply-templates select="con:AbstractGenericApplicationPropertyOfFloorSurface" />
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="bldg:OuterFloorSurface">
		<xsl:element name="con:OuterFloorSurface">
			<xsl:copy-of select="@*" />
			<xsl:call-template name="con:AbstractConstructionSurfaceType" />
			<xsl:apply-templates select="con:AbstractGenericApplicationPropertyOfOuterFloorSurface" />
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="bldg:WallSurface">
		<xsl:element name="con:WallSurface">
			<xsl:copy-of select="@*" />
			<xsl:call-template name="con:AbstractConstructionSurfaceType" />
			<xsl:apply-templates select="con:AbstractGenericApplicationPropertyOfWallSurface" />
		</xsl:element>
	</xsl:template>
    
	<xsl:template match="bldg:ClosureSurface">
		<xsl:element name="ClosureSurface">
			<xsl:copy-of select="@*" />
			<xsl:call-template name="core:AbstractSpaceBoundaryType" />
			<xsl:apply-templates select="core:AbstractGenericApplicationPropertyOfClosureSurface" />
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="bldg:InteriorWallSurface">
		<xsl:element name="con:InteriorWallface">
			<xsl:copy-of select="@*" />
			<xsl:call-template name="con:AbstractConstructionSurfaceType" />
			<xsl:apply-templates select="con:AbstractGenericApplicationPropertyOfInteriorWallSurface" />
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="bldg:Window">
		<xsl:element name="con:WindowSurface">
			<xsl:copy-of select="@*" />
			<xsl:call-template name="con:AbstractConstructionSurfaceType" />
			<xsl:apply-templates select="con:AbstractGenericApplicationPropertyOfWindowSurface" />
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
	
	<!-- Change all LOD4 to LOD3 -->
	<xsl:template match="bldg:lod4MultiSurface">
		<xsl:element name="lod3MultiSurface">
			<xsl:apply-templates select="@*|node()" />
		</xsl:element>
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
	
	<!-- Change all LOD4 to LOD3 -->
	<xsl:template match="bldg:lod4Solid">
		<xsl:element name="lod3Solid">
			<xsl:apply-templates select="@*|node()" />
		</xsl:element>
	</xsl:template>

	<xsl:template match="bldg:boundedBy">
		<xsl:element name="boundary">
			<xsl:apply-templates select="@*|node()" />
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="bldg:opening">
		<xsl:element name="opening">
			<xsl:apply-templates select="@*|node()" />
		</xsl:element>
	</xsl:template>

	<xsl:template match="bldg:consistsOfBuildingPart">
		<xsl:apply-templates select="bldg:BuildingPart" />
	</xsl:template>

	<xsl:template match="bldg:BuildingPart">
		<xsl:element name="bldg:buildingPart">
			<xsl:element name="bldg:BuildingPart">
				<xsl:apply-templates select="@*|node()" />
			</xsl:element>
		</xsl:element>
	</xsl:template>
	
	<!-- ++++++++++++++++++++++++++++++++++++++++ -->
	<!-- +++++++++++++++++ COPY +++++++++++++++++ -->
	<!-- ++++++++++++++++++++++++++++++++++++++++ -->
	<xsl:template match="bldg:class | 
						bldg:function | 
						bldg:usage | 
						bldg:roofType | 
						bldg:conditionOfConstruction | 
						bldg:elevation | 
						bldg:interiorRoom | 
						bldg:storeysAboveGround | 
						bldg:storeysBelowGround | 
						bldg:storeyHeightsAboveGround | 
						bldg:storeyHeightsBelowGround | 
						bldg:address">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()" />
		</xsl:copy>
	</xsl:template>
	
	<!-- ++++++++++++++++++++++++++++++++++++++++ -->
	<!-- ++++++++++++++++ REMOVE ++++++++++++++++ -->
	<!-- ++++++++++++++++++++++++++++++++++++++++ -->
	<xsl:template match="bldg:lod0FootPrint | 
						bldg:lod0RoofEdge |
						bldg:buildingInstallation |
						bldg:lod4MultiCurve" />
						
	<!-- ++++++++++++++++++++++++++++++++++++++++ -->
	<!-- ++++++++++++++ NEW IN 3.0 ++++++++++++++ -->
	<!-- ++++++++++++++++++++++++++++++++++++++++ -->
	
	<!-- ++++++++++++++++++++++++++++++++++++++++ -->
	<!-- +++++++++++++++++ TODO +++++++++++++++++ -->
	<!-- ++++++++++++++++++++++++++++++++++++++++ -->
	<xsl:template match="bldg:buildingConstructiveElement | 
						bldg:buildingFurniture | 
						bldg:buildingSubdivision" />

</xsl:stylesheet>