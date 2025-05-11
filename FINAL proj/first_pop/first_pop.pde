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

// global variables 
Slider yearSlider;
DropdownList originDropdown;
DropdownList destDropdown;
int selectedYear = 2000;
ArrayList<ImCount> migrations = new ArrayList<ImCount>();
ArrayList<String> regions = new ArrayList<String>();
ArrayList<String> origins = new ArrayList<String>();

void setup() {
  Table table = loadTable("data_edited1.csv", "header");
  
  // test with first recorded year
  // then repeat every year until 2020 
  for(int i = 1990; i < 2025; i+=5){
    String yearStr = Integer.toString(i);  
  loadYearData(table, yearStr); 

    
  }
  
  size(1000, 1000);
  cp5 = new ControlP5(this);
 
  // initialize dropdowns with lists 
  destDropdown = cp5.addDropdownList("region_select").setPosition(100, 100);
  originDropdown = cp5.addDropdownList("origin_select").setPosition(500, 100);
  originDropdown.setHeight(200);
  destDropdown.setItemHeight(20);
  destDropdown.setBarHeight(20);
  destDropdown.setHeight(200);
    destDropdown.setWidth(300);


  
  // initialize year slider 
  yearSlider = cp5.addSlider("Year")
  .setPosition(100, 500)
  .setSize(200, 20)
  .setRange(1990, 2020)
  .setNumberOfTickMarks(7)  // 1990, 1995, ..., 2020
  .setValue(selectedYear)
  .setSliderMode(Slider.FLEXIBLE);


  for(int i = 0; i < 8; i++){
      destDropdown.addItem(regions.get(i), regions.get(i));
  }
  for(int i = 0; i < origins.size(); i++){
      originDropdown.addItem(origins.get(i), origins.get(i));
  }

}
void draw() {
  background(255);
}
// This function extracts data for a specific year column

void loadYearData(Table table, String yearStr) {
  for (TableRow row : table.rows()) {

    String dest = row.getString("Region, development group, country or area of destination");
    String origin = row.getString("Region, development group, country or area of origin");
    
    // skip empty rows
    if (row.getString(yearStr).equals("")) continue;


    int count = int(row.getString(yearStr).replace(" ", ""));
 
    //removeable eventually 
    int year = int(yearStr); 
    

    ImCount mf = new ImCount(year, dest, origin, count);
    migrations.add(mf);
    
    if(!regions.contains(dest)){
      regions.add(dest);
    }
    if(!origins.contains(origin)){
      origins.add(origin);
    }
  }
}

void printYearData(int year){
  for(int i=0; i < migrations.size(); i++){
    
    //UNFINISHED
    if(migrations.get(i).year == year){
      println(migrations.get(i).count);
      println(migrations.get(i).originCountry);
      println(migrations.get(i).destinationCountry);

    }
  
  
  }
  
  
}
