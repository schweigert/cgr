require_relative "node2d"
require_relative "camera"
###############
# GAME CONFIG #
###############

$winX = 640.0
$winY = 480.0

$name = "My Game"

################

$scene = Node2D.new

camera = Camera.new
$scene << camera
