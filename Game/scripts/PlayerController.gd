extends Node

export (NodePath) var ball1:NodePath
export (NodePath) var ball2:NodePath
export (NodePath) var cameraNode:NodePath
export (NodePath) var threadNodePath:NodePath

var ballNode1 : Node2D
var ballNode2 : Node2D
var camera : Camera2D
var thread : Line2D

var activeBall : Node2D
var anchoredBall : Node2D

func _ready():
	ballNode1 = (get_node(ball1) as Node2D)
	ballNode2 = (get_node(ball2) as Node2D)
	activeBall = ballNode1
	anchoredBall = ballNode2
	camera = (get_node(cameraNode) as Camera2D)
	#camera.position = anchoredBall.position
	# Don't enable smoothing in the editor so we can jump immediately to the position on start
	camera.smoothing_enabled = true
	thread = (get_node(threadNodePath) as Line2D)
	thread.clear_points()
	thread.add_point(ballNode1.global_position)
	thread.add_point(ballNode2.global_position)

func _process(delta):
	game_input()
	#camera.position = anchoredBall.position
	updateThread()

func game_input()->void:
	var dir:float = 0
	if Input.is_action_just_pressed("anchor_action"):
		switch_balls()

func switch_balls()->void:
	if activeBall == ballNode1:
		anchoredBall = ballNode1
		activeBall = ballNode2
	else:
		anchoredBall = ballNode2
		activeBall = ballNode1

	anchoredBall.set_active(false)
	activeBall.set_active(true)
	activeBall.init_anchor(anchoredBall)

func updateThread()->void:
	thread.set_point_position(0, ballNode1.global_position)
	thread.set_point_position(1, ballNode2.global_position)


