extends "res://Core/State.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func enter():
	character.animation.travel("Idle")
