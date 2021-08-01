extends CollisionObject
class_name Character

# Called when the node enters the scene tree for the first time.
func _ready():
	# warning-ignore: return_value_discarded
	connect("input_event", self, "_on_input_event")

func _on_input_event(_camera, event, _click_position, _click_normal, _shape_idx):
	if event is InputEventMouseButton and event.is_pressed():
		match event.button_index:
			BUTTON_LEFT:
				print("Get information of ", name)
			BUTTON_RIGHT:
				Events.emit_signal("target_character", self)
				Events.emit_signal("move", global_transform.origin)
