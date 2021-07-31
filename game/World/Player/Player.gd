extends KinematicBody
class_name Player

export (float) var speed

var target : Character
var path_to_target : PoolVector3Array
var path_index : int

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.player = self
	
	# warning-ignore: return_value_discarded
	Events.connect("move", self, "move_to")
	# warning-ignore: return_value_discarded
	Events.connect("target_character", self, "set_target")

func move_to(position):
	path_index = 0
	path_to_target = Global.get_floor_path(transform.origin, position)
	$States.switch_state("Moving")

func set_target(character):
	target = character

func _on_body_entered(body):
	if body == target:
		match target.get_class():
			"Enemy":
				$States.switch_state("Attack")
			"NPC":
				$States.switch_state("Talking")
				Events.emit_signal("talk_to", target)
