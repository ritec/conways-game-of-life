require_relative '../lib/game.rb'

RSpec.describe Cell do

  before(:all) do
    @live_cell_one = Cell.new(1,0,1)
    @live_corner_cell = Cell.new(2,0,1)
    @live_lonely_cell = Cell.new(0,2,1)
    @dead_lonely_cell = Cell.new(0,5,0)
  end

  describe 'instances' do
    it 'should have correct amount of instances' do
      expect(Cell.instances.count).to eq(4)
    end
  end

  describe 'alive?' do
    it 'should correctly tell if a cell has state of 1' do
      expect(@live_cell_one.alive?).to eq(true)
    end
  end

  describe 'dead?' do
    it 'should correctly tell if a cell has state of 0' do
      expect(@live_cell_one.dead?).to eq(false)
      expect(@dead_lonely_cell.dead?).to eq(true)
    end
  end

  describe 'toggle!' do
    it 'should change the state of the cell' do
      expect(@dead_lonely_cell.state).to eq(0)
      @dead_lonely_cell.toggle!
      expect(@dead_lonely_cell.state).to eq(1)
      @dead_lonely_cell.toggle!
    end
  end

  describe 'neighbors' do
    it 'should find all neighbors of a cell' do
      neighbors = @live_corner_cell.neighbors(@live_corner_cell.x, @live_corner_cell.y)
      expect(neighbors).to include(@live_cell_one)
    end

    it 'should find no neighbor cells if cell is lonely' do
      neighbors = @dead_lonely_cell.neighbors(@dead_lonely_cell.x, @dead_lonely_cell.y)
      expect(neighbors.size).to eq(0)
    end
  end

  describe 'live_neighbors_count' do
    it 'should return the correct amount of live neighbor cells' do
      expect(@live_cell_one.live_neighbors_count).to eq(1)
    end

    it 'should return 0 if there are not neighbor cells' do
      expect(@dead_lonely_cell.live_neighbors_count).to eq(0)
    end
  end

end