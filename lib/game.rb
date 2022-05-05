require_relative 'cell.rb'

class Game
  attr_accessor :world, :width, :height, :cells
  @@iteration_count = 0

  def initialize(world: nil,width: 10,height: 10)
    @world = world || Array.new(width){ Array.new(height){rand(0..1)} }
    @width = @world.first.size
    @height = @world.size
  end

  def display_world
    sliced_world = Cell.instances.each_slice(width).to_a
    print "\n"
    sliced_world.each{|row|
      print row.map(&:emojifi_state).join('') + "\n"
    }
    print "Iteration: #{@@iteration_count} \n"
  end

  def spawn_cells
    reset_game
    world.each_with_index do |row, row_index|
      row.each_with_index do |column, column_index|
        state = (column == 1) ? 1 : 0
        Cell.new(column_index, row_index, state)
      end
    end
    Cell.instances
  end

  def reset_game
    Cell.instances = []
  end

  def get_cells_alive
    Cell.instances.select{ |cell| cell.alive? }
  end

  def get_all_candidate_cells
    live_cells = get_cells_alive
    candidate_cells = live_cells.map{ |cell| cell.neighbors(cell.x, cell.y) }
    candidate_cells << live_cells
    candidate_cells.flatten.uniq
  end

  def rule_parser
    candidates = []
    get_all_candidate_cells.each do |cell|
      candidates << cell if cell.alive? && ((cell.live_neighbors_count < 2) || (cell.live_neighbors_count > 3))
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
    @world = Cell.instances.each_slice(@width).to_a
    world_state = @world.map{|row| row.map(&:state) }
    world_state == expected_state
  end

  def start
      spawn_cells
    while true
      display_world
      tick!
      sleep 0.5
    end
  end
end
