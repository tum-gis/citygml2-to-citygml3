<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    version="2.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:xalan="http://xml.apache.org/xslt" 
    xmlns:xlink="http://www.w3.org/1999/xlink" 
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
    xmlns:xAL="urn:oasis:names:tc:ciq:xsdschema:xAL:2.0" 
    xmlns:con="http://www.opengis.net/citygml/construction/3.0" 
    
    xmlns="http://www.opengis.net/citygml/2.0" 
    xmlns:bldg="http://www.opengis.net/citygml/building/2.0" 
    xmlns:gml="http://www.opengis.net/gml" 
    xmlns:gen="http://www.opengis.net/citygml/generics/2.0" 
    xsi:schemaLocation="http://www.opengis.net/citygml/2.0 http://schemas.opengis.net/citygml/2.0/cityGMLBase.xsd http://www.opengis.net/citygml/building/2.0 http://schemas.opengis.net/citygml/building/2.0/building.xsd http://www.opengis.net/citygml/generics/2.0 http://schemas.opengis.net/citygml/generics/2.0/generics.xsd"
    

    
>
    
    <!-- 
    exclude-result-prefixes="xalan xlink xsi xAl bldg gml gen con"
    
    xmlns:bldgN="http://www.opengis.net/citygml/building/3.0" 
    xmlns:gmlN="http://www.opengis.net/gml/3.2" 
    xmlns:genN="http://www.opengis.net/citygml/generics/3.0" 
    xmlns:defaultN="http://www.opengis.net/citygml/3.0"  
    xsi:schemaLocationN="http://www.opengis.net/citygml/3.0 ../xsds/cityGMLBase.xsd http://www.opengis.net/citygml/building/3.0 ../xsds/building.xsd http://www.opengis.net/citygml/construction/3.0 ../xsds/construction.xsd http://www.opengis.net/citygml/generics/3.0 ../xsds/generics.xsd"-->

    <!--Post processing texts-->
    <xsl:strip-space elements="*"/>
    <xsl:output method="xml" indent="yes" xalan:indent-amount="4" standalone="yes"/>
    
    <!--Use this to move all namespace declarations to root-->
    <xsl:template match="/*">
        <CityModel>
            <xsl:apply-templates select="@*|node()"/>
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

    <!--Identity transformation-->
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
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
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates select="(bldg:boundedBy|bldg:lod2Solid)[1]/preceding-sibling::node()[name()!='bldg:boundedBy' and name()!='bldg:lod2Solid']"/>
            <bldg:buildingSpace>
                <con:ConstructionSpace>
                    <xsl:attribute name="gml:id">
                        <xsl:value-of select="concat('csl_', generate-id())" />
                    </xsl:attribute>
                    <xsl:for-each select="bldg:boundedBy">
                        <boundary>
                            <xsl:apply-templates select="@*|node()" />
                        </boundary>
                    </xsl:for-each>
                    <xsl:for-each select="bldg:lod2Solid">
                        <lod2Solid>
                            <xsl:apply-templates select="@*|node()" />
                        </lod2Solid>
                    </xsl:for-each>
                </con:ConstructionSpace>
            </bldg:buildingSpace>
            <xsl:apply-templates select="(bldg:boundedBy|bldg:lod2Solid)[1]/following-sibling::node()[name()!='bldg:boundedBy' and name()!='bldg:lod2Solid']"/>
        </xsl:copy>
    </xsl:template>

    <!--Change namespace bldg of WallSurface to con-->
    <xsl:template match="bldg:WallSurface">
        <con:WallSurface>
            <xsl:apply-templates select="@*|node()" />
        </con:WallSurface>
    </xsl:template>
    
    <!--Change namespace bldg of RoofSurface to con-->
    <xsl:template match="bldg:RoofSurface">
        <con:RoofSurface>
            <xsl:apply-templates select="@*|node()" />
        </con:RoofSurface>
    </xsl:template>
    
    <!--Change namespace bldg of GroundSurface to con-->
    <xsl:template match="bldg:GroundSurface">
        <con:GroundSurface>
            <xsl:apply-templates select="@*|node()" />
        </con:GroundSurface>
    </xsl:template>
    
    <!--Change gml:CompositeSurface to gml:Shell-->
    <xsl:template match="gml:CompositeSurface">
        <gml:Shell>
            <xsl:apply-templates select="@*|node()" />
        </gml:Shell>
    </xsl:template>
    
    <!--Remove namespace bldg of lod2MultiSurface-->
    <xsl:template match="bldg:lod2MultiSurface">
        <lod2MultiSurface>
            <xsl:apply-templates select="@*|node()" />
        </lod2MultiSurface>
    </xsl:template>
    
    <!--Generate uniquely identified IDs for gml:MultiSurface-->
    <xsl:template match="gml:MultiSurface">
        <gml:MultiSurface>
            <xsl:attribute name="gml:id">
                <xsl:value-of select="concat('msl_', generate-id())"/>
            </xsl:attribute>
            <xsl:apply-templates select="@*|node()"/>
        </gml:MultiSurface>
    </xsl:template>
    
    <!--Generate uniquely identified IDs for gml:Solid-->
    <xsl:template match="gml:Solid">
        <gml:Solid>
            <xsl:attribute name="gml:id">
                <xsl:value-of select="concat('sl_', generate-id())"/>
            </xsl:attribute>
            <xsl:apply-templates select="@*|node()"/>
        </gml:Solid>
    </xsl:template>

	<!--Transform externalReference -->
	<xsl:template match="*[local-name()='externalReference']">
		<externalReference>
			<ExternalReference>
				<targetResource>
					<xsl:value-of select="concat('urn:adv:oid:', *[local-name()='externalObject']/*[local-name()='name'])" />
				</targetResource>
				<informationSystem>http://repository.gdi-de.org/schemas/adv/citygml/fdv/art.htm#_9100</informationSystem>
			</ExternalReference>
		</externalReference>
	</xsl:template>

	<!--Transform generic string attributes -->
	<xsl:template match="gen:stringAttribute">
		<genericAttribute>
			<gen:StringAttribute>
				<gen:name>
					<xsl:value-of select="@name"/>
				</gen:name>
				<gen:value>
					<xsl:value-of select="gen:value"/>
				</gen:value>
			</gen:StringAttribute>
		</genericAttribute>
	</xsl:template>
	
	<!--Transform generic integer attributes -->
	<xsl:template match="gen:intAttribute">
		<genericAttribute>
			<gen:IntAttribute>
				<gen:name>
					<xsl:value-of select="@name"/>
				</gen:name>
				<gen:value>
					<xsl:value-of select="gen:value"/>
				</gen:value>
			</gen:IntAttribute>
		</genericAttribute>
	</xsl:template>
	
	<!--Transform generic double attributes -->
	<xsl:template match="gen:doubleAttribute">
		<genericAttribute>
			<gen:DoubleAttribute>
				<gen:name>
					<xsl:value-of select="@name"/>
				</gen:name>
				<gen:value>
					<xsl:value-of select="gen:value"/>
				</gen:value>
			</gen:DoubleAttribute>
		</genericAttribute>
	</xsl:template>
	
	<!--Transform generic date attributes -->
	<xsl:template match="gen:dateAttribute">
		<genericAttribute>
			<gen:DateAttribute>
				<gen:name>
					<xsl:value-of select="@name"/>
				</gen:name>
				<gen:value>
					<xsl:value-of select="gen:value"/>
				</gen:value>
			</gen:DateAttribute>
		</genericAttribute>
	</xsl:template>
	
	<!--Transform generic uri attributes -->
	<xsl:template match="gen:uriAttribute">
		<genericAttribute>
			<gen:UriAttribute>
				<gen:name>
					<xsl:value-of select="@name"/>
				</gen:name>
				<gen:value>
					<xsl:value-of select="gen:value"/>
				</gen:value>
			</gen:UriAttribute>
		</genericAttribute>
	</xsl:template>
	
	<!--Transform generic measure attributes -->
	<xsl:template match="gen:measureAttribute">
		<genericAttribute>
			<gen:MeasureAttribute>
				<gen:name>
					<xsl:value-of select="@name"/>
				</gen:name>
				<gen:value>
				 	<xsl:copy-of select="gen:value/@*" />
					<xsl:value-of select="gen:value"/>
				</gen:value>
			</gen:MeasureAttribute>
		</genericAttribute>
	</xsl:template>
    
</xsl:stylesheet>