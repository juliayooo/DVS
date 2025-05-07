class ImCount {
  int year;
  String destinationCountry;
  String originCountry;
  String count;

  ImCount(int year, String dest, String origin, String count) {
    this.year = year;
    this.destinationCountry = dest;
    this.originCountry = origin;
    this.count = count;
  }
}

ArrayList<ImCount> migrations = new ArrayList<ImCount>();

void setup() {
  Table table = loadTable("data_edited1.csv", "header");
  // test with first recorded year
  String yearStr = "1990";  

  loadYearData(table, yearStr); 

  println("Loaded " + migrations.size() + " data rows.");

if (migrations.size() > 0) {
  ImCount m0 = migrations.get(0);
  println("First migration:");
  println("  Year: " + m0.year);
  println("  Destination: " + m0.destinationCountry);
  println("  Origin: " + m0.originCountry);
    println("  count: " + m0.count);
    
    ImCount m7 = migrations.get(700);
  println("First migration:");
  println("  Year: " + m7.year);
  println("  Destination: " + m7.destinationCountry);
  println("  Origin: " + m7.originCountry);
    println("  count: " + m7.count);


}
}

// This function extracts data for a specific year column

void loadYearData(Table table, String yearStr) {
  for (TableRow row : table.rows()) {

    String dest = row.getString("Region, development group, country or area of destination");
    String origin = row.getString("Region, development group, country or area of origin");
    
    // skip empty rows
    if (row.getString(yearStr).equals("")) continue;

    String count = row.getString("1990");
    
    //removeable eventually 
    int year = int(yearStr); 

    ImCount mf = new ImCount(year, dest, origin, count);
    migrations.add(mf);
  }
}
