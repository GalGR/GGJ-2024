extends Node

signal player_hit_obstacle
signal game_over_finished

var play_scene_running : bool = true

func _ready():
	pass # Replace with function body.

func set_play_state(playState : bool):
	play_scene_running = playState
	