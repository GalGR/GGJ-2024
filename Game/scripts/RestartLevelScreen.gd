extends CanvasLayer

var running:bool = true
func _ready():
	$AnimationPlayer.play("fadeOut")

func fade_out_blacked():
	Globals.set_play_state(true)
	Globals.emit_signal("game_over_finished")

func fade_out_ended():
	get_parent().remove_child(self)
