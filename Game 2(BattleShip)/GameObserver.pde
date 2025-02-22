// class used for observing when parts of a ship are hit.
class ShipPartsObserver {
  void update(BattleShip_Boats ship) {

    // prints while at the same time checks out how manyremaining parts of a ship are still left
    println("Ship part was hit! Remaining parts: " + ship.positions.size());

    // checks if a whole ship is completely sunk.
    if (ship.isSunk()) {
      // If any ship is sunk, this message will be printed.
      println("A ship has sunk good job!");
    }
  }
}
