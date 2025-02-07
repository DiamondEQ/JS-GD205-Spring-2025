class Brick {

  // Brick boundaries and dimensions
  int leftBound, LBottomBase, rightBound, RBottomBase, topBound, TopBase;
  int w, h;       // Width, and Height of the brick

  // Position of the brick
  int x, y;       // Center position of the brick (x, y, z)

  // Color of the brick
  float r, g, b;     // RGB values for the brick's color

  // State of the brick (active or inactive)
  boolean active = true; // Determines if the brick is visible and can be hit

  // Constructor initializes the brick's position, dimensions, and random color
  Brick(int tX, int tY) {
    w = 50;                   // Brick width
    h = 50;                   // Brick height
    
    // Position is set based on input coordinates with adjustments
    x = tX + (w / 2);         // Center x-position
    y = tY + (h / 2);         // Center y-position

    // Assign random colors for the brick
    r = random(255);          // Random red value
    g = random(255);          // Random green value
    b = random(255);          // Random blue value
  }

  // Checks if the ball has collided with the brick
  boolean checkForCollision() {
    if (!active) { // If the brick is inactive, skip collision detection
      return false;
    }

    // Calculate the brick's boundaries
    leftBound = x - (w / 2);    // Left boundary
    LBottomBase = y + (h / 2);  // Left Bottom Base
    rightBound = x + (w / 2);   // Right boundary
    RBottomBase = y + (h / 2);  // Rigth Bottom Base
    topBound = x;               // Top boundary
    TopBase = y - (h / 2);      // Bottom Base

    // Draw the brick using its color and position
    fill(r, g, b);              // Set brick color
    triangle(leftBound ,LBottomBase ,rightBound, RBottomBase, topBound, TopBase); // Draw the brick

    // Check if the ball's position overlaps with the brick's boundaries
   boolean xBounds = (ball.bX + 10) >= leftBound && (ball.bX - 10) <= rightBound;
   boolean yBounds = (ball.bY + 10) >= LBottomBase && (ball.bY - 10) <= RBottomBase;
    // If both x and y overlap, a collision is detected
    if (xBounds && yBounds) {
      return true;
    }

    return false; // No collision detected
  }

  // Deactivates the brick (makes it inactive)
  void deactivate() {
    active = false; // Brick is no longer active and won't be drawn or checked for collisions
  }
}
