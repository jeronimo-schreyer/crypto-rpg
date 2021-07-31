extends "res://core/State.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func enter():
	print("Moving::enter")

func process(_delta):
	if character.path_to_target.size() > character.path_index:
		var direction = (character.path_to_target[character.path_index] - character.global_transform.origin).normalized()
		
		# warning-ignore: return_value_discarded
		character.move_and_slide(direction * character.speed)
		
		if character.global_transform.origin.distance_to(character.path_to_target[character.path_index]) < 1.0:
			character.path_index += 1
	else:
		switch_state("Idle")
