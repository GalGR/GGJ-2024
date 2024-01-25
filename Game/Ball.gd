extends Position2D

export (NodePath) var pivot_node:NodePath				 				#point the pendulum rotates around
var pivot_point
var start_position: = Vector2() 		#pendulum itself
var arm_length:float
var angle											#Get angle between position + add godot angle offset

export (float) var gravity = 0.4 * 60
export (float) var damping = 0.995 							#Arbitrary dampening force

var angular_velocity = 0.0
var angular_acceleration = 0.0

func _ready()->void:
	set_start_position(global_position)

func set_start_position(start_pos:Vector2):
	#get_node("Sprite").modulate = 2;
	start_position = start_pos
	pivot_point = (get_node(pivot_node) as Node2D).position
	arm_length = Vector2.ZERO.distance_to(start_position-pivot_point)
	angle = -Vector2.DOWN.angle_to(start_position - pivot_point)
	angular_velocity = 0.0
	angular_acceleration = 0.0

func process_velocity(delta:float)->void:
	angular_acceleration = ((-gravity*delta) / arm_length) *sin(angle)	#Calculate acceleration (see: http://www.myphysicslab.com/pendulum1.html)
	angular_velocity += angular_acceleration				#Increment velocity
	angular_velocity *= damping								#Arbitrary damping
	angle += angular_velocity								#Increment angle
	
	start_position = pivot_point + Vector2(arm_length*sin(angle), arm_length*cos(angle))
	position = start_position

func add_angular_velocity(force:float)->void:
	angular_velocity += force

func _physics_process(delta)->void:
	game_input()											#example of in game swing kick
	
	process_velocity(delta)
	update()												#draw

func game_input()->void:
	var dir:float = 0
	if Input.is_action_just_pressed("right"):
		dir += 1
	elif Input.is_action_just_pressed("left"):
		dir -= 1
	add_angular_velocity(dir * 0.02) 						#give a kick to the swing
