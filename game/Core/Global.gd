extends Node

var player : KinematicBody
var floor_instance : Floor

onready var items : Dictionary

var network : Node setget , get_network

func _init():
	for i in get_files_recursively("res://Items", "tres"):
		var item = load(i) as ConsumableItem
		items[item.uuid] = item

func get_floor_path(origin : Vector3, destination : Vector3) -> PoolVector3Array:
	assert(floor_instance)
	return floor_instance.get_nav_path(origin, destination)

func draw_floor_debug_line(path):
	assert(floor_instance)
	return floor_instance.draw_debug_line(path)

func get_files_recursively(path : String, type = []) -> PoolStringArray:
	var files : PoolStringArray = []
	var dir = Directory.new()
	assert( dir.open(path) == OK )
	assert( dir.list_dir_begin(true, true) == OK )
	
	var next = dir.get_next()
	while !next.empty():
			if dir.current_is_dir():
				files += get_files_recursively("%s/%s" % [dir.get_current_dir(), next], type)
			else:
				if type.empty() or next.rsplit(".", true, 1)[1] in type:
					files.append("%s/%s" % [dir.get_current_dir(), next])
			next = dir.get_next()
	
	dir.list_dir_end()
	return files

func get_network() -> Node:
	# this node should be added by Client.gd or Server.gd
	if has_node("Network"):
		return get_node("Network")
	return null
