extends CanvasLayer

var running:bool = true
func _ready():
	$AnimationPlayer.play("fade")

func _process(delta):
	if $AnimationPlayer.current_animation != "fade" and $AnimationPlayer.current_animation != "fadeOut":
		if Input.is_action_just_pressed("menu_enter"):
			$AnimationPlayer.play("fadeOut")

func fade_out_blacked():
	Globals.set_play_state(true)
	Globals.emit_signal("game_over_finished")

func fade_out_ended():
	get_parent().remove_child(self)
