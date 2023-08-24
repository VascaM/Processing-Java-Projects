// This code displays a visual simulation of a space scene with moving stars and a UFO.

int Depth = 300;
int numberOfStars = 5000;
int maxSpeedStars = 10;
int starSize = 3;

Stars[] starArray = new Stars[numberOfStars];
Timer Timer1 = new Timer();
Ufo Ufo1 = new Ufo();

void setup() {
  size(1000, 700, P3D);
  colorMode(HSB);

  strokeWeight(starSize);
  for (int i = 0; i < numberOfStars; i++) {
    starArray[i] = new Stars(random(-4 * width, 4 * width), random(-4 * height, 4 * height),
      -random(Depth * 250), random(1, maxSpeedStars));
  }
}

void draw() {
  background(0);
  textSize(30);
  fill(255);
  text("Press and hold 'x' and move the mouse", 15, 675);

  for (int i = 0; i < numberOfStars; i++) {
    starArray[i].display();
    starArray[i].move();
  }

  Ufo1.display();
  Timer1.display();
}

class Stars {
  float x;
  float y;
  float z;
  float speed;

  Stars(float tempX, float tempY, float tempZ, float tempSpeed) {
    x = tempX;
    y = tempY;
    z = tempZ;
    speed = tempSpeed;
  }

  void display() {
    stroke(color(255));
    point(x, y, z);
  }

  void move() {
    z = z + speed;
    if (z >= 0)
      z = -1023.0;
  }
}

class Timer {
  int milliseconds;
  int seconds;
  boolean start = false;

  void display() {
    if (start) {
      if (int(millis() / 100) % 10 != milliseconds) {
        milliseconds++;
      }
      if (milliseconds >= 10) {
        milliseconds -= 10;
        seconds++;
      }
    }

    fill(255);
    textSize(30);
    text("The time that 'x' has been pressed = " + nf(seconds) + " seconds", 15, 30);

    if (keyPressed && key == 'x') {
      start = true;
    } else {
      start = false;
    }
  }
}

class Ufo {
  float c;

  void display() {
    if (keyPressed && key == 'x') {
      if (c >= 255) c = 0;
      else c++;
      fill(c, 255, 255);
    } else {
      fill(#97bbf4);
    }

    noStroke();
    ellipse(mouseX, mouseY - 50, 160, 200);     // Draw UFO top

    noStroke();
    fill(#707070);
    ellipse(mouseX, mouseY, 300, 120);     // Draw UFO middle

    // Check again if the 'x' key is held down for a different color
    if (keyPressed && key == 'x') {
      if (c >= 255) c = 0;
      else c++;
      fill(c, 255, 255);
    } else {
      fill(#97bbf4);
    }

    noStroke();
    ellipse(mouseX, mouseY - 50, 158, 40);     // Draw overlapping UFO top

    // Check again if the 'x' key is held down for a different color
    if (keyPressed && key == 'x') {
      if (c >= 255) c = 0;
      else c++;
      fill(c, 255, 255);
    } else {
      fill(0);
    }

    noStroke();
    ellipse(mouseX, mouseY + 15, 15, 15);          // Draw UFO circle 1
    ellipse(mouseX - 100, mouseY + 5, 15, 15);     // Draw UFO circle 2
    ellipse(mouseX + 100, mouseY + 5, 15, 15);     // Draw UFO circle 3
  }
}
