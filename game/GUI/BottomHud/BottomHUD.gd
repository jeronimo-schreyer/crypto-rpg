extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	# warning-ignore: return_value_discarded
	Events.connect("info", self, "on_info")
	# warning-ignore: return_value_discarded
	Events.connect("hit", self, "on_hitted")

func on_hitted(character, damage):
	if character == Global.player:
		$Panel/Life/TextureProgress.value -= damage

func on_info(message):
	$Panel/Info/Label.text = message
