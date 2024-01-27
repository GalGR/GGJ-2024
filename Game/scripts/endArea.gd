extends Node2D
onready var area:Area2D = $Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	area.connect("area_entered", self, "_onAreaEntered")
	area.connect("area_exited", self, "_onAreaLeft")

func _onAreaEntered(areaEntered:Area2D):
	if areaEntered.get_parent() is Ball:
		areaEntered.get_parent().markIn()

func _onAreaLeft(areaLeft:Area2D):
	if areaLeft.get_parent() is Ball:
		areaLeft.get_parent().markOut()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
