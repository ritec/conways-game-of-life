# Conway's Game of Life.
# Ri Caragol
require_relative 'cell.rb'

class Game
  attr_accessor :world, :width, :height, :cells
  @@iteration_count = 0

  def initialize(world: nil,width: 10,height: 10)
    @world = world || Array.new(width){ Array.new(height){rand(0..1)} }
    @width = @world.first.size
    @height = @world.size
    @cells = []
  end

  def display_world
    @world = cells.each_slice(@width).to_a
    print "\n"
    @world.each{|row| print row.map(&:state).to_s + "\n"}
    print "Iteration: #{@@iteration_count} \n"
  end

  def spawn_cells
    reset_game
    world.each_with_index do |row, row_index|
      row.each_with_index do |column, column_index|
          state = (column == 1) ? 1 : 0
          @cells << Cell.new(column_index, row_index, state)
      end
    end
    @cells
  end

  def reset_game
    Cell.instances = []
    @cells = []
  end

  def get_cells_alive
    cells.select{|cell| cell.alive? }
  end

  def get_all_candidate_cells
    candidate_cells = get_cells_alive.map{ |cell| cell.neighbors(cell.x, cell.y)}
    candidate_cells.flatten!.uniq!
  end

  def rule_parser
    candidates = []
    get_all_candidate_cells.each do |cell|
      candidates << cell if cell.alive? && (cell.live_neighbors_count < 2) || (cell.live_neighbors_count > 3)
      candidates << cell if cell.dead? && cell.live_neighbors_count == 3
    end
    candidates
  end

  def tick!
    cells_to_mutate = rule_parser
    cells_to_mutate.each{ |cell| cell.toggle! }
    @@iteration_count += 1
  end

  def test_game(seed, num_of_iterations, expected_state)
    @world = seed
    spawn_cells
    (1..num_of_iterations).each{|i| tick! }
    @world = cells.each_slice(@width).to_a
    world_state = @world.map{|row| row.map(&:state) }
    world_state == expected_state
  end

  def start
      spawn_cells
    while true
      display_world
      tick!
      display_world
      sleep 0.5
    end
  end

end