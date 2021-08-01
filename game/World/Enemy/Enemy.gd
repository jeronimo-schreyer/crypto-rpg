extends "res://Core/Character.gd"
class_name Enemy

export (Curve3D) var patrol_circuit
export (float) var speed
export (float) var max_view_distance

# Called when the node enters the scene tree for the first time.
func _ready():
	# warning-ignore: return_value_discarded
	Events.connect("hit", self, "on_hitted")

func get_class():
	return "Enemy"

func on_hitted(character, damage):
	if character == self:
		print("Has golpeado a %s y le quitaste %d vida" % [name, damage])
		$States.switch_state("Attack")
