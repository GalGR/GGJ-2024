extends CanvasLayer

func _ready():
	$AnimationPlayer.play("fade")

func _process(delta):
	if $AnimationPlayer.current_animation != "fade":
		if Input.is_action_just_pressed("menu_enter"):
			$AnimationPlayer.play("fadeOut")

func fade_out_blacked():
	Globals.emit_signal("level_won_scene_finished")
	
func fade_out_ended():
	get_parent().remove_child(self)
