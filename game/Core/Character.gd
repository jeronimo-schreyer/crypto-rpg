extends CollisionObject
class_name Character

# Called when the node enters the scene tree for the first time.
func _ready():
	# warning-ignore: return_value_discarded
	connect("input_event", self, "_on_input_event")
	# warning-ignore: return_value_discarded
	connect("mouse_entered", self, "_on_mouse_entered")
	# warning-ignore: return_value_discarded
	connect("mouse_exited", self, "_on_mouse_exited")

func _on_input_event(_camera, event, _click_position, _click_normal, _shape_idx):
	if event is InputEventMouseButton and event.is_pressed():
		match event.button_index:
#			BUTTON_LEFT:
#				pass
			BUTTON_RIGHT:
				Events.emit_signal("target_character", self)
				Events.emit_signal("move", global_transform.origin)

func _on_mouse_entered():
	Events.emit_signal("info", "Ese es %s" % name)

func _on_mouse_exited():
	Events.emit_signal("info", "")
