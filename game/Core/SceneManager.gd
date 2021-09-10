extends Node

signal progress(value)
signal finished(resource)
signal error(err)

onready var loader : ResourceInteractiveLoader
var current : Node

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var poll = loader.poll()
	match poll:
		OK: 
			emit_signal("progress", float(loader.get_stage()) / loader.get_stage_count())
		
		ERR_FILE_EOF:
			emit_signal("finished", loader.get_resource())
			set_process(false)
			switch_scene(loader.get_resource())
		
		_:
			emit_signal("error", poll)
			set_process(false)

func load_scene(path):
	loader = ResourceLoader.load_interactive(path)
	set_process(true)

func switch_scene(new_scene):
	if is_instance_valid(current):
		current.queue_free()
	current = new_scene.instance()
	get_tree().get_root().add_child(current)
