require_relative 'game.rb'

#Starts randomly generated Game of Life
# game = Game.new
# game.start


# Starts predefined Game of Life with given world
#
# game = Game.new(world: [
#      [0, 0, 0, 0, 0, 0],
#      [0, 0, 0, 0, 0, 0],
#      [0, 0, 1, 1, 1, 0],
#      [0, 1, 1, 1, 0, 0],
#      [0, 0, 0, 0, 0, 0],
#      [0, 0, 0, 0, 0, 0]
#    ])
# game.start


# Starts Randomly generated Game of Life
# with arbitrary width and lengths
#
game = Game.new(width: 2, height: 3)
game.start
