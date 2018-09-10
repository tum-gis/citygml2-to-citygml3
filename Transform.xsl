<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    version="2.0" 
    xmlns:app="http://www.opengis.net/citygml/appearance/2.0" 
    xmlns:brid="http://www.opengis.net/citygml/bridge/2.0" 
	xmlns:bldg="http://www.opengis.net/citygml/building/2.0" 
	xmlns:frn="http://www.opengis.net/citygml/cityfurniture/2.0" 
	xmlns:grp="http://www.opengis.net/citygml/cityobjectgroup/2.0" 
	xmlns:con="http://www.opengis.net/citygml/construction/3.0" 
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
	<xsl:output method="xml" indent="yes" xalan:indent-amount="4" standalone="yes" />
    
    <!-- Use this to move all namespace declarations to root -->
	<xsl:template match="/*">
		<CityModel>
			<xsl:apply-templates select="@*|node()" />
		</CityModel>
	</xsl:template>
    
<!--    <xsl:template match="/*">
        <CityModel xmlns:xlink="http://www.w3.org/1999/xlink" 
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
        xmlns:xAL="urn:oasis:names:tc:ciq:xsdschema:xAL:2.0" 
        xmlns:con="http://www.opengis.net/citygml/construction/3.0" 
        xmlns:bldg="http://www.opengis.net/citygml/building/3.0" 
        xmlns:gml="http://www.opengis.net/gml/3.2" 
        xmlns:gen="http://www.opengis.net/citygml/generics/3.0" 
        xmlns:default="http://www.opengis.net/citygml/3.0"  
        xsi:schemaLocation="http://www.opengis.net/citygml/3.0 ../xsds/cityGMLBase.xsd http://www.opengis.net/citygml/building/3.0 ../xsds/building.xsd http://www.opengis.net/citygml/construction/3.0 ../xsds/construction.xsd http://www.opengis.net/citygml/generics/3.0 ../xsds/generics.xsd">
            <xsl:apply-templates select="@*|node()"/>
        </CityModel>
    </xsl:template>-->
    
<!--    Update default namespace 
    <xsl:template match="*[namespace-uri() = '']">
        <xsl:element name="{name()}" namespace="http://www.opengis.net/citygml/3.0">
            <xsl:apply-templates select="@*|node()"/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="@*[namespace-uri() = '']">
        <xsl:attribute name="{name()}" namespace="http://www.opengis.net/citygml/3.0">
            <xsl:value-of  select="."/>
        </xsl:attribute>
    </xsl:template>
    
    Update bldg namespace 
    <xsl:template match="bldg:*">
        <xsl:element name="{name()}" namespace="http://www.opengis.net/citygml/building/3.0">
            <xsl:apply-templates select="@*|node()"/>
        </xsl:element>
    </xsl:template>
    
    Update gml namespace 
    <xsl:template match="gml:*">
        <xsl:element name="{name()}" namespace="http://www.opengis.net/gml/3.2">
            <xsl:apply-templates select="@*|node()"/>
        </xsl:element>
    </xsl:template>
    
    Update gen namespace 
    <xsl:template match="gen:*">
        <xsl:element name="{name()}" namespace="http://www.opengis.net/citygml/generics/3.0">
            <xsl:apply-templates select="@*|node()"/>
        </xsl:element>
    </xsl:template>
    
    Update schema location
    <xsl:template match="/*">
        <xsl:element name="{name()}" namespace="{namespace-uri()}">
            <xsl:copy-of select="namespace::*[name()]"/>
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="xsi:schemaLocation">
                <xsl:value-of select="'http://www.opengis.net/citygml/3.0 ../xsds/cityGMLBase.xsd http://www.opengis.net/citygml/building/3.0 ../xsds/building.xsd http://www.opengis.net/citygml/construction/3.0 ../xsds/construction.xsd http://www.opengis.net/citygml/generics/3.0 ../xsds/generics.xsd'"/>
            </xsl:attribute>
            <xsl:apply-templates select="node()"/>
        </xsl:element>
    </xsl:template>-->
    
    <!-- Identity transformation -->
	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()" />
		</xsl:copy>
	</xsl:template>
    
    <!--
    Create new bldg:buildingSpace
    Create new con:ConstructionSpace
    Add a gml:id to con:ConstructionSpace
    Move bldg:lod2Solid and bldg:boundedBy
    Rename bldg:boundedBy to boundary
    Remove bldg of bldg:lod2Solid
    All other children and attributes will be copied before/after bldg:boundedBy and bldg:lod2Solid depending on whichever comes first-->
	<xsl:template match="bldg:Building">
		<xsl:copy>
			<xsl:copy-of select="@*" />

			<!-- Transform gml:name -->
			<xsl:apply-templates select="gml:name" />
			
			<!-- Transform creationDate -->
			<xsl:apply-templates select="*[local-name()='creationDate']" />
	
		    <!-- Transform externalReference -->
			<xsl:apply-templates select="*[local-name()='externalReference']" />
			
			<!-- Transform app:appearance -->
			<xsl:apply-templates select="app:appearance" />
			
			<!-- Transform generics attributes -->
			<xsl:apply-templates select="gen:stringAttribute | gen:intAttribute | gen:doubleAttribute | gen:dateAttribut | gen:uriAttribute | gen:measureAttribute" />
	
						<!-- Transform bldg:function -->
			<xsl:apply-templates select="bldg:function" />
			
			<!-- Transform bldg:roofType -->
			<xsl:apply-templates select="bldg:roofType" />
			
			<!-- Transform lod2Solid and bldg:boundedBy -->
			<bldg:buildingSpace>
				<con:ConstructionSpace>
					<xsl:attribute name="gml:id">
	                        <xsl:value-of select="concat(./@gml:id, '_csl_', generate-id())" />
	                    </xsl:attribute>
					<xsl:for-each select="bldg:lod2Solid">
						<lod2Solid>
							<xsl:apply-templates select="@*|node()" />
						</lod2Solid>
					</xsl:for-each>
					<xsl:for-each select="bldg:boundedBy">
						<boundary>
							<xsl:apply-templates select="@*|node()" />
						</boundary>
					</xsl:for-each>
				</con:ConstructionSpace>
			</bldg:buildingSpace>
			
			<!-- Transform bldg:measuredHeight -->
			<xsl:apply-templates select="*[name()='bldg:measuredHeight']" />
		</xsl:copy>
	</xsl:template>
	
	<!-- Transform gml:name -->
	<xsl:template match="gml:name">
		<gml:name>
			<xsl:apply-templates select="@*|node()" />
		</gml:name>
	</xsl:template>
    
    <!-- Transform creationDate -->
	<xsl:template match="*[local-name()='creationDate']">
		<creationDate>
			<xsl:choose>
				<xsl:when test="contains(text(), 'T')">
					<xsl:value-of select="text()" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat(text(), 'T00:00:00')" />
				</xsl:otherwise>
			</xsl:choose>
		</creationDate>
	</xsl:template>
	
	<!-- Transform externalReference -->
	<xsl:template match="*[local-name()='externalReference']">
		<externalReference>
			<ExternalReference>
				<targetResource>
					<xsl:value-of select="concat('urn:adv:oid:', *[local-name()='externalObject']/*[local-name()='name'])" />
				</targetResource>
				<informationSystem>
					<xsl:value-of select="*[local-name()='informationSystem']/text()" />
				</informationSystem>
			</ExternalReference>
		</externalReference>
	</xsl:template>
	
	<!-- Transform generic string attributes -->
	<xsl:template match="gen:stringAttribute">
		<genericAttribute>
			<gen:StringAttribute>
				<gen:name>
					<xsl:value-of select="@name" />
				</gen:name>
				<gen:value>
					<xsl:value-of select="gen:value" />
				</gen:value>
			</gen:StringAttribute>
		</genericAttribute>
	</xsl:template>

	<!-- Transform generic integer attributes -->
	<xsl:template match="gen:intAttribute">
		<genericAttribute>
			<gen:IntAttribute>
				<gen:name>
					<xsl:value-of select="@name" />
				</gen:name>
				<gen:value>
					<xsl:value-of select="gen:value" />
				</gen:value>
			</gen:IntAttribute>
		</genericAttribute>
	</xsl:template>
	
	<!-- Transform generic double attributes -->
	<xsl:template match="gen:doubleAttribute">
		<genericAttribute>
			<gen:DoubleAttribute>
				<gen:name>
					<xsl:value-of select="@name" />
				</gen:name>
				<gen:value>
					<xsl:value-of select="gen:value" />
				</gen:value>
			</gen:DoubleAttribute>
		</genericAttribute>
	</xsl:template>
	
	<!-- Transform generic date attributes -->
	<xsl:template match="gen:dateAttribute">
		<genericAttribute>
			<gen:DateAttribute>
				<gen:name>
					<xsl:value-of select="@name" />
				</gen:name>
				<gen:value>
					<xsl:value-of select="gen:value" />
				</gen:value>
			</gen:DateAttribute>
		</genericAttribute>
	</xsl:template>
	
	<!-- Transform generic uri attributes -->
	<xsl:template match="gen:uriAttribute">
		<genericAttribute>
			<gen:UriAttribute>
				<gen:name>
					<xsl:value-of select="@name" />
				</gen:name>
				<gen:value>
					<xsl:value-of select="gen:value" />
				</gen:value>
			</gen:UriAttribute>
		</genericAttribute>
	</xsl:template>

	<!-- Transform generic measure attributes -->
	<xsl:template match="gen:measureAttribute">
		<genericAttribute>
			<gen:MeasureAttribute>
				<gen:name>
					<xsl:value-of select="@name" />
				</gen:name>
				<gen:value>
					<xsl:copy-of select="gen:value/@*" />
					<xsl:value-of select="gen:value" />
				</gen:value>
			</gen:MeasureAttribute>
		</genericAttribute>
	</xsl:template>

	<!-- Transform app:appearance -->
	<xsl:template match="app:appearance">
		<core:appearance>
			<app:Appearance>
				<xsl:copy-of select="app:Appearance/@*" />
				<app:theme>
					<xsl:value-of select="app:Appearance/app:theme/text()" />
				</app:theme>
				<xsl:for-each select="app:Appearance/app:surfaceDataMember">
					<app:surfaceDataMember>
						<xsl:choose>
							<xsl:when test="app:ParameterizedTexture">
								<app:ParameterizedTexture>
									<xsl:copy-of select="app:ParameterizedTexture/@*" />
									<xsl:copy-of select="app:ParameterizedTexture/child::node()[name()!='app:target']" />
									<app:target>
										<app:TextureAssociation>
											<app:uri>
												<xsl:value-of select="app:ParameterizedTexture/app:target/@uri" />
											</app:uri>
											<app:target>
												<xsl:if test="app:ParameterizedTexture/app:target/app:TexCoordList">
													<app:TexCoordList>
														<app:textureCoordinates>
															<xsl:value-of select="app:ParameterizedTexture/app:target/app:TexCoordList/app:textureCoordinates/text()" />
														</app:textureCoordinates>
														<app:ring>
															<xsl:value-of select="app:ParameterizedTexture/app:target/app:TexCoordList/app:textureCoordinates/@ring" />
														</app:ring>
													</app:TexCoordList>
												</xsl:if>
											</app:target>
										</app:TextureAssociation>
									</app:target>
								</app:ParameterizedTexture>
							</xsl:when>
							<xsl:otherwise>
								<xsl:copy-of select="@*|node()" />
							</xsl:otherwise>
						</xsl:choose>
					</app:surfaceDataMember>
				</xsl:for-each>
			</app:Appearance>
		</core:appearance>
	</xsl:template>
	
		<!-- Transform bldg:function -->
	<xsl:template match="bldg:function">
		<bldg:function>
			<xsl:apply-templates select="@*|node()" />
		</bldg:function>
	</xsl:template>
	
	<!-- Transform bldg:roofType -->
	<xsl:template match="bldg:roofType">
		<bldg:roofType>
			<xsl:apply-templates select="@*|node()" />
		</bldg:roofType>
	</xsl:template>
	
	<!-- Transform bldg:measuredHeight -->
	<xsl:template match="bldg:measuredHeight">
		<bldg:heightAboveGround>
			<con:HeightAboveGround>
				<con:heightReference>highestRoofEdge</con:heightReference>
				<con:lowReference>lowestGroundPoint</con:lowReference>
				<con:status>measured</con:status>
				<con:value>
					<xsl:if test="@uom">
						<xsl:attribute name="uom">
	                        <xsl:value-of select="@uom" />
						</xsl:attribute>
					</xsl:if>
					<xsl:value-of select="text()" />
				</con:value>
			</con:HeightAboveGround>
		</bldg:heightAboveGround>
	</xsl:template>

    <!-- Change namespace bldg of WallSurface to con -->
	<xsl:template match="bldg:WallSurface">
		<con:WallSurface>
			<xsl:apply-templates select="@*|node()" />
		</con:WallSurface>
	</xsl:template>
    
    <!-- Change namespace bldg of RoofSurface to con -->
	<xsl:template match="bldg:RoofSurface">
		<con:RoofSurface>
			<xsl:apply-templates select="@*|node()" />
		</con:RoofSurface>
	</xsl:template>
    
    <!-- Change namespace bldg of GroundSurface to con -->
	<xsl:template match="bldg:GroundSurface">
		<con:GroundSurface>
			<xsl:apply-templates select="@*|node()" />
		</con:GroundSurface>
	</xsl:template>
    
    <!-- Change gml:CompositeSurface to gml:Shell -->
	<xsl:template match="gml:CompositeSurface">
		<gml:Shell>
			<xsl:apply-templates select="@*|node()" />
		</gml:Shell>
	</xsl:template>
    
    <!-- Remove namespace bldg of lod2MultiSurface -->
	<xsl:template match="bldg:lod2MultiSurface">
		<lod2MultiSurface>
			<xsl:apply-templates select="@*|node()" />
		</lod2MultiSurface>
	</xsl:template>
    
    <!-- Generate uniquely identified IDs for gml:MultiSurface -->
	<xsl:template match="gml:MultiSurface">
		<gml:MultiSurface>
			<xsl:attribute name="gml:id">
                <xsl:value-of select="concat(../../@gml:id, '_msl_', generate-id())" />
            </xsl:attribute>
			<xsl:apply-templates select="@*|node()" />
		</gml:MultiSurface>
	</xsl:template>
    
    <!-- Generate uniquely identified IDs for gml:Solid -->
	<xsl:template match="gml:Solid">
		<gml:Solid>
			<xsl:attribute name="gml:id">
                <xsl:value-of select="concat(../../@gml:id, '_sl_', generate-id())" />
            </xsl:attribute>
			<xsl:apply-templates select="@*|node()" />
		</gml:Solid>
	</xsl:template>
</xsl:stylesheet>