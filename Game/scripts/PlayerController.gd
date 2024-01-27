extends Node

export (NodePath) var ball1:NodePath
export (NodePath) var ball2:NodePath
export (NodePath) var threadNodePath:NodePath

var ballNode1 : Node2D
var ballNode2 : Node2D
var thread : Line2D

var activeBall : Node2D
var anchoredBall : Node2D


onready var camera : Camera2D = $"../../Camera2D"
func _ready():
	ballNode1 = (get_node(ball1) as Node2D)
	ballNode2 = (get_node(ball2) as Node2D)
	activeBall = ballNode1
	anchoredBall = ballNode2
	thread = (get_node(threadNodePath) as Line2D)
	thread.clear_points()
	thread.add_point(ballNode1.global_position)
	thread.add_point(ballNode2.global_position)
	if camera and Globals.currentLevelNum!=5:
		print ("got camera")
		camera.reset_smoothing();
		camera.position = anchoredBall.position
	else:
		print ("did not get camera")
	
	Globals.connect("game_started", self, "switch_balls")

func _process(delta):
	if Globals.play_scene_running:
		game_input()
		updateThread()
		if camera and Globals.currentLevelNum!=5:
			camera.smoothing_enabled = true
			camera.position = anchoredBall.position

func game_input()->void:
	var dir:float = 0
	if Input.is_action_just_pressed("anchor_action"):
		switch_balls()
		
func switch_balls()->void:
	if (activeBall.isIn() and anchoredBall.isIn()):
		Globals.emit_signal("level_won")
	if activeBall == ballNode1:
		anchoredBall = ballNode1
		activeBall = ballNode2
	else:
		anchoredBall = ballNode2
		activeBall = ballNode1
			
	anchoredBall.set_active(false)
	activeBall.set_active(true)
	activeBall.init_anchor(anchoredBall)
	var particles = load("res://scenes/BallAnchoredParticles.tscn").instance()
	particles.position = anchoredBall.position
	get_parent().add_child(particles)
	
	#ball_anchored_particles.position = anchoredBall.position
	#ball_anchored_particles.restart()

func updateThread()->void:
	thread.set_point_position(0, ballNode1.global_position)
	thread.set_point_position(1, ballNode2.global_position)

	
