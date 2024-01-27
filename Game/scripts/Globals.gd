extends Node

signal player_hit_obstacle
signal game_over_finished
signal game_won
signal level_won_scene_finished

var play_scene_running : bool = true

var currentLevelNum : int = 1

func _ready():
	pass # Replace with function body.

func set_play_state(playState : bool):
	play_scene_running = playState
	
