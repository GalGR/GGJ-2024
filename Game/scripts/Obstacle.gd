extends Node2D
onready var area:Area2D = $Area2D
export var isButton = false
export (NodePath) var door:NodePath
var Door  = null
var pressed =  false

func _ready():
	if (isButton):
		Door = (get_node(door) as Node2D)
	area.connect("area_entered", self, "_onAreaEntered")

func die():
	queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass
	
func _onAreaEntered(areaEntered:Area2D):
	if areaEntered.get_parent() is Ball:
		areaEntered.get_parent().reverse()
		if (isButton):
			if (!pressed):
				Door.die()
				pressed = !pressed
		else:
			get_tree().reload_current_scene()
