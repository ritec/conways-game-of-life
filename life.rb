# Conways Game of Life.

# Rules
# 1 - Any live cell with fewer than two live neighbours dies, as if caused by under-population. √
# 2 - Any live cell with two or three live neighbours lives on to the next generation. √
# 3 - Any live cell with more than three live neighbours dies, as if by over-population.
# 4 - Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.

class Game
  attr_accessor :board, :width, :height
  @@iteration_count = 0

  def initialize(board=nil, width=5, height=5)
    @board = Array.new(width){ Array.new(height){0} }
  end

  def display_board
    board.each{|line| print line.to_s + "\n" }
  end

  def initial_state #temporary
    @board = [
      [0, 0, 0, 0, 0],
      [0, 0, 1, 0, 0],
      [0, 0, 1, 0, 0],
      [0, 0, 1, 0, 0],
      [0, 0, 0, 0, 0]
    ]
  end

  def neighbors(x, y)
    north      = board[y-1][ x ] if board[y-1]
    north_east = board[y-1][x+1] if board[y-1]
    north_west = board[y-1][x-1] if board[y-1]

    east       = board[ y ][x+1] if board[x+1]
    west       = board[ y ][x-1] if board[x+1]

    south_east = board[y+1][x+1] if board[y+1]
    south      = board[y+1][ x ] if board[y+1]
    south_west = board[y+1][x-1] if board[y+1]
    [north, north_east, east, south_east, south, south_west, west, north_west]
  end

  def state_checker
    death_candidates = []
    stays_alive = []
    life_candidates = []
    board.each_with_index do |row, row_index|
      row.each_with_index do |column, column_index|
        death_candidates << [row_index, column_index] if (column == 1) && (neighbors(column_index, row_index).count(1) < 2) || (neighbors(column_index, row_index).count(1) > 3) #rule 1 && rule 3
        stays_alive << [row_index, column_index] if (column == 1) && (neighbors(column_index, row_index).count(1) == (2 || 3)) #rule 2
        life_candidates << [row_index, column_index] if column == 0 && neighbors(column_index, row_index).count(1) == 3 # rule 4
      end
    end
    state_changer(death_candidates, life_candidates)
  end

  def state_changer(death_candidates, life_candidates)
    death_candidates.each{ |coordinate| board[coordinate[0]][coordinate[1]] = 0 }
    life_candidates.each { |coordinate| board[coordinate[0]][coordinate[1]] = 1 }
    @@iteration_count += @@iteration_count
  end

  def test_game(seed, num_of_iterations, expected_state)
    @board = seed
    (1..num_of_iterations).each{|i| state_checker }
    @board == expected_state
  end

  def start
    while true
      display_board
      state_checker
      display_board
      sleep 0.5
    end
  end

end



game = Game.new
game.display_board
game.initial_state
game.neighbors(2,2)
game.start
# game.test_game([[0, 0, 0, 0, 0], [0, 0, 0, 0, 0], [0, 1, 1, 1, 0], [0, 0, 0, 0, 0], [0, 0, 0, 0, 0]],6 , [[0, 0, 0, 0, 0], [0, 0, 0, 0, 0], [0, 1, 1, 1, 0], [0, 0, 0, 0, 0], [0, 0, 0, 0, 0]])

# game.board.each_with_index{|row, r_index| row.each_with_index{|col, col_index| puts game.neighbors(col_index, r_index)}}
# print "row_index: #{row_index} row: #{row} column_index: #{column_index}  column: #{column} \n"
# print "death_candidates: #{death_candidates}   life_candidates: #{life_candidates} "
