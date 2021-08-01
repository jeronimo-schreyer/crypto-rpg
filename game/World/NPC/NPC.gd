extends "res://Core/Character.gd"
class_name NPC

# are you?
var talking_to_me = false

# Called when the node enters the scene tree for the first time.
func _ready():
	# warning-ignore: return_value_discarded
	Events.connect("talk_to", self, "on_talk_to")

func get_class():
	return "NPC"

func on_talk_to(npc):
	if npc == self:
		talking_to_me = true
		Events.emit_signal("open_shop", self)

func _on_body_exited(body):
	if body is Player and talking_to_me:
		talking_to_me = false
		Events.emit_signal("close_shop")
