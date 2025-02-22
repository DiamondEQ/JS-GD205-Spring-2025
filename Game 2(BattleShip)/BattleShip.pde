// BTW a single cell on the grid can house multiple ship parts, so you might have to click a cell multiple times. Just a FYI
// playspace grid
int gridSize = 10; // the number of cells in the grid in this case its a (10x10 grid)
int cellSize = 40; // the size of each cell in the grid

// important game variables
BattleGrid grid;
ArrayList<BattleShip_Boats> Ships = new ArrayList<BattleShip_Boats>(); // A list to store all the ships in the game
ShipPartsObserver observer; // an observer to keep track of a part of a ship status as well as its state
boolean gameOver = false; // a flag to check if the game has ended

void setup() {
  size(404, 404);
  grid = new BattleGrid(gridSize, cellSize); // creates a grid based with use of both int grid size and int cell size
  observer = new ShipPartsObserver(); // the observer for tracking ship status

  // Creates a prototype ship while cloning it multiple times
  BattleShip_Boats prototype = new BattleShip_Boats(2); // Creates a prototype ship with the size 3 cells
  for (int i = 0; i < 5; i++) { // loop to create and place 5 ships
    BattleShip_Boats clonedShip = prototype.clone(); // Clones the prototype ship
    clonedShip.placeRandomly(gridSize); // Places the ship randomly on the grid
    clonedShip.addObserver(observer); // adds the observer to track the ship
    Ships.add(clonedShip); // Adds the ship to the list
  }
}

void draw() {
  background(255);
  grid.display();

  // Loop through each ship and display it on the grid
  for (BattleShip_Boats ship : Ships) {
    ship.display();
  }

  // Checks if all ships are sunk
  if (!gameOver && Ships.stream().allMatch(ship -> ship.isSunk())) { // If all ships are destroyed
    println("What a Gamer you are, GAME OVER! All ships are sunk."); // then it will print the "What a Gamer you are, GAME OVER! All ships are sunk." message
    gameOver = true; // while also setting the game to the over state
  }
}

// handles the mouse functionality within the game
void mousePressed() {
  if (gameOver) return; // if the game is in its over state, then when the mouse is clicked nothing happends

  int x = mouseX / cellSize; // makes the mouse X position the same to the X grid coordinates
  int y = mouseY / cellSize; // makes the mouse Y position the same to the Y grid coordinates

  // Checks if any part of a ship is hit
  for (BattleShip_Boats ship : Ships) {
    if (ship.hit(x, y)) { // If the clicked position hits a part of a ship
      println("Ship Part Hit at: " + x + ", " + y); //then it will print a "Hit" message with coordinates of a part of a ship that was hit
      return; //while also it will stop checking further
    }
  }
  println("Miss at: " + x + ", " + y); // If no part of a ship is hit when a cell is clicked, then it will print a "Miss" message
}
