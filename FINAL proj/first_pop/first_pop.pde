import controlP5.*;
ControlP5 cp5;
// https://forum.processing.org/one/topic/help-with-drop-down-menu.html
class ImCount {
  int year;
  String destinationCountry;
  String originCountry;
  int count;

  ImCount(int year, String dest, String origin, int count) {
    this.year = year;
    this.destinationCountry = dest;
    this.originCountry = origin;
    this.count = count;
  }
}

ArrayList<ImCount> migrations = new ArrayList<ImCount>();
ArrayList<String> regions = new ArrayList<String>();
void setup() {
  Table table = loadTable("data_edited1.csv", "header");
  
  // test with first recorded year
  // then repeat every year until 2020 
  for(int i = 1990; i < 2025; i+=5){
    String yearStr = Integer.toString(i);  

  loadYearData(table, yearStr); 

  println("Loaded " + migrations.size() + " data rows.");
    
  }
  
  size(500, 500);
  cp5 = new ControlP5(this);
 
  // add a dropdownlist at position (100,100)
  DropdownList droplist = cp5.addDropdownList("region_select").setPosition(10, 10);
  
  for(int i = 0; i < 8; i++){
      droplist.addItem(regions.get(i), regions.get(i));
      println("added " + regions.get(i));
  }
 
 
}

// This function extracts data for a specific year column

void loadYearData(Table table, String yearStr) {
  for (TableRow row : table.rows()) {

    String dest = row.getString("Region, development group, country or area of destination");
    String origin = row.getString("Region, development group, country or area of origin");
    
    // skip empty rows
    if (row.getString(yearStr).equals("")) continue;

    int count = int(row.getString(yearStr));
    
    //removeable eventually 
    int year = int(yearStr); 
    

    ImCount mf = new ImCount(year, dest, origin, count);
    migrations.add(mf);
    
    if(!regions.contains(dest)){
      regions.add(dest);
      //println("added " + dest);
    }
  }
}
