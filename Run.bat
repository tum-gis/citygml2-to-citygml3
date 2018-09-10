@echo off
java -jar Transform.jar
pause
# Or use your own arguments
# java -jar Transform.jar SourceXMLFile XSLFile OutputXMLFile
# Example
# java -jar Transform.jar input/CityGML_v2.gml Transform.xsl output/CityGML_v3_Transformed.gml
