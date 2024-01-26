extends Node2D
onready var area:Area2D = $Area2D


func _ready():
	area.connect("area_entered", self, "_onAreaEntered")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass
	
func _onAreaEntered(areaEntered:Area2D):
	if areaEntered.get_parent() is Ball:
		get_tree().reload_current_scene()
