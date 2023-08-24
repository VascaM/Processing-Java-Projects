// This code creates an interactive drawing of a cat where the eyes follow the mouse movement.
// Clicking on the nose or pressing the spacebar triggers changes in the drawing.

int value = 255, c; 
color yellow = color(#4A4568);
Eye e1, e2; 

void setup() {
  size(700, 700);
  noStroke(); 
  e1 = new Eye(250, 350, 120); // Create an Eye object (position & size)
  e2 = new Eye(450, 350, 120);
  colorMode(HSB); 
}

void draw() {
  background(#4A4568); 

  if (mousePressed) { // Check if the mouse button is pressed
    if (mouseX > 325 && mouseX < 375 && mouseY > 400 && mouseY < 425) { // Check if mouse is within a certain area
      c = (c >= 255) ? 0 : c + 1; 
      background(c, 255, 255); 
    } else {
      value = yellow;
    }
  }

  // Draw cat shapes
  fill(20);
  ellipse(350, 350, 450, 300); // Face
  fill(20);
  triangle(570, 335, 625, 175, 300, 300); // Left ear
  fill(20);
  triangle(130, 335, 75, 175, 400, 300); // Right ear
  fill(20);
  ellipse(350, 750, 400, 600); // Body
  fill(#DB7093);
  triangle(325, 400, 350, 425, 375, 400); // Nose
  textSize(20);
  fill(255);
  text("Click on the nose or press the spacebar.", 185, 680);

  // Change mouth size when nose is clicked
  if (mousePressed) {
    if (mouseX > 325 && mouseX < 375 && mouseY > 400 && mouseY < 425) {
      fill(#A41515);
      rect(325, 435, 50, 25, 10); // Mouth
      fill(255);
      triangle(332, 435, 337, 440, 342, 435); // Left tooth
      fill(255);
      triangle(358, 435, 363, 440, 368, 435); // Right tooth
    } else {
      fill(20);
    }
  }

  // Change mouth when spacebar is pressed
  if (keyPressed && key == ' ') {
    fill(#A41515);
    rect(325, 435, 25, 25, 100); // Mouth
    fill(255);
    triangle(332, 435, 337, 440, 342, 435); // Left tooth
  } else {
    fill(20);
  }

  // Update and display eyes
  e1.update(mouseX, mouseY);
  e2.update(mouseX, mouseY);

  e1.display();
  e2.display();
}

class Eye {
  // Variables belonging to the "Eye" class
  int x, y, size;
  float angle = 0.0;

  // Constructor. A special function within a class that creates a new object with initial properties.
  Eye(int tempX, int tempY, int tempSize) {
    x = tempX;
    y = tempY;
    size = tempSize;
  }

  void display() {
    pushMatrix(); // Save the current transformation matrix (eye position).
    translate(x, y); // Move the origin to the center of the eye
    fill(#DAEE5A);
    ellipse(0, 0, size, size);
    rotate(angle); // Rotate the coordinate system for the pupil.

    // Check if the spacebar is pressed to change color.
    if (keyPressed && key == ' ') {
      c = (c >= 255) ? 0 : c + 1;
      fill(c, 255, 255);
    } else {
      fill(0);
    }

    ellipse(size / 4, 0, size / 2, size / 2);
    popMatrix(); // Restore the original transformation matrix.
  }

  // Calculate the rotation angle of the pupil. Pupils rotate and do not go beyond the eye.
  void update(int mx, int my) {
    angle = atan2(my - y, mx - x);
  }
}
