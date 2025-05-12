import controlP5.*;

// global structures  
ControlP5 cp5;
ParticleSystem ps;
PImage sprite;
Slider yearSlider;
ArrayList<ImCount> migrations = new ArrayList<ImCount>();
ArrayList<String> regions = new ArrayList<String>();
ArrayList<String> origins = new ArrayList<String>();
DropdownList originDropdown;
DropdownList destDropdown;

// Global variables 
String currOrg = "origin_select";
String currDest = "region_select";
int selectedYear = 1990;



// define class for imcount structure 
class ImCount {
  int year;
  String destinationCountry;
  String originCountry;
  int count;
  
// constructor for imcount 
  ImCount(int year, String dest, String origin, int count) {
    this.year = year;
    this.destinationCountry = dest;
    this.originCountry = origin;
    this.count = count;
  }
}


void setup() {
  
  // setup canvas 
  size(1024, 768, P2D);
  cp5 = new ControlP5(this);
  
  Table table = loadTable("data_edited1.csv", "header");
  
 
  // then repeat every year until 2020 
  for(int i = 1990; i < 2025; i+=5){
    String yearStr = Integer.toString(i);  
  loadYearData(table, yearStr); 

  // code referenced from daniel shiffman's particle system
  orientation(LANDSCAPE);
  
  // customizable image here 
  sprite = loadImage("sprite.png");
   //BROKEN !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

  ps = new ParticleSystem(100);
  println("created systmem with count 100");



  hint(DISABLE_DEPTH_MASK);

    
    
  }

 
  // initialize dropdowns with lists 
  destDropdown = cp5.addDropdownList("region_select").setPosition(100, 100);
  originDropdown = cp5.addDropdownList("origin_select").setPosition(500, 100);

   

  destDropdown.setItemHeight(20);
  destDropdown.setBarHeight(20);
  destDropdown.setHeight(200);
  destDropdown.setWidth(300);

  originDropdown.setItemHeight(20);
  originDropdown.setBarHeight(20);
  originDropdown.setHeight(200);
  originDropdown.setWidth(300);


  
  // initialize year slider 
  yearSlider = cp5.addSlider("Year")
  .setPosition(100, 500)
  .setSize(200, 20)
  .setRange(1990, 2020)
  .setNumberOfTickMarks(7)  // 1990, 1995, ..., 2020
  .setValue(selectedYear)
  .setSliderMode(Slider.FLEXIBLE);

//populate dropdowns
  for(int i = 0; i < 8; i++){
      destDropdown.addItem(regions.get(i), regions.get(i));
  }
  for(int i = 0; i < origins.size(); i++){
      originDropdown.addItem(origins.get(i), origins.get(i));
  }

}
void draw() {  

  if (!destDropdown.getCaptionLabel().getText().equals(currDest) || !originDropdown.getCaptionLabel().getText().equals(currOrg) || int(yearSlider.getValue()) != selectedYear){
    ps = new ParticleSystem(set_ps(int(yearSlider.getValue()), destDropdown.getCaptionLabel().getText(), originDropdown.getCaptionLabel().getText()));
  }
  background(0);
  
  ps.setEmitter(mouseX,mouseY);
  
  // set_ps(selectedYear, "Sub-Saharan Africa", "Canada");
  // set_ps(selectedYear, destDropdown.getCaptionLabel().getText(), originDropdown.getCaptionLabel().getText());
  ps.update();
  ps.display();

  fill(255);
  textSize(16);
  text("Frame rate: " + int(frameRate), 10, 20);
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

int set_ps(int year, String dest, String org){

  selectedYear = year;
  currOrg = org;
  currDest = dest;
  float n = 0;

  for(int i=0; i < migrations.size(); i++){

  
    //Get specific migration data
    if(migrations.get(i).year == year && migrations.get(i).destinationCountry.equals(dest) && migrations.get(i).originCountry.equals(org)){

      // println("found it: ");
      // println(migrations.get(i).count);
      // println(migrations.get(i).originCountry);
      // println(migrations.get(i).destinationCountry);
     println("found it: ");

     println(migrations.get(i).count);
      println(migrations.get(i).originCountry);
      println(migrations.get(i).destinationCountry);

      n = (migrations.get(i).count) / 10000;
      if(n < 100){
        n = 100;
      }
      text("count: " + Float.toString(n), 10, 40);

      break;
      }
  }
println("done");
  // set the number of particles based on the count

  // SORT OF BROKEN !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
// ps = new ParticleSystem(int(n));
  // ps.addParticles(int(n));
  // ps.setEmitter(mouseX, mouseY);
  // ps.update();
  // ps.display();
 
 return int(n);

}

