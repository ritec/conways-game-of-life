require_relative '../lib/game.rb'

RSpec.describe Game do

  before(:all) do
    @blinker = [
      [0, 0, 0, 0, 0],
      [0, 0, 1, 0, 0],
      [0, 0, 1, 0, 0],
      [0, 0, 1, 0, 0],
      [0, 0, 0, 0, 0]
    ]

    @still_life = [
      [0, 0, 0, 0, 0],
      [0, 0, 1, 1, 0],
      [0, 0, 1, 1, 0],
      [0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0]
    ]

    @beacon = [
      [0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0],
      [0, 0, 1, 1, 1, 0],
      [0, 1, 1, 1, 0, 0],
      [0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0]
    ]

    @single_glider = [
      [0,0,0,0,0,0,0,0,0,0,0],
      [0,0,0,0,0,0,0,0,0,0,0],
      [0,0,0,0,0,0,0,0,0,0,0],
      [0,0,0,0,0,0,0,0,0,0,0],
      [0,0,0,1,1,1,1,1,0,0,0],
      [0,0,0,0,0,0,0,0,0,0,0],
      [0,0,0,0,0,0,0,0,0,0,0],
      [0,0,0,0,0,0,0,0,0,0,0],
      [0,0,0,0,0,0,0,0,0,0,0]
    ]

    @single_glider_mutated = [
      [0,0,0,0,0,1,0,0,0,0,0],
      [0,0,0,0,0,1,0,0,0,0,0],
      [0,0,0,0,0,1,0,0,0,0,0],
      [0,0,0,0,0,0,0,0,0,0,0],
      [0,1,1,1,0,0,0,1,1,1,0],
      [0,0,0,0,0,0,0,0,0,0,0],
      [0,0,0,0,0,1,0,0,0,0,0],
      [0,0,0,0,0,1,0,0,0,0,0],
      [0,0,0,0,0,1,0,0,0,0,0]
    ]

    @game = Game.new(world: @blinker)
    @game.spawn_cells
  end

  it 'should test initialization with world' do
    expect(@game.world).to eq(@blinker)
  end

  describe 'spawn_cells' do
    it 'should spawn correct amount of live cells in world' do
      expect(Cell.instances.select{|c| c.alive? }.count).to eq(3)
    end

    it 'should spawn correct amount of cells in world' do
      expect(Cell.instances.count).to eq(25)
    end
  end

  describe "get_cells_alive" do
    it 'should find correct live neighbors count of corner cell' do
      live_cells = @game.get_cells_alive
      expect(live_cells.count).to eq(3)
    end
  end

  describe "get_all_candidate_cells" do
    it "should only return cells that could potentially change state" do
      candidate_cells = @game.get_all_candidate_cells
      expect(candidate_cells.count).to eq(15)
    end
  end

  describe "rule_parser" do
    it 'should correctly find cells affected by rules to toggle' do
      cells_to_toggle = @game.rule_parser
      cell_affected = Cell.instances.select{|c| c.x == 2 && c.y == 1}.first
      expect(cells_to_toggle).to include(cell_affected)
    end
  end

  describe "tick!" do
    it 'should correctly change the state of an affected cell' do
      cell_affected = Cell.instances.select{|c| c.x == 2 && c.y == 1}.first
      expect(cell_affected.state).to eq(1)
      @game.tick!
      expect(cell_affected.state).to eq(0)
    end
  end

  describe "check_state" do
    it 'should correctly check truthy state of games' do
      game2 = Game.new(world: @blinker)
      result = game2.test_game(@blinker, 6, @blinker)
      expect(result).to eq(true)
    end

    it 'should correctly check falsey state of games' do
      game3 = Game.new(world: @blinker)
      result = game3.test_game(@blinker, 5, @blinker)
      expect(result).to eq(false)
    end

    it 'should correctly check falsey state of games' do
      game4 = Game.new(world: @blinker)
      result = game4.test_game(@blinker, 2, @still_life)
      expect(result).to eq(false)
    end

    it 'should correctly alternate beacon' do
      game5 = Game.new(world: @beacon)
      result = game5.test_game(@beacon, 10, @beacon)
      expect(result).to eq(true)
    end

    it 'should show correct postions for glider after 7 iterations' do
      game6 = Game.new(world: @single_glider)
      result = game6.test_game(@single_glider, 7, @single_glider_mutated)
      expect(result).to eq(true)
    end
  end

end