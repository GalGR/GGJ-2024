extends Node2D
onready var area:Area2D = $Area2D
export (NodePath) var door:NodePath
var Door
var pressed = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Door = (get_node(door) as Node2D)
	area.connect("area_entered", self, "_onAreaEntered")
	pass # Replace with function body.

func _onAreaEntered(areaEntered:Area2D):
	if areaEntered.get_parent() is Ball:
		areaEntered.get_parent().reverse()
		if (!pressed):
			Door.die()
			pressed = !pressed
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
