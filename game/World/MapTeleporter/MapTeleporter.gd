extends Area

export (String) var map

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_body_entered(body):
	print("MapTeleporter::_on_body_entered")
	if body is Player:
		$Timer.start()

func _on_body_exited(body):
	print("MapTeleporter::_on_body_exited")
	if body is Player:
		$Timer.stop()

func load_level():
	pass # Replace with function body.
