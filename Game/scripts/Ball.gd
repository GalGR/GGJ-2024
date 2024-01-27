extends Position2D
class_name Ball


var pivot_point
var start_position: = Vector2() 		#pendulum itself
var arm_length:float
var angle											#Get angle between position + add godot angle offset

export (float) var gravity = 0.4 * 60
export (float) var damping = 0.995 							#Arbitrary dampening force


var rotationSpeed = 0.3
var angularClamp = 0.4
var angular_velocity = 0.0
var angular_acceleration = 0.0


var ball_active : bool = false
var isIn = false;

onready var sprite : Sprite = $Sprite
onready var anchored_sprite_node : PackedScene = preload("res://prefabs/AnchoredSprite.tscn")

var happy_face_texture : Texture = preload("res://images/icon.png")
var sad_face_texture : Texture = preload("res://images/SadFace.png")

var modulateLerpStart = false

func _process(delta):
	sprite.modulate = sprite.modulate.linear_interpolate(Color(1, 1, 1), 0.08)
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
	
	if active:
		sprite.texture = happy_face_texture
	else:
		sprite.modulate = Color(0.0, 0.0, 255.0)
		sprite.texture = sad_face_texture
		var anchoredSprite = anchored_sprite_node.instance()
		anchoredSprite.position = position
		get_parent().get_parent().add_child(anchoredSprite)

func reverse():
	angular_velocity = -angular_velocity
	
func setIn (newState: bool):
	isIn = newState
	
func markIn():
	setIn(true)
	
func markOut():
	setIn(false)
	
func isIn():
	return isIn
	
func process_velocity(delta:float)->void:
	angular_acceleration = ((-gravity*delta) / arm_length) *sin(angle)	#Calculate acceleration (see: http://www.myphysicslab.com/pendulum1.html)
	angular_velocity += angular_acceleration				#Increment velocity
	angular_velocity *= damping								#Arbitrary damping
	
	# clamp the angular velocity
	angular_velocity = clamp(angular_velocity, -angularClamp, angularClamp)
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
	if Input.is_action_pressed("right"):
		dir += rotationSpeed
	elif Input.is_action_pressed("left"):
		dir -= rotationSpeed
	add_angular_velocity(dir * 0.02) 						#give a kick to the swing
