# CityGML2-to-CityGML3

A small Java program used to transform CityGML v2.0 files to CityGML v3.0.

This project is still in early developement und is subject to changes.

### How to run
The program can be executed by running the `Run.bat` file (in Windows).

The result is by default saved in [CityGML_v3_Transformed.gml](CityGML_v3_Transformed.gml) (only visible after the program is complete).

### Command line
Alternatively, the program can also be executed using the command line:
```batch
java -jar Transform.jar SourceXMLFile XSLFile OutputXMLFile
```
where 

| Arguments        | Description           | Default  |
| ------------- |:-------------| -----|
| `SourceXMLFile`      | The location of the source CityGML v2.0 file | `CityGML_v2.gml` |
| `XSLFile`      | The location of the XSL file used for transformation | `Transform.xsl` |
| `OutputXMLFile`      | The location of the transformed CityGML v3.0 file | `CityGML_v3_Transformed.gml` |

For reference, the [CityGML_v3.gml](CityGML_v3.gml) can be used as an example of how the transformed file should look like.
