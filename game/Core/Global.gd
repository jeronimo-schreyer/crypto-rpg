extends Node

var player : KinematicBody
var floor_instance : Floor

onready var items : Dictionary

func _ready():
	for i in ProjectSettings.get("items/potions/list"):
		var id = i.id
		i.erase("id")
		i.image = load(i.image)
		items[id] = i

func get_floor_path(origin : Vector3, destination : Vector3) -> PoolVector3Array:
	assert(floor_instance)
	return floor_instance.get_nav_path(origin, destination)

func draw_floor_debug_line(path):
	assert(floor_instance)
	return floor_instance.draw_debug_line(path)
