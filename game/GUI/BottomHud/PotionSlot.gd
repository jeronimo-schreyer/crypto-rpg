extends Control

var id = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_item(_id):
	if Global.items.has(_id):
		id = _id
		$Content/TextureRect.texture = Global.items[_id].texture
	else:
		clear()

func clear():
		$Content/TextureRect.texture = null
		id = ""

func _on_mouse_entered():
	if !id.empty():
		var effects = ""
		for e in Global.items[id].effects:
			effects += "%s: %+d\n" % [e, Global.items[id].effects[e]]
		
		Events.emit_signal("info", """%s
		%s""" % [
			Global.items[id].resource_name,
			effects.strip_edges()
		])

func _on_mouse_exited():
	if !id.empty():
		Events.emit_signal("info", "")

func _on_pressed():
	if !id.empty():
		for effect in Global.items[id].effects:
			Events.emit_signal("player_stat", effect, Global.items[id].effects[effect])
		clear()
		Events.emit_signal("info", "")
