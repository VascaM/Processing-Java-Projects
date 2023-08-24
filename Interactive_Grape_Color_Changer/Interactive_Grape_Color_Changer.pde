// This code allows you to interactively change the color of the grapes by pressing 
// the spacebar or by placing the mouse on different sides of the drawing area.

int value = 255;
color white = color(255);
color red = color(255, 0, 0);
color blue = color(0, 0, 255);

void setup() {
  size(400, 500);
  strokeWeight(5);
  background(255);
}

void draw() {

  fill(value);

  // Draw 12 grapes in the background
  for (int y = 100; y <= 450; y += 100) {
    for (int x = 100; x <= 350; x += 100) {
      ellipse(x, y, 100, 100);
    }
  }

  // Draw 6 grapes in the foreground
  for (int y = 150; y <= 400; y += 100) {
    for (int x = 150; x <= 300; x += 100) {
      ellipse(x, y, 100, 100);
    }
  }

  // Draw the stem of the grape bunch
  fill(#00FF00); // Green color
  rect(190, 0, 20, 50);

  // Check for keyboard and mouse input to change the color
  if (keyPressed && key == ' ') {
    value = red;
  } else if (mouseX < width / 2) {
    value = blue;
  } else {
    value = white;
  }
}
