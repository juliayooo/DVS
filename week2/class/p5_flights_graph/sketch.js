// we instantiate global variables (that we'd like to use
// in lower scope, eg, `setup` or `draw`, at the top-level)

let data;
let margin = 50;
let chartWidth, chartHeight;
let yTick = 100;
let scaleX, scaleY, scaleTemp;

let table;

function dateForRowItem(index) {
  const year = table.rows[index].getNum("year");
  const month = table.rows[index].getNum("month");
  const day = table.rows[index].getNum("day");

  // remember, JS dates index from 0
  return new Date(year, month - 1, day);
}

function preload() {
  table = loadTable("ypd.csv", "csv", "header");
}

function setup() {
  createCanvas(800, 800);

  chartWidth = width - 2 * margin;
  chartHeight = height - 2 * margin;

  // # of flights leaving NYC airports
  // for the first seven days of 2013
  // data = [842, 943, 914, 915, 720, 832, 933];
  // for all of 2013
  data = table.rows.map((r) => r.getNum("count"));

  scaleX = (n) => map(n, 0, data.length - 1, 0, chartWidth);
  scaleY = (n) => map(n, 0, ceil(max(data) / yTick) * yTick, chartHeight, 0);
}

function draw() {
  background(220);

  // reset text sizing
  textSize(12);
  textAlign(LEFT);

  // draw a backdrop for your graph
  push();
  translate(margin, margin);
  noStroke();
  fill(255);
  rect(0, 0, chartWidth, chartHeight);

  // plot line (and points if you'd like)
  beginShape();
  data.forEach((d, i) => {
    const x = scaleX(i);
    const y = scaleY(d);
    vertex(x, y);
    noStroke();

    fill(255, 0, 0);

    circle(x, y, 10);
  });
  noFill();
  stroke(255, 0, 0);
  endShape();

  // draw axes (and tick marks?)
  stroke(0);
  // x axis
  line(0, 0, 0, chartHeight);
  // y axis
  line(0, chartHeight, chartWidth, chartHeight);

  // the next six lines handle automatically
  // scaling tick spacing on the X axis
  const xTickWidth = scaleX(1);
  // I want my ticks to be about 50px apart
  const minXTickWidth = 50;
  const every = ceil(minXTickWidth / xTickWidth);

  // x ticks
  data.forEach((d, i) => {
    if (i % every == 0) {
      const x = scaleX(i);
      const y = chartHeight;
      textAlign(CENTER);
      line(x, y, x, y + 10);

      const date = dateForRowItem(i);

      // "Jan", "Feb", "Mar"
      // easiest way to get this without a library IMO
      const monthString = date.toLocaleDateString("en-gb", {
        month: "short",
      });

      const dateString = `${monthString} ${date.getDate()}`;

      push();
      translate(x, y);
      rotate(radians(270));
      text(dateString, -30, 5);
      pop();
    }
  });

  // y ticks
  const tickCount = ceil(max(data) / yTick);
  for (let i = 0; i <= tickCount; i++) {
    const x = 0;
    const y = scaleY(i * yTick);
    textAlign(RIGHT);
    line(x, y, x - 10, y);
    text(i * yTick, x - 13, y + 4);
  }

  // label your axes
  push();
  translate(0, height / 2);
  rotate(radians(270));
  text("Flights per day", 0, -38);
  pop();

  // title your graph!
  pop();
  textSize(16);
  textAlign(CENTER);
  text("Flights out of NYC Airports, 2013", width / 2, 30);
}
