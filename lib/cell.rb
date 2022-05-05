class Cell
  attr_accessor :x, :y, :state
  @instances = []

  def initialize(x, y, state)
    @x = x
    @y = y
    @state = state
    self.class.instances << self
  end

  def self.instances
    @instances
  end

  def self.instances=(value)
    @instances = value
  end

  def alive?
    state == 1
  end

  def dead?
    state == 0
  end

  def toggle!
    @state = alive? ? 0 : 1
  end

  def emojifi_state
    alive? ? '⚫️' : '⚪️'
  end

  def neighbors(x, y)
    north      = self.class.instances.select{|c| (x == c.x  ) && (y == c.y-1) }
    north_east = self.class.instances.select{|c| (x == c.x+1) && (y == c.y-1) }
    north_west = self.class.instances.select{|c| (x == c.x-1) && (y == c.y-1) }

    east       = self.class.instances.select{|c| (x == c.x+1) && (y == c.y) }
    west       = self.class.instances.select{|c| (x == c.x-1) && (y == c.y) }

    south_east = self.class.instances.select{|c| (x == c.x+1) && (y == c.y+1) }
    south      = self.class.instances.select{|c| (x == c.x  ) && (y == c.y+1) }
    south_west = self.class.instances.select{|c| (x == c.x-1) && (y == c.y+1) }
    [north, north_east, east, south_east, south, south_west, west, north_west]
  end

  def live_neighbors_count
    neighbors(x,y).flatten!.map(&:state).count(1)
  end
end
