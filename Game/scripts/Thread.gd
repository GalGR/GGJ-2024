extends Line2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var new_shape = CollisionShape2D.new()
	$StaticBody2D.add_child(new_shape)
	var segment = SegmentShape2D.new()
	segment.a = get_point_position(0)
	segment.b = get_point_position(1)
	new_shape.shape = segment

