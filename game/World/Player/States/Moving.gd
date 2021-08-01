extends "res://Core/State.gd"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func enter():
	character.animation.travel("Walk")
	if character.target:
		$Timer.start()

func exit():
	if !$Timer.is_stopped():
		$Timer.stop()

func process(_delta):
	if character.path_to_target.size() > character.path_index:
		var direction = (character.path_to_target[character.path_index] - character.global_transform.origin).normalized()
		
		# warning-ignore: return_value_discarded
		character.move_and_slide(direction * character.speed)
		character.look_at(character.path_to_target[character.path_index], Vector3.UP)
		
		if character.global_transform.origin.distance_to(character.path_to_target[character.path_index]) < 1.0:
			character.path_index += 1
	else:
		switch_state("Idle")

func _on_timeout():
	if character.target:
		character.path_index = 0
		character.path_to_target = Global.get_floor_path(character.transform.origin, character.target.transform.origin)
	else:
		$Timer.stop()
