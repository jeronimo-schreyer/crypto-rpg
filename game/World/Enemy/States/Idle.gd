extends "res://core/State.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func enter():
	$Timer.start()

func exit():
	pass

func _on_timeout():
	switch_state("Patrol")
