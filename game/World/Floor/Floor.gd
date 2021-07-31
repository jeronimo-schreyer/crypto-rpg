extends Navigation
class_name Floor

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.floor_instance = self

func _on_input_event(_camera, event, click_position, _click_normal, _shape_idx):
	if event is InputEventMouseButton and \
		event.is_pressed() and \
		event.button_index == 2:
			Events.emit_signal("target_character", null)
			Events.emit_signal("move", click_position)

func get_nav_path(origin, destination):
	var path = get_simple_path(origin, destination)
	if path.size() > 1:
		path.remove(0)
	
	return path
