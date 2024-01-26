extends Node

var player_dead = false
var added_game_over_screen = false

func _ready():
	Globals.connect("player_hit_obstacle", self, "on_player_hit_obstacle")

func on_player_hit_obstacle():
	if !added_game_over_screen :
		var gameOverScreen = load("res://scenes/GameOverScene.tscn").instance()
		add_child(gameOverScreen)
		added_game_over_screen = true
		Globals.play_scene_running = false
