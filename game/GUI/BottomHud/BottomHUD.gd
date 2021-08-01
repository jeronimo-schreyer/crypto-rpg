extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	# warning-ignore: return_value_discarded
	Events.connect("character_info", self, "on_character_info")
	# warning-ignore: return_value_discarded
	Events.connect("hit", self, "on_hitted")

func on_hitted(character, damage):
	if character == Global.player:
		$Panel/Life/TextureProgress.value -= damage

func on_character_info(character):
	if character:
		$Panel/Info/Label.text = "Ese es %s" % character.name
	else:
		$Panel/Info/Label.text = ""
