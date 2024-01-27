extends Node

signal player_hit_obstacle
signal game_over_finished
signal level_won
signal level_won_scene_finished
signal game_started
signal game_won

var play_scene_running : bool = true

var currentLevelNum : int = 1

func _ready():
	var gameStartScreen = load("res://scenes/GameStartScreen.tscn").instance()
	if (gameStartScreen):
		add_child(gameStartScreen)
		Globals.play_scene_running = false

func set_play_state(playState : bool):
	play_scene_running = playState
	
