// class for the boats used in the game
class BattleShip_Boats {
  int size; // Size of ships
  ArrayList<PVector> positions = new ArrayList<PVector>();
  ArrayList<ShipPartsObserver> observers = new ArrayList<ShipPartsObserver>(); // List of observers monitoring the ship

  BattleShip_Boats(int size) {
    this.size = size;
  }

  //using the Clone method for Prototype design Pattern
  BattleShip_Boats clone() {
    return new BattleShip_Boats(this.size); // Creates a new ship with the same size
  }

  void addObserver(ShipPartsObserver observer) {
    observers.add(observer); // adds an observer to monitor all the ships state
  }

  void notifyObservers() {
    for (ShipPartsObserver observer : observers) {
      observer.update(this); // sends a Noti to all observers when a change occurs within the game
    }
  }

  void placeRandomly(int gridSize) { // places all the ships randomly on the grid
    positions.clear();
    boolean horizontal = random(1) > 0.5; // Determines if a ship will be placed horizontally and or vertically
    int x, y;

    if (horizontal) { // If placing horizontally
      x = int(random(gridSize - size + 1));
      y = int(random(gridSize));
      for (int i = 0; i < size; i++) {
        positions.add(new PVector(x + i, y)); // Adds horizontal ship parts (positions)
      }
    } else { // If placing vertically
      x = int(random(gridSize));
      y = int(random(gridSize - size + 1));
      for (int i = 0; i < size; i++) {
        positions.add(new PVector(x, y + i)); // adds vertical ship parts (positions)
      }
    }
  }

  boolean hit(int x, int y) { // Checks if a ship part was hit
    for (PVector pos : positions) {
      if (pos.x == x && pos.y == y) { // If hit
        positions.remove(pos); // then remove the ship part that was hit (position)
        notifyObservers(); // sends a notification to the observers about the change
        return true;
      }
    }
    return false; // if not hit
  }

  boolean isSunk() { // checks if the ship is completely destroyed
    return positions.isEmpty(); // if all parts (positions) are gone,then the ship is sunk
  }

  void display() { // Displays all ships on the grid
    fill(240); // Sets the color for all the ships
    for (PVector pos : positions) {
      rect(pos.x * cellSize, pos.y * cellSize, cellSize, cellSize); // Draws each part of a ship
    }
  }
}
