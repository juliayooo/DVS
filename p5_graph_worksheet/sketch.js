
let data;

function setup() {
  createCanvas(800, 800);
  

  // # of flights leaving NYC airports
  // for the first seven days of 2013
  data = [842, 943, 914, 915, 720, 832, 933];

}

function draw() {
  background(220);

  stroke(1);
  strokeWeight(3);
  noFill();
  textFont('Courier New');
  // draw axes

  beginShape();

  vertex(100, 100);
  vertex(100, 700);
  endShape();


  beginShape();

  vertex(100, 700);
  vertex(700, 700);

  endShape();

  

  // add labels  (X AXIS)
  for(let i = 1; i < 8; i++) {
    textSize(15);
    text("day" + i, i*100, 750);

    beginShape();
    vertex(i*100, 700);
    vertex(i*100, 725);
    endShape();

  }


  beginShape();

  endShape();


  // add labels  (Y AXIS)
  for(let i = 0; i < 5; i++) {
    textSize(15);
    text(250*i, 50, 700-i*150);
    beginShape();
    
    vertex(75, 700-i*150);
    vertex(100, 700-i*150);
  
    // vertex(i*100, 700);
    // vertex(i*100, 725);
    endShape();
  }





  // draw data
  beginShape();

  let num = 100;
  data.forEach(point => {
    fill(0,0,0);
    circle(num, 600 - point/2, 10);
   
    noFill();
    vertex(num, 600 - point/2 );
    num+= 100;
  });

  endShape();
}

