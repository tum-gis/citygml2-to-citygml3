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
		String sourceXSLFile = "Transform.xsl";
		String outputXMLFile = "output/CityGML_v3_Transformed.gml";

		if ((args.length >= 3) && (args[0] != null) && (!args[0].equals(""))) {
			sourceXMLFile = args[0];
		}

		if ((args.length >= 3) && (args[1] != null) && (!args[1].equals(""))) {
			sourceXSLFile = args[1];
		}

		if ((args.length >= 3) && (args[2] != null) && (!args[2].equals(""))) {
			outputXMLFile = args[2];
		}

		String outputXMLFile_tmp = "Tmp.gml";

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

		while ((line = bReader.readLine()) != null) {
			if ((!found) && (line.trim().startsWith("<CityModel"))) {
				found = true;
				line = "<CityModel gml:id=\"cm1\" "
						+ "xmlns:app=\"http://www.opengis.net/citygml/appearance/3.0\" "
						+ "xmlns:brid=\"http://www.opengis.net/citygml/bridge/3.0\" "
						+ "xmlns:bldg=\"http://www.opengis.net/citygml/building/3.0\" "
						+ "xmlns:frn=\"http://www.opengis.net/citygml/cityfurniture/3.0\" "
						+ "xmlns:grp=\"http://www.opengis.net/citygml/cityobjectgroup/3.0\" "
						+ "xmlns:con=\"http://www.opengis.net/citygml/construction/3.0\" "
						+ "xmlns:core=\"http://www.opengis.net/citygml/3.0\" "
						+ "xmlns:dyn=\"http://www.opengis.net/citygml/dynamizer/3.0\" "
						+ "xmlns:gen=\"http://www.opengis.net/citygml/generics/3.0\" "
						+ "xmlns:luse=\"http://www.opengis.net/citygml/landuse/3.0\" "
						+ "xmlns:dem=\"http://www.opengis.net/citygml/relief/3.0\" "
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
						+ "http://www.opengis.net/citygml/3.0 ./cityGMLBase.xsd "
						+ "http://www.opengis.net/citygml/appearance/3.0 ./appearance.xsd "
						+ "http://www.opengis.net/citygml/bridge/3.0 ./bridge.xsd "
						+ "http://www.opengis.net/citygml/building/3.0 ../xsds/building.xsd "
						+ "http://www.opengis.net/citygml/cityfurniture/3.0 ./cityFurniture.xsd "
						+ "http://www.opengis.net/citygml/cityobjectgroup/3.0 ./cityObjectGroup.xsd "
						+ "http://www.opengis.net/citygml/construction/3.0 ./construction.xsd "
						+ "http://www.opengis.net/citygml/dynamizer/3.0 ./dynamizer.xsd "
						+ "http://www.opengis.net/citygml/generics/3.0 ./generics.xsd "
						+ "http://www.opengis.net/citygml/landuse/3.0 ./landUse.xsd "
						+ "http://www.opengis.net/citygml/relief/3.0 ./relief.xsd "
						+ "http://www.opengis.net/citygml/transportation/3.0 ./transportation.xsd "
						+ "http://www.opengis.net/citygml/tunnel/3.0 ./tunnel.xsd "
						+ "http://www.opengis.net/citygml/vegetation/3.0 ./vegetation.xsd "
						+ "http://www.opengis.net/citygml/versioning/3.0 ./versioning.xsd "
						+ "http://www.opengis.net/citygml/waterbody/3.0 ./waterBody.xsd "
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
	}
}