extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	# warning-ignore: return_value_discarded
	Events.connect("info", self, "on_info")
	# warning-ignore: return_value_discarded
	Events.connect("hit", self, "on_hitted")
	# warning-ignore: return_value_discarded
	Events.connect("player_stat", self, "on_player_stat")

func on_hitted(character, damage):
	if character == Global.player:
		$Panel/Life/TextureProgress.value -= damage

func on_info(message):
	$Panel/Info/Label.text = message

func on_player_stat(stat, value):
	match stat:
		"hp":
			$Panel/Life/TextureProgress.value += value
		"mp":
			$Panel/Magic/TextureProgress.value += value

func _on_Magic_mouse_entered():
	Events.emit_signal("info", "Magic Points: %d / %d" % [$Panel/Magic/TextureProgress.value, $Panel/Magic/TextureProgress.max_value])

func _on_Life_mouse_entered():
	Events.emit_signal("info", "Health Points: %d / %d" % [$Panel/Life/TextureProgress.value, $Panel/Life/TextureProgress.max_value])

func _on_Menu_mouse_entered():
	Events.emit_signal("info", "View Game Menu and Settings")

func _on_Character_mouse_entered():
	Events.emit_signal("info", "View Character Statistics")

func _on_button_mouse_exited():
	Events.emit_signal("info", "")
