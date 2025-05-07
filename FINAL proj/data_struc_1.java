
// Class definiton for data 
class im_count {
  int year;
  String destinationCountry;
  String originCountry;
  int count;

    // class method 
  img_flow(int year, String dest, String origin, int count) {
    this.year = year;
    this.destinationCountry = dest;
    this.originCountry = origin;
    this.count = count;
  }
}

ArrayList<img_flow> migrations = new ArrayList<img_flow>();

void setup() {

    // add it. function to iterate 9 times, by year, ++5 to year arg. 


  Table table = loadTable("data_edited.csv", "header");

    Table static pop_table(String[] year){

        for (TableRow row : table.rows()) {
    int year = row.getInt(year);
    String dest = row.getString("Region, development group, country or area of destination");
    String origin = row.getString("Region, development group, country or area of origin");
    int count = row.getInt(year);

    img_flow mf = new im_count(year, dest, origin, count);
    migrations.add(mf);
     }
    }
    
  pop_table("1990");

  println("Loaded " + migrations.size() + " migration records.");
}

setup();