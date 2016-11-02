Here is my Ruby interpretation of Conway's Game of Life written in Ruby.

Here are the Game's Rules:

1. Any live cell with fewer than two live neighbours dies, as if caused by under-population.
2. Any live cell with two or three live neighbours lives on to the next generation.
3. Any live cell with more than three live neighbours dies, as if by over-population.
4. Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.

To start the game from a bash prompt just run from within lib: ruby start_game.rb
The game can start autonomously with a 10 x 10 grid with random live cells (default) or
with a predetermined world (2D array of 1s and 0s). Additionally an arbitrary
size for the world can be provided by starting the game like so:

game = Game.new(width: 2, height: 3)
game.start

All the starting methods for the game are covered in the start_game.rb file,
they just need to be commented and uncommented out to see them in action.
Tests can be found in the spec folder and they can be run form within the spec folder like so: `rspec game_spec.rb`
