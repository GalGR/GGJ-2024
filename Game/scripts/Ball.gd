extends Position2D
class_name Ball


var pivot_point
var start_position: = Vector2() 		#pendulum itself
var arm_length:float
var angle											#Get angle between position + add godot angle offset

export (float) var gravity = 0.4 * 60
export (float) var damping = 0.995 							#Arbitrary dampening force

var angular_velocity = 0.0
var angular_acceleration = 0.0

var ball_active : bool = false


func _ready()->void:
	start_position = global_position

func init_anchor(pivot_node:Node2D):
	start_position = global_position
	#point the pendulum rotates around
	pivot_point = pivot_node.position
	arm_length = Vector2.ZERO.distance_to(start_position - pivot_point)
	angle = -Vector2.DOWN.angle_to(start_position - pivot_point)
	angular_velocity = 0.0
	angular_acceleration = 0.0
	
func set_active(active:bool):
	ball_active = active

func reverse():
	angular_velocity = -angular_velocity
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
	if Globals.play_scene_running:
		game_input()
	
		if ball_active:
			process_velocity(delta)
		update()

func game_input()->void:
	var dir:float = 0
	if Input.is_action_just_pressed("right"):
		dir += 1
	elif Input.is_action_just_pressed("left"):
		dir -= 1
	add_angular_velocity(dir * 0.02) 						#give a kick to the swing
