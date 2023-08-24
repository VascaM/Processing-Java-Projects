// This code creates a simple game where bubbles appear randomly on the screen,
// and the player can control a catcher platform to catch the bubbles.
// The goal is to catch more than 10 bubbles without missing more than 10.
// Otherwise, the game ends with a "Won" or "Lost" message based on the result.

color backgroundColor = color(255, 255, 230);
ArrayList<BubbleObject> bubbleArray = new ArrayList<BubbleObject>(); // Create an ArrayList to keep track of the bubbles.
Catcher catcher; // Declare a variable to hold the catcher object.

float catcherHeight = 30;
float catcherWidth = 100;
int missed = 0;
int score = 0;
boolean play = true;

void setup() {
  size(600, 600);
  noStroke();

  // Add 5 initial bubbles to the bubbleArray.
  for (int i = 0; i < 5; i++) {
    bubbleArray.add(new BubbleObject(random(width), (random(height) + 99), 50, random(1, 5), color(random(0), random(0), random(255))));
  }
  catcher = new Catcher(100, 0, catcherHeight, catcherWidth);
}

void draw() {
  background(backgroundColor);

  if (play) {
    for (int i = bubbleArray.size() - 1; i >= 0; i--) {
      BubbleObject bubble = bubbleArray.get(i);
      if (!bubble.isCounted()) {
        bubble.display();
        bubble.update(mouseX, catcherHeight, catcherWidth);
      } else {
        bubbleArray.remove(i);  // Remove the bubble from the list if it's already counted.
      }
    }

    // Add a new bubble if there are fewer than 5 bubbles.
    if (bubbleArray.size() < 5) {
      bubbleArray.add(new BubbleObject(random(width), height + 50, 50, random(1, 5), color(random(0), random(0), random(255))));
    }

    catcher.display();
    catcher.update(mouseX);
  }

  // Check if the game is over and display a message.
  if (score >= 10 || missed >= 10) {
    play = false;
    textSize(50);
    if (score >= 10) {
      fill(0, 255, 0);
      text("Won ", 200, height / 2);
    } else {
      fill(255, 0, 0);
      text("Lost ", 200, height / 2);
    }
  }

  // Display the score and the number of missed bubbles.
  textSize(40);
  fill(0, 0, 0);
  text("Score: " + score, 50, height - 100);
  text("Missed: " + missed, 50, height - 50);
}

// Restart the game when the mouse is clicked.
void mouseClicked() {
  score = 0;
  missed = 0;
  play = true;
  // Reset the "counted" status of all bubbles.
  for (BubbleObject bubble : bubbleArray) {
    bubble.resetCounted();
  }
}

class BubbleObject {
  float xPos;
  float yPos;
  float diameter;
  float speed;
  color color1;
  boolean counted = false;

  // Constructor. A special function within a class that creates a new object with initial properties.
  BubbleObject(float tempXPos, float tempYPos, float tempDiameter, float tempSpeed, color tempColor) {
    xPos = tempXPos;
    yPos = tempYPos;
    diameter = tempDiameter;
    speed = tempSpeed;
    color1 = tempColor;
  }

  // Function (or method) that displays the visual appearance.
  // "void" indicates that the method doesn't return a value but performs an action.
  void display() {
    fill(color1);
    ellipse(xPos, yPos, diameter, diameter);
  }
  
  // Update the bubble's position and check for collisions.
  void update(float mousePos, float catHeight, float catWidth) {
    yPos -= speed;

    if (yPos < 0) {
      if (!counted) {
        missed++;
        counted = true;
      }
      yPos = height + 50;
      xPos = random(width);
    }
    if (yPos > height + 100) {
      speed = -speed;
      xPos = random(width);
    }

    if (yPos < catHeight + diameter / 2 && ((xPos > mousePos - diameter / 2) && (xPos < mousePos + catWidth + diameter / 2))) {
      if (!counted) {
        counted = true;
        score++;
        println("score: " + score);
      }
    }
  }

  boolean isCounted() {   // Check if the bubble is already counted.
    return counted;
  }

  void resetCounted() {   // Reset the "counted" status of the bubble.
    counted = false;
  }
}

class Catcher {
  float x;
  float y;
  float cWidth;
  float cHeight;

  Catcher(float tempX, float tempY, float tempW, float tempH) {
    x = tempX;
    y = tempY;
    cWidth = tempW;
    cHeight = tempH;
  }

  void display() {
    fill(255, 0, 0);
    rect(x, y, cHeight, cWidth);
  }

  void update(float mousePos) {
    x = mousePos;
  }
}
