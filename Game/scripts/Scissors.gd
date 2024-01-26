extends Node2D

export (NodePath) var position1Path:NodePath
export (NodePath) var position2Path:NodePath

var position1 : Vector2
var position2 : Vector2


func _ready():
	position1 = (get_node(position1Path) as Node2D).position
	position2 = (get_node(position2Path) as Node2D).position


func _process(delta):
	position = lerp(position1, position2, sin(OS.get_ticks_msec() / 1000.00))
	
	
#onready var coll = $CollisionShape2D
#func _physics_process(delta):
#	var new_coll = coll.duplicate()
#	var new_shape = coll.shape.duplicate()
#	new_coll.shape.a = position1
#	new_coll.shape.b = position2
#	add_child(new_coll, true)
	
	
#extends StaticBody2D
#
#var last_point = Vector2(1000,500)
#onready var line = $Line2D
#onready var coll = $CollisionShape2D
#
#func _physics_process(delta):
#	if Input.is_action_just_pressed("LMB"):
#		var new_point = get_global_mouse_position()
#		line.add_point(new_point)
#		var new_coll = coll.duplicate()
#		var new_shape = coll.shape.duplicate()
#		new_coll.shape = new_shape
#		new_coll.shape.a = last_point
#		new_coll.shape.b = new_point
#		add_child(new_coll, true)
#		last_point = new_point
