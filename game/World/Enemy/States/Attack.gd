extends "res://Core/State.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func enter():
	print("Attack::enter")
	$Timer.start()

func exit():
	print("Attack::exit")
	$Timer.stop()

func process(_delta):
	character.look_at(Global.player.transform.origin, Vector3.UP)
	if character.transform.origin.distance_to(Global.player.transform.origin) > 2.5:
		switch_state("Follow")

func _on_timeout():
	Events.emit_signal("hit", Global.player, 50)
