extends CanvasLayer

var gameStarted : bool = false

func _ready():
	$AnimationPlayer.play("fade")

func _process(delta):
	if not gameStarted and $AnimationPlayer.current_animation != "fade" and $AnimationPlayer.current_animation != "fadeOut" and Input.is_action_just_pressed("menu_enter"):
		$AnimationPlayer.play("fadeOut")

func fade_out_started():
	Globals.play_scene_running = true
	Globals.emit_signal("game_started")

func fade_out_ended():
	get_parent().remove_child(self)
