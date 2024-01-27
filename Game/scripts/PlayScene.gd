extends Node

var player_dead = false
var scene_transition_active = false

func _ready():
	Globals.connect("player_hit_obstacle", self, "on_player_hit_obstacle")
	Globals.connect("game_over_finished", self, "on_game_over_finished")
	Globals.connect("level_won_scene_finished", self, "on_new_level")
	Globals.connect("level_won", self, "on_player_win")
	Globals.connect("restart_level", self, "on_player_hit_restart")

func on_player_hit_obstacle():
	if !scene_transition_active:
		var gameOverScreen = load("res://scenes/GameOverScene.tscn").instance()
		add_child(gameOverScreen)
		scene_transition_active = true
		Globals.play_scene_running = false

func on_player_hit_restart():
	if !scene_transition_active:
		var restartLevelScreen = load("res://scenes/RestartLevelScreen.tscn").instance()
		add_child(restartLevelScreen)
		scene_transition_active = true
		Globals.play_scene_running = false
		
func on_player_win():
	if !scene_transition_active:
		print ("win screen")
		var gameWonScreen = load("res://scenes/LevelWonScene.tscn").instance()
		add_child(gameWonScreen)
		scene_transition_active = true
		Globals.play_scene_running = false
		
func on_game_over_finished():
	get_tree().reload_current_scene()
	scene_transition_active = false

func on_new_level():
	Globals.currentLevelNum+=1
	scene_transition_active = false
	var nextLevel = "res://scenes/Level%d.tscn" % Globals.currentLevelNum
	if ResourceLoader.exists(nextLevel):
		print("Advancing to the next level: \"%s\"" % nextLevel)
#		var previousLevel = get_tree().get_root().get_node("LevelRoot")
#		print("Previous Level: %s" % str(previousLevel))
#		get_tree().get_root().add_child(load(nextLevel).instance())
#		get_tree().get_root().remove_child(previousLevel)
		get_tree().change_scene(nextLevel)
		Globals.play_scene_running = true
	else:
		Globals.emit_signal("game_won")
