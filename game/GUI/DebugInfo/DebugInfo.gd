extends MarginContainer

const B_TO_MB = pow(1024, 2)

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = OS.is_debug_build()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	var info = """
	FPS: %.2f
	Process: %.2f ms
	Static Memory: %.2f MB
	"""
#	CPU Time: %.1f
#	GPU Time: %.1f

	$Label.text = info % [
		Performance.get_monitor(Performance.TIME_FPS),
		Performance.get_monitor(Performance.TIME_PROCESS),
		OS.get_static_memory_usage() / B_TO_MB,
	]
