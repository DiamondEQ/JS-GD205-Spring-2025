class Player {

  // Player's position and size
  int pX, pY;       // Center position of the paddle (x, y)
  int w, h;         // Width and height of the paddle

  // Paddle edges and center point for collision detection
  int tl, tr;       // Top-left (tl) and top-right (tr) x-coordinates of the paddle
  int mid_point;    // Center x-coordinate of the paddle

  // Constructor initializes the player's paddle properties
  Player() {
    w = 100;        // Paddle width
    h = 20;         // Paddle height
    pX = 400;       // Start x-position at the center of the screen
    pY = 590;       // Fixed y-position near the bottom of the screen
    tl = 0;         // Initial top-left coordinate (calculated later)
    tr = 0;         // Initial top-right coordinate (calculated later)
    mid_point = 0;  // Initial center point (calculated later)
  }

  // Updates the paddle's position and redraws it
  void update() {
    // Move the paddle horizontally based on the mouse's x-position
    pX = mouseX;

    // Calculate paddle's edges and center
    tl = pX - (w / 2);    // Top-left x-coordinate
    tr = pX + (w / 2);    // Top-right x-coordinate
    mid_point = pX;       // Center x-coordinate

    // Draw the paddle as a white ellipse that follows the mouse
    fill(255);
    ellipse(pX, pY, w, h);
  }
}
