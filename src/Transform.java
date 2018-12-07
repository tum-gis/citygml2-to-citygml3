
/*
 * citygml2-to-citygml3
 *
 * Developer:
 * Son H. Nguyen (son.nguyen@tum.de)
 *
 * With support regarding CityGML encodings from
 * Thomas H. Kolbe (thomas.kolbe@tum.de)
 * Tatjana Kutzner (kutzner@tum.de)
 *
 * MIT License
 *
 * Copyright (c) 2018 Chair of Geoinformatics, Technical University of Munich
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.nio.file.Files;

import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.TransformerFactoryConfigurationError;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;

public class Transform {
    public Transform() {
    }

    public static void main(String[] args) throws TransformerFactoryConfigurationError, TransformerException, IOException {
        String sourceXMLFile = "input/CityGML_v2.gml";
        String sourceXSLFile = "xsl/Transform.xsl";
        String outputXMLFile = "output/CityGML_v3_Transformed.gml";

        if (args.length >= 3) {
            if ((args[0] != null) && (!args[0].equals(""))) {
                sourceXMLFile = args[0];
            }

            if ((args[1] != null) && (!args[1].equals(""))) {
                sourceXSLFile = args[1];
            }

            if ((args[2] != null) && (!args[2].equals(""))) {
                outputXMLFile = args[2];
            }
        }

        String outputXMLFile_tmp = "output/Tmp.gml";

        System.out.println("Transforming...");
        long startTime = System.nanoTime();

        Source xmlInput = new StreamSource(new File(sourceXMLFile));
        Source xsl = new StreamSource(new File(sourceXSLFile));
        File outputXMLTmp = new File(outputXMLFile_tmp);
        javax.xml.transform.Result xmlOutput = new StreamResult(outputXMLTmp);

        Transformer transformer = TransformerFactory.newInstance().newTransformer(xsl);
        transformer.transform(xmlInput, xmlOutput);

        BufferedReader bReader = new BufferedReader(new java.io.FileReader(outputXMLTmp));
        BufferedWriter bWriter = new BufferedWriter(new FileWriter(new File(outputXMLFile)));

        String line = null;
        boolean found = false;

        String xsdLocation = "../";

        while ((line = bReader.readLine()) != null) {
            if ((!found) && (line.trim().contains("<CityModel"))) {
                found = true;
                line = "<CityModel gml:id=\"cm1\" "
                        + "xmlns:app=\"http://www.opengis.net/citygml/appearance/3.0\" "
                        + "xmlns:brid=\"http://www.opengis.net/citygml/bridge/3.0\" "
                        + "xmlns:bldg=\"http://www.opengis.net/citygml/building/3.0\" "
                        + "xmlns:frn=\"http://www.opengis.net/citygml/cityfurniture/3.0\" "
                        + "xmlns:grp=\"http://www.opengis.net/citygml/cityobjectgroup/3.0\" "
                        + "xmlns:con=\"http://www.opengis.net/citygml/construction/3.0\" "
                        + "xmlns:pcl=\"http://www.opengis.net/pointcloud/3.0\" "
                        + "xmlns:core=\"http://www.opengis.net/citygml/3.0\" "
                        + "xmlns:dyn=\"http://www.opengis.net/citygml/dynamizer/3.0\" "
                        + "xmlns:gen=\"http://www.opengis.net/citygml/generics/3.0\" "
                        + "xmlns:luse=\"http://www.opengis.net/citygml/landuse/3.0\" "
                        + "xmlns:dem=\"http://www.opengis.net/citygml/relief/3.0\" "
                        + "xmlns:tex=\"http://www.opengis.net/citygml/texturedsurface/2.0\" "
                        + "xmlns:tran=\"http://www.opengis.net/citygml/transportation/3.0\" "
                        + "xmlns:tun=\"http://www.opengis.net/citygml/tunnel/3.0\" "
                        + "xmlns:veg=\"http://www.opengis.net/citygml/vegetation/3.0\" "
                        + "xmlns:vers=\"http://www.opengis.net/citygml/versioning/3.0\" "
                        + "xmlns:wtr=\"http://www.opengis.net/citygml/waterbody/3.0\" "
                        + "xmlns:tsml=\"http://www.opengis.net/tsml/1.0\" "
                        + "xmlns:sos=\"http://www.opengis.net/sos/2.0\" "
                        + "xmlns:xAL=\"urn:oasis:names:tc:ciq:xsdschema:xAL:2.0\" "
                        + "xmlns:xlink=\"http://www.w3.org/1999/xlink\" "
                        + "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" "
                        + "xmlns:gml=\"http://www.opengis.net/gml/3.2\" "
                        + "xmlns=\"http://www.opengis.net/citygml/3.0\" "
                        + "xsi:schemaLocation=\""
                        + "http://www.opengis.net/citygml/3.0 " + xsdLocation + "cityGMLBase.xsd "
                        + "http://www.opengis.net/citygml/appearance/3.0 " + xsdLocation + "appearance.xsd "
                        + "http://www.opengis.net/citygml/bridge/3.0 " + xsdLocation + "bridge.xsd "
                        + "http://www.opengis.net/citygml/building/3.0 " + xsdLocation + "building.xsd "
                        + "http://www.opengis.net/citygml/cityfurniture/3.0 " + xsdLocation + "cityFurniture.xsd "
                        + "http://www.opengis.net/citygml/cityobjectgroup/3.0 " + xsdLocation + "cityObjectGroup.xsd "
                        + "http://www.opengis.net/citygml/construction/3.0 " + xsdLocation + "construction.xsd "
                        + "http://www.opengis.net/citygml/pointcloud/3.0 " + xsdLocation + "pointcloud.xsd "
                        + "http://www.opengis.net/citygml/dynamizer/3.0 " + xsdLocation + "dynamizer.xsd "
                        + "http://www.opengis.net/citygml/generics/3.0 " + xsdLocation + "generics.xsd "
                        + "http://www.opengis.net/citygml/landuse/3.0 " + xsdLocation + "landUse.xsd "
                        + "http://www.opengis.net/citygml/relief/3.0 " + xsdLocation + "relief.xsd "
                        + "http://www.opengis.net/citygml/texturedsurface/2.0 " + "http://schemas.opengis.net/citygml/texturedsurface/2.0/texturedSurface.xsd "
                        + "http://www.opengis.net/citygml/transportation/3.0 " + xsdLocation + "transportation.xsd "
                        + "http://www.opengis.net/citygml/tunnel/3.0 " + xsdLocation + "tunnel.xsd "
                        + "http://www.opengis.net/citygml/vegetation/3.0 " + xsdLocation + "vegetation.xsd "
                        + "http://www.opengis.net/citygml/versioning/3.0 " + xsdLocation + "versioning.xsd "
                        + "http://www.opengis.net/citygml/waterbody/3.0 " + xsdLocation + "waterBody.xsd "
                        + "http://www.opengis.net/tsml/1.0 http://schemas.opengis.net/tsml/1.0/timeseriesML.xsd "
                        + "http://www.opengis.net/sos/2.0 http://schemas.opengis.net/sos/2.0/sosGetObservation.xsd "
                        + "urn:oasis:names:tc:ciq:xsdschema:xAL:2.0 http://schemas.opengis.net/citygml/xAL/xAL.xsd\">";
            }

            bWriter.write(line);
            bWriter.newLine();
        }

        bReader.close();
        bWriter.close();
        Files.delete(outputXMLTmp.toPath());

        long endTime = System.nanoTime();
        System.out.println("Transformation done in " + (endTime - startTime) / 1e9 + " seconds!\n"
                + "File output: " + outputXMLFile);
    }
}
