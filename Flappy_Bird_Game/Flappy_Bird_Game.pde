// This code implements a simplified version of the well-known "Flappy Bird" game,
// where a bird has to fly through openings in pillars to score points.

Bird bird = new Bird();
Pillar[] pillars = new Pillar[3]; // Create an array of 3 Pillar objects
boolean isGameStarted, isStartScreen, isJumpPressed;
int score;

void setup() {
  size(600, 800);
  for (int i = 0; i < 3; i++)
    pillars[i] = new Pillar(i); // Create new Pillar objects and add them to the array
  isGameStarted = false;
  isStartScreen = true;
}

void draw() {
  background(100);
  processUserInput();
  if (isGameStarted) {
    bird.move(); // Move the bird
    bird.applyGravity(); // Simulate gravity on the bird
    bird.checkCollisions(); // Check for collisions with pillars
    for (Pillar p : pillars)
      p.checkPosition(); // Check pillar positions
  }
  renderGame();
}

void renderGame() {
  textSize(32);
  if (isGameStarted) {
    bird.drawBird();
    for (Pillar p : pillars)
      p.drawPillar();
    fill(255);
    text("Score: " + score, width / 2, 50);
  } else if (isStartScreen) {
    fill(255);
    textAlign(CENTER, CENTER);
    text("Flappy Bird Game\nPress spacebar to play", width / 2, 240); // Display start screen
  } else {
    fill(255);
    textAlign(CENTER, CENTER);
    text("Game Over\nScore: " + score, width / 2, 240); // Display game over screen
  }
}

void processUserInput() {
  isJumpPressed = isGameStarted; // Record if jump key is pressed if the game has started
  if (keyPressed && key == ' ') {
    if (!isGameStarted)
      reset(); // If game hasn't started yet, reset the game
    bird.jump();
    isStartScreen = false; // Hide the start screen
  }
}

class Pillar {
  float xPos, opening;
  boolean scored = false;

  Pillar(int i) {
    xPos = 100 + (i * 200); // Determine pillar's x-position
    opening = random(600) + 100;
  }

  void drawPillar() {
    fill(0);  // Set pillar color to black
    noStroke();
    rect(xPos - 10, 0, 20, opening - 100);
    rect(xPos - 10, opening + 100, 20, height - opening - 100);
  }

  void checkPosition() {
    if (xPos < 0) {
      xPos += (200 * 3);
      opening = random(600) + 100;
      scored = false;
    }
    if (xPos < 250 && !scored) {
      scored = true;
      score++;
    }
  }
}

class Bird {
  float xPos, yPos, ySpeed;

  Bird() {
    xPos = 250;
    yPos = 400;
  }

  void drawBird() {
    noStroke();
    fill(255);
    strokeWeight(2);
    ellipse(xPos, yPos, 20, 20);
  }

  void jump() {
    ySpeed = -10;
  }

  void applyGravity() {
    ySpeed += 0.7;
  }

  void move() {
    yPos += ySpeed;
    for (int i = 0; i < 3; i++) {
      pillars[i].xPos -= 3;
    }
  }

 void checkCollisions() {
    if (yPos > 800) {
      isGameStarted = false;
    }
    for (int i = 0; i < 3; i++) {
      float pillarLeft = pillars[i].xPos - 10;
      float pillarRight = pillars[i].xPos + 10;
      float pillarTop = pillars[i].opening - 100;
      float pillarBottom = pillars[i].opening + 100;

      if (xPos + 10 > pillarLeft && xPos - 10 < pillarRight && (yPos - 10 < pillarTop || yPos + 10 > pillarBottom)) {
        isGameStarted = false;
      }
    }
  }
}

void reset() {
  isGameStarted = true;
  isStartScreen = false;
  score = 0;
  for (int i = 0; i < 3; i++) {
    pillars[i].xPos += 550;
    pillars[i].scored = false;
  }
}
