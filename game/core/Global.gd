extends Node

var player : KinematicBody
var floor_instance : Floor

func get_floor_path(origin : Vector3, destination : Vector3, show_debug) -> PoolVector3Array:
	assert(floor_instance)
	return floor_instance.get_nav_path(origin, destination, show_debug)
