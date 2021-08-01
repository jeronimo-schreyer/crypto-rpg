extends "res://core/State.gd"

var patrol_points : PoolVector3Array
var patrol_index : int

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func enter():
	patrol_points = character.patrol_circuit.get_baked_points()
	Global.draw_floor_debug_line(patrol_points)

func exit():
	pass

func process(_delta):
	# Movement
	var direction = (patrol_points[patrol_index] - character.global_transform.origin).normalized()
	
	# warning-ignore: return_value_discarded
	character.move_and_slide(direction * character.speed)
	character.look_at(patrol_points[patrol_index], Vector3.UP)
	
	if character.global_transform.origin.distance_to(patrol_points[patrol_index]) < 1.0:
		patrol_index = (patrol_index + 1) % patrol_points.size()
	
	# Check if enemy is facing player
	var direction_to_player = character.transform.origin.direction_to(Global.player.transform.origin)
	if  direction_to_player.dot(character.transform.basis.z) < -0.5 \
	and character.global_transform.origin.distance_to(Global.player.transform.origin) < character.max_view_distance:
		switch_state("Follow")
