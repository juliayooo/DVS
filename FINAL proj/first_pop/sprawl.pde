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
  PFont nabla;
  nabla = createFont("nabla.ttf", 40);
  textFont(nabla);
  fill(255, 255, 230);
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
  destDropdown = cp5.addDropdownList("Select a Destination").setPosition(500, 50);
  originDropdown = cp5.addDropdownList("Select an Origin").setPosition(50,50);

   

  destDropdown.setItemHeight(20);
  destDropdown.setBarHeight(20);
  destDropdown.setHeight(300);
  destDropdown.setWidth(400);
  destDropdown.setColorBackground(color(0, 57, 77));  // dropdown background
  destDropdown.setColorActive(color(179, 236, 255));   // highlighted item
  destDropdown.setColorForeground(color(0,0,0));  // hover color
  //destDropdown.setFont(nabla);
  
  originDropdown.setItemHeight(20);
  originDropdown.setBarHeight(20);
  originDropdown.setHeight(300);
  originDropdown.setWidth(400);
  originDropdown.setBackgroundColor(255);
  originDropdown.setColorBackground(color(0, 57, 77));  // dropdown background
  originDropdown.setColorActive(color(179, 236, 255));   // highlighted item
  originDropdown.setColorForeground(color(0,0,0));  // hover color



  
  // initialize year slider 
  yearSlider = cp5.addSlider("Year")
  .setPosition(950, 50)
  .setSize(400, 40)
  .setRange(1990, 2020)
  .setNumberOfTickMarks(7)  // 1990, 1995, ..., 2020
  .setValue(selectedYear)
  .setColorBackground(color(0, 57, 77))
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

    ps = new ParticleSystem(set_ps(int(yearSlider.getValue()), destDropdown.getCaptionLabel().getText(), originDropdown.getCaptionLabel().getText()));
  }
  background(0, 77, 102);
  if(emit){
      ps.setEmitter(mouseX,mouseY);

  }
 
  
  
  ps.update();
  ps.display();
  // ZOOM HANDLED
  popMatrix();
  // GUI RULES
  fill(255);
  textSize(27);
  String count;
  int x = (set_ps(int(yearSlider.getValue()), destDropdown.getCaptionLabel().getText(), originDropdown.getCaptionLabel().getText()) * 10000);
  if(x == 10000){
    count = "no data, or <10,000.";
  }
  else{
    count = Integer.toString(x);
  }
  
  if(destDropdown.getCaptionLabel().getText() != "region_select" && originDropdown.getCaptionLabel().getText() != "origin_select"){
  text("Each particle represents 10000 people. Click to expand or collapse, and scroll to zoom. \n Migrant count: ~" + count + " people from " + originDropdown.getCaptionLabel().getText() 
  + " living in " + destDropdown.getCaptionLabel().getText() + "\n between " + int (yearSlider.getValue()) 
  + " and " + (int (yearSlider.getValue())+4) , 10, 850);
  }
  else{
    text("Select an origin and destination", 10, 850);
  }
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
