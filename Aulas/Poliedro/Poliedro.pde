int radius = 90;
int tall = 120;
int sides = 20;
float angle = 360/(sides);
float halfTall = tall /2;

void setup() {
  size(500, 500, P3D);
}

void draw() {
  background(0);
  if (mousePressed) {
    noFill();
    stroke(255);
  } else {
    lights();
    noStroke();
    fill(255);
  }
  translate(width/2, height/2, TWO_PI);
  rotateY(map(mouseX, 0, width, 0, TWO_PI));
  rotateZ(map(mouseY, 0, height, 0, -TWO_PI));

  beginShape(TRIANGLE_STRIP);
  for (int i = 0; i <=sides; i++) {
    float x = cos(radians(i*angle)) * radius;
    float y = sin(radians(i*angle)) * radius;
    vertex(x, y, halfTall);
    vertex(x, y, -halfTall);
  }
  endShape(CLOSE);

}