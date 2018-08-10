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
		String sourceXMLFile = "CityGML_v2.gml";
		String sourceXSLFile = "Transform.xsl";
		String outputXMLFile = "CityGML_v3_Transformed.gml";

		if ((args.length >= 5) && (args[2] != null) && (!args[1].equals(""))) {
			sourceXMLFile = args[2];
		}

		if ((args.length >= 5) && (args[3] != null) && (!args[2].equals(""))) {
			sourceXSLFile = args[3];
		}

		if ((args.length >= 5) && (args[4] != null) && (!args[3].equals(""))) {
			outputXMLFile = args[4];
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
				line = "<CityModel gml:id=\"cm1\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xAL=\"urn:oasis:names:tc:ciq:xsdschema:xAL:2.0\" xmlns:bldg=\"http://www.opengis.net/citygml/building/3.0\" xmlns:gml=\"http://www.opengis.net/gml/3.2\" xmlns:gen=\"http://www.opengis.net/citygml/generics/3.0\" xmlns:con=\"http://www.opengis.net/citygml/construction/3.0\" xmlns=\"http://www.opengis.net/citygml/3.0\" xsi:schemaLocation=\"http://www.opengis.net/citygml/3.0 ../xsds/cityGMLBase.xsd http://www.opengis.net/citygml/building/3.0 ../xsds/building.xsd http://www.opengis.net/citygml/construction/3.0 ../xsds/construction.xsd http://www.opengis.net/citygml/generics/3.0 ../xsds/generics.xsd\">";
			}

			bWriter.write(line);
			bWriter.newLine();
		}

		bReader.close();
		bWriter.close();
		Files.delete(outputXMLTmp.toPath());
	}
}