// Made with help from a tutorial from a website named https://joemoceri.medium.com/using-processing-to-build-the-classic-game-breakout-4c71a6e70faa
// Declare global variables for key game objects and configs
Player player; // The player-controlled paddle
Ball ball;     // The ball that moves and interacts with the bricks and paddle
Brick[] bricks; // Array to hold all the bricks in the game

// Game window size
int sizeWidth = 1280, sizeHeight = 600;

// Variables to manage time and frame rates
int frameRate = 0;
int startTime = 0;

// Duration in milliseconds during which the ball can't interact with bricks after a collision
int ln = 65; 

// A flag to temporarily disable ball-brick collisions
boolean cantCollideWithBricks = false;

// A flag to manage the intro phase of the game
boolean intro = true;

void setup() {
  // Initialize the player paddle and the ball
  player = new Player();
  ball = new Ball();

  // Total number of bricks and setup the array
  int totalBricks = 132;
  bricks = new Brick[totalBricks];

  // Variables to position bricks in rows and columns
  int xCounter = 0, yCounter = 0;

  // Create and position each brick
  for (int i = 0; i < bricks.length; i++) {
    int tX = 75 * xCounter; // Horizontal spacing between bricks
    if (tX >= 1275) { // If we exceed the screen width, start a new row
      tX = 0;
      xCounter = 0;
      yCounter++;
    }

    int tY = 20 * yCounter; // Vertical spacing between rows

    bricks[i] = new Brick(tX, tY); // Create a new brick at the calculated position

    xCounter++; // Move to the next horizontal position
  }

  // Set up the game window and rendering settings
  size(1280, 600);      // Set the window size
  rectMode(CENTER);    // Set rectangle drawing mode to center
  noStroke();          // Disable outlines for shapes
  smooth();            // Enable anti-aliasing for smoother visuals
}

void draw() {
  // Reactivate brick collision after a certain time has passed
  if ((millis() - startTime) > ln && cantCollideWithBricks) {
    cantCollideWithBricks = false;
  }

  background(0); // Clear the screen with a black background

  // Update and draw the player paddle
  player.update();

  // Update and draw the ball
  ball.update();

  // Check for collisions between the ball and the bricks
  for (int i = 0; i < bricks.length; i++) {
    boolean collision = bricks[i].checkForCollision(); // Check if the ball hits this brick

    if (collision && !cantCollideWithBricks) {
      startTime = millis();  // Record the time of the collision
      cantCollideWithBricks = true; // Temporarily disable collisions to avoid multiple hits

      bricks[i].deactivate(); // "Break" the brick by deactivating it

      // Determine how to bounce the ball based on the collision direction
      if (ball.rightBound > bricks[i].rightBound || ball.leftBound < bricks[i].leftBound) {
        ball.flipX(); // Reverse horizontal direction
      } else {
        ball.flipY(); // Reverse vertical direction
      }
    }
  }
}

// Handle mouse movement in the intro phase to position the ball
void mouseMoved() {
  if (intro) ball.bX = mouseX; // Move the ball horizontally with the mouse
}

// Allow dragging the ball with the mouse in the intro phase
void mouseDragged() {
  if (intro) ball.bX = mouseX; // Keep updating the ball position
}

// Start the game when the mouse is released
void mouseReleased() {
  if (intro) {
    intro = false; // End the intro phase, starting the game
  }
}
