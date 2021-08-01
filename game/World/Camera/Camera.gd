extends Spatial

export (float) var max_zoom
export (float) var min_zoom
export (float) var speed
export (NodePath) var follow
var follow_node : Spatial

var is_middle_pressed : bool
var initial_pos : Vector3

# Called when the node enters the scene tree for the first time.
func _ready():
	follow_node = get_node(follow) as Spatial
	initial_pos = follow_node.global_transform.origin - global_transform.origin

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	global_transform.origin = follow_node.global_transform.origin - initial_pos

func _input(event):
	# Zoom
	if event is InputEventMouseButton and event.is_pressed():
		var processed_speed = $Camera.global_transform.basis.z * speed
		match event.button_index:
			BUTTON_WHEEL_DOWN:
				if global_transform.origin.distance_to($Camera.global_transform.origin) < max_zoom:
					$Camera.global_transform.origin += processed_speed
			BUTTON_WHEEL_UP:
				if global_transform.origin.distance_to($Camera.global_transform.origin) > min_zoom:
					$Camera.global_transform.origin -= processed_speed
	
	# Rotate
	if event is InputEventMouseButton and event.button_index == BUTTON_MIDDLE:
		is_middle_pressed = event.is_pressed()
	
	if event is InputEventMouseMotion and is_middle_pressed:
		rotate_y(deg2rad(-event.relative.x * speed))
