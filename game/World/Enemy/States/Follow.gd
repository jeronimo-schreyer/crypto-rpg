extends "res://core/State.gd"

var path_to_target : PoolVector3Array
var path_index : int

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func enter():
	print("Follow::enter")
	_on_timeout()
	$Timer.start()

func exit():
	print("Follow::exit")
	$Timer.stop()

func process(_delta):
	if character.transform.origin.distance_to(Global.player.transform.origin) <= 2.5:
		switch_state("Attack")
	else:
		if path_to_target.size() > path_index:
			var direction = (path_to_target[path_index] - character.global_transform.origin).normalized()
			
			# warning-ignore: return_value_discarded
			character.move_and_slide(direction * character.speed)
			character.look_at(path_to_target[path_index], Vector3.UP)
			
			if character.transform.origin.distance_to(path_to_target[path_index]) < 2.0:
				path_index += 1

func _on_timeout():
	if character.global_transform.origin.distance_to(Global.player.transform.origin) < character.max_view_distance:
		path_index = 0
		path_to_target = Global.get_floor_path(character.transform.origin, Global.player.transform.origin)
	else:
		switch_state("Idle")
