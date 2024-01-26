extends Node2D

export (NodePath) var position1Path:NodePath
export (NodePath) var position2Path:NodePath

var position1 : Vector2
var position2 : Vector2

func _ready():
	position1 = (get_node(position1Path) as Node2D).position
	position2 = (get_node(position2Path) as Node2D).position



func _process(delta):
	position = lerp(position1, position2, sin(OS.get_ticks_msec() / 1000.00))
