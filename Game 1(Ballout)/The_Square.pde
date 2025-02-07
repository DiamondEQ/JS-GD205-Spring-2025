class Ball {
  // Boundaries of the Play Space
  int leftBound, rightBound, topBound, bottomBound;
  
  // Location of the ball
  int bX, bY;
  
  // Speed and direction of the ball
  int speed, yDirection;
  
  // Controls the ball's horizontal movement
  private float xOffset, multiplier;
  
  // Dimensions of the ball
  int w, h;

  // Constructor initializes the ball's properties
  Ball() {
    bX = 400;             // Start x-position at the center of the screen
    bY = 300;             // Start y-position at the center of the screen
    speed = 5;            // Starting speed of the ball
    yDirection = 1;       // Ball starts moving downward (1 = down, -1 = up)
    xOffset = 0.0;        // No horizontal movement initially
    multiplier = 4.0;     // Multiplier for calculating xOffset
    w = 20;               // Ball's width
    h = 20;               // Ball's height
  }

  // Checks if the ball is within the game's play space boundaries
  void boundaryChecks() {
    // Horizontal boundaries
    if (xOffset < 0) { // Moving left
      if (bX <= 10) {  // Hits the left wall
        xOffset *= -1; // Reverse horizontal direction
      }
    } else if (xOffset > 0) { // Moving right
      if (bX >= 1270) {        // Hits the right wall
        xOffset *= -1;        // Reverse horizontal direction
      }
    }

    // Vertical boundaries
    if (yDirection < 0) { // Moving up
      if (bY <= 10) {     // Hits the top wall
        yDirection *= -1; // Reverse vertical direction
      }
    } else if (yDirection > 0) { // Moving down
      if (bY >= 610) {           // Hits the bottom of the Play Space
        // Reset ball to the center with default settings
        bX = 400;
        bY = 300;
        xOffset = 0.0;
        speed = 5;
      }
    }
  }

  // Checks if the ball hits the player paddle
  void checkForPlayerHit() {
    // If the ball is within the paddle's horizontal range and near its height
    if (bX >= player.tl && bX <= player.tr && bY > 570) {
      speed = 5; // Reset speed
      
      // Check if the ball hits the center of the paddle
      if (bY == player.mid_point) {
        xOffset = 0.0; // No horizontal movement
      } else {
        // Calculate horizontal movement based on where the ball hits the paddle
        xOffset = ((bX - player.mid_point) / multiplier);

        // Adjust speed based on the multiplier
        speed += abs(floor(multiplier) + 2) - abs(multiplier);
      }
      
      yDirection *= -1; // Reverse vertical direction (ball bounces upward)
    }
  }

  // Reverse vertical direction (helper method)
  void flipY() {
    yDirection *= -1;
  }

  // Reverse horizontal direction (helper method)
  void flipX() {
    xOffset *= -1;
  }

  // Updates the ball's position and draws it
  void update() {
    if (!intro) { // Only update the ball if the game is not in the intro state
      boundaryChecks(); // Check if the ball hits any boundaries

      // Update the ball's current bounds
      leftBound = bX - (w / 2);
      rightBound = bX + (w / 2);
      topBound = bY - (h / 2);
      bottomBound = bY + (h / 2);

      // If the ball is moving downward, check for paddle collision
      if (yDirection == 1) {
        checkForPlayerHit();
      }

      // Update the ball's position
      bX += xOffset;            // Adjust x-position by xOffset
      bY += (speed * yDirection); // Adjust y-position by speed and direction
    }

    // Draw the ball as a red rectangle
    fill(255, 0, 0);
    rect(bX, bY, w, h);
  }
}
