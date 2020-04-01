import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import kx.c;
import kx.c.KException;

public class feedhandler {

    public static void main(String[] args) {

        String csvFile = "trade.csv";
	c c=null;
        BufferedReader br = null;
        String line = "";
        String cvsSplitBy = ",";

        try {

            br = new BufferedReader(new FileReader(csvFile));
	    c = new c("localhost",5001);
            while ((line = br.readLine()) != null) {

                // use comma as separator
                String[] row = line.split(cvsSplitBy);

                System.out.println("Record [" + row[0] + ";" + row[1] + ";" + row[2] + ";" + row[3] + "]");

		c.ks(".u.upd[`trade;(" + row[0] + ";`" + row[1] + ";" + row[2] + ";" + row[3] + ")]");

            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
                try {
                    br.close();c.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
        }

    }

}

