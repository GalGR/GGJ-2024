extends CanvasLayer

var running:bool = true
func _ready():
	$AnimationPlayer.play("fade")

func _process(delta):
	if $AnimationPlayer.current_animation != "fade":
		if Input.is_action_just_pressed("anchor_action"):
			$AnimationPlayer.play("fadeOut")

func fade_out_ended():
	get_tree().get_root().remove_child(self)
	Globals.set_play_state(true)
	Globals.emit_signal("game_over_finished")
