PImage black, white;

// Circle pos, color
int cx = 100;
int cxL = 65;
int cxR = 530;
int cy = 440;
int cr = 15;

// Main rect pos and scale
int rectXX = 30;
int rectXY = 370;
int rectW = 550;
float rectH = -300;

// Rect colors
int rectCH = 200;
int rectCS = 50;
int rectCV = 100;

// Bottle rects
int rows = 2;
int cols = 7;
int totalRects = rows * cols;

float[] rectX = new float[totalRects];
float[] rectY = new float[totalRects];
float[] rectHArray = new float[totalRects];
int rectMaxH = -130;
int rectWA = 50;

int spacingX = 20;
int spacingY = 158;
int startX = 60;
int startY = 633;

int index = 0;
boolean isDragging = false;

// Ranges for each rectangle's growth
float[] rectStartCX = new float[totalRects];
float[] rectEndCX = new float[totalRects];

void setup() {
  colorMode(HSB, 360, 100, 100);
  background(0, 0, 100);
  size(595, 840, P3D);

  black = loadImage("business plan black.png");
  white = loadImage("business plan white.png");

  // positions and dimensions of the small rectangles
  for (int row = 0; row < rows; row++) {
    for (int col = 0; col < cols; col++) {
      rectX[index] = startX + col * (rectWA + spacingX);
      rectY[index] = startY + row * spacingY;
      rectHArray[index] = 0; // Default height

      // Set individual growth ranges for each rectangle
      float step = (cxR - cxL) / totalRects;
      rectStartCX[index] = cxL + step * index;
      rectEndCX[index] = rectStartCX[index] + step;

      index++;
    }
  }
}

void draw() {
  background(0, 0, 100);

  noStroke();
  fill(rectCH, rectCS, rectCV);
  rect(rectXX, rectXY, rectW, rectH);



  // Draw the smaller rectangles
  for (int i = 0; i < totalRects; i++) {
    rect(rectX[i], rectY[i], rectWA, rectHArray[i]);
  }
   image(white, 0, 0);
  image(black, 0, 0);

  fill(0);
  circle(cx, cy, cr);
}

// Check if the mouse is inside the circle
void mousePressed() {
  if (dist(mouseX, mouseY, cx, cy) < cr) {
    isDragging = true;
  }
}

// Update the circle's X position and adjust rectangle heights
void mouseDragged() {
  if (isDragging) {
    cx = constrain(mouseX, cxL, cxR);
    rectH = -320 + cx * 0.6;

    // Update heights of rectangles progressively
    for (int i = 0; i < totalRects; i++) {
      if (cx >= rectStartCX[i] && cx <= rectEndCX[i]) {
        // Map cx within the rectangle's individual range
        rectHArray[i] = map(cx, rectStartCX[i], rectEndCX[i], 0, rectMaxH);
      } else if (cx > rectEndCX[i]) {
        // If cx has passed the end of this rectangle's range, set to max height
        rectHArray[i] = rectMaxH;
      } else if (cx < rectStartCX[i]) {
        // If cx is before this rectangle's range, reset height to 0
        rectHArray[i] = 0;
      }
    }
  }
}

void mouseReleased() {
  isDragging = false;
}
