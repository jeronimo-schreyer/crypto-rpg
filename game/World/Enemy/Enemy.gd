extends "res://core/Character.gd"
class_name Enemy

# Called when the node enters the scene tree for the first time.
func _ready():
	# warning-ignore: return_value_discarded
	Events.connect("hit", self, "on_enemy_hitted")

func get_class():
	return "Enemy"

func on_enemy_hitted(enemy, damage):
	if enemy == self:
		print("Has golpeado a %s y le quitaste %d vida" % [name, damage])
