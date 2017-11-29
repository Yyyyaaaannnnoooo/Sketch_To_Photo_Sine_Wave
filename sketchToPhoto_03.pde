PImage img;
PShape shape;
int pix = 2, w, h, amp = 50, yoffset = 8, xoffset = yoffset / 2;
float phase = 0.3, inc = PI/30, frq = 0.00001;
float[] wave;
void settings() {
  img = loadImage("whale.jpg");
  w = img.width;
  h = img.height;
  wave = new float[img.width];
  size(w, h);
}
void setup() {
  //ellipseMode(CORNER);
  rectMode(CENTER);
  shape = loadShape("test.svg");
}
void draw() {
  background(255);
  //image(img, 0, 0);
  //noStroke();
  amp = floor(map(mouseY, 0, height, 0, 2000));
  phase = map(mouseX, 0, width, 0, 20);
  //noFill();
  noStroke();
  //fill(0, 255, 0);
  img.loadPixels();
  for (int y = -amp; y < img.height + amp; y += yoffset) {    
  beginShape(POINTS);
    for (int x = 0; x < img.width; x += xoffset) {
      int i = x + img.width * constrain(y, 0, img.height -1);
      float angle = map(x, 0, img.width, 0, (PI * phase));
      //float sinY = y + sin(angle) + sin(pow(angle, 3)) * amp;
      float sinY = y + sin(pow(angle, 1)) * amp;
      //float b = brightness(img.pixels[i]);
      color c = img.get(x, round(sinY));
      float b = brightness(c);
      float sze = map(b, 0, 255, yoffset, 1);
      strokeWeight(sze);
      fill(c);
      //vertex(x, sinY);
      rect(x, sinY, sze, sze);
    }    
  endShape();
  }
  //for (int y = 0; y < img.height; y++) {
  //  for (int x = 0; x < img.width; x++) {
  //    int i = x + img.width * y;
  //    float b = brightness(img.pixels[i]);
  //    fill(0);
  //    float sze = map(b, 0, 255, pix, pix * 0.2);
  //    //ellipse(x * pix, y * pix, sze, sze);
  //    shape(shape, x * pix, y * pix, sze, sze);
  //  }
  //}
  img.updatePixels();
}
void keyPressed() {
  saveFrame("output.png");
}

float Y(float mil, float x, float f) {
  float value = 0.00001;//map(mouseX, 0, width, 0.00001, 0.000001);
  //println(value);
  //float t = value * (millis() * 130.0 * -1);
  float t = value * (mil * 130.0 * -1);
  float y = sin(x * f);
  y += sin(x * f * 2.1 + t) * 4.5;
  y += sin(x * f * 1.72 + t * 1.121) * 4.0;
  y += sin(x * f * 2.221 + t * 0.437) * 5.0;
  y += sin(x * f * 3.1122 + t * 4.269) * 2.5;
  y *= 1.0 * 0.06;
  return y;
}