import controlP5.*;

// global structures  
ControlP5 cp5;
ParticleSystem ps;
boolean emit = true;
PImage sprite;
Slider yearSlider;
ArrayList<ImCount> migrations = new ArrayList<ImCount>();
ArrayList<String> regions = new ArrayList<String>();
ArrayList<String> origins = new ArrayList<String>();
DropdownList originDropdown;
DropdownList destDropdown;
float zoomFactor = 1.0; // Initial zoom level


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
  //size(1500, 850, P2D);
  fullScreen(P2D);
  smooth();
  cp5 = new ControlP5(this);
  
  Table table = loadTable("data_edited1.csv", "header");
  
 
  // then repeat every year until 2020 
  for(int i = 1990; i < 2025; i+=5){
    String yearStr = Integer.toString(i);  
  loadYearData(table, yearStr); 

    
  }
  
  
  // code referenced from daniel shiffman's particle system
  orientation(LANDSCAPE);
  
  // customizable image here 
  sprite = loadImage("sprite.png");
 
  ps = new ParticleSystem(100);
  println("created systmem with count 100");



  hint(DISABLE_DEPTH_MASK);


 
  // initialize dropdowns with lists 
  destDropdown = cp5.addDropdownList("region_select").setPosition(500, 100);
  originDropdown = cp5.addDropdownList("origin_select").setPosition(100,100);

   

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
  .setPosition(50, 800)
  .setSize(400, 40)
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

  
  // Zoom elements
  pushMatrix();
  translate(width / 2, height / 2);
  scale(zoomFactor);
  translate(-width / 2, -height / 2); 


  if (!destDropdown.getCaptionLabel().getText().equals(currDest) || !originDropdown.getCaptionLabel().getText().equals(currOrg) || int(yearSlider.getValue()) != selectedYear){
    
    //ps.returnP();
    //ps.update();
    //ps.display();
    ps = new ParticleSystem(set_ps(int(yearSlider.getValue()), destDropdown.getCaptionLabel().getText(), originDropdown.getCaptionLabel().getText()));
  }
  background(0);
  if(emit){
      ps.setEmitter(mouseX,mouseY);

  }
 
  
  
  ps.update();
  ps.display();
  // ZOOM HANDLED
  popMatrix();
  // GUI RULES
  fill(255);
  textSize(20);
  text("Frame rate: " + int(frameRate), 10, 20);
  String count;
  int x = (set_ps(int(yearSlider.getValue()), destDropdown.getCaptionLabel().getText(), originDropdown.getCaptionLabel().getText()) * 10000);
  if(x == 10000){
    count = "no data, or <10,000.";
  }
  else{
    count = Integer.toString(x);
  }
  
  
  text("Each particle represents 10000 people. Migrant count: " + count, 10, 40 );
  
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
      if(n < 1){
        n = 1;
      }
      //text("count: " + Float.toString(n), 10, 40);

      break;
      }
  }
println("done");
 
 
 return int(n);

}


void mouseClicked(){
  
  if(emit){
      emit = false;

  }
  else{
    emit= true;
  }

  ps.centerTarget(mouseX, mouseY);
  ps.update();
  
}


void mouseWheel(MouseEvent event) {
// scroll controls zoom 
  
  float delta = event.getCount() > 0 ? 1.05 : 1.0/1.03; // Adjust zoom factor
  zoomFactor *= delta;
}
