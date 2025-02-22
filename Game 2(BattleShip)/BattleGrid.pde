// class used for the playspace of the game
class BattleGrid {
  int Gsize, CSize; // size of the grid and size of each cell

  BattleGrid(int size, int cellSize) {
    this.Gsize = size; // sets the total number of cells in one row/column
    this.CSize = cellSize; // Sets the size of each cell
  }

  void display() {
    stroke(0); // make the color of the grid lines to be black
    for (int i = 0; i <= Gsize; i++) { // a Loop for drawing both the vertical and horizontal lines
      line(i * CSize, 0, i * CSize, Gsize * CSize); // Draws vertical(y axis) grid lines
      line(0, i * CSize, Gsize * CSize, i * CSize); // Draws horizontal(x axis) grid lines
    }
  }
}
