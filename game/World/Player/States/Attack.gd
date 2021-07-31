extends "res://core/State.gd"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func enter():
	print("Attack::enter")
	$Timer.start()

func exit():
	$Timer.stop()

func _on_timeout():
	Events.emit_signal("hit", character.target, 50)
