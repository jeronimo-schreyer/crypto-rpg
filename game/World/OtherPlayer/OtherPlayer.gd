extends KinematicBody

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

puppet func update_transform(xform : Transform):
	transform = transform.interpolate_with(xform, 0.5)
