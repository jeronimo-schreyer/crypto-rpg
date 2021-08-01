extends "res://core/State.gd"

var is_active : bool

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func enter():
	if $Timer.is_stopped():
		$Timer.start()
	is_active = true

func exit():
	is_active = false

func _on_timeout():
	if is_active:
		Events.emit_signal("hit", character.target, 80)
	else:
		$Timer.stop()
