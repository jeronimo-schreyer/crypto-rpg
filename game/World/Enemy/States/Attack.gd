extends "res://core/State.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func enter():
	$Timer.start()

func exit():
	$Timer.stop()

func process(_delta):
	if character.transform.origin.distance_to(Global.player.transform.origin) > 2.1:
		switch_state("Follow")

func _on_timeout():
	Events.emit_signal("hit", Global.player, 50)
