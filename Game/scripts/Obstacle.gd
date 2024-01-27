extends Node2D
onready var area:Area2D = $Area2D
export var Deadly = true
var Door  = null
var pressed =  false

func _ready():
	area.connect("area_entered", self, "_onAreaEntered")

func die():
	queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass
	
func _onAreaEntered(areaEntered:Area2D):
	if areaEntered.get_parent() is Ball:
		areaEntered.get_parent().reverse()
		if Deadly:
			Globals.emit_signal("player_hit_obstacle")
