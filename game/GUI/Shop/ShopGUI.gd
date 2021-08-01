extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	
	# warning-ignore: return_value_discarded
	Events.connect("open_shop", self, "on_open_shop")
	# warning-ignore: return_value_discarded
	Events.connect("close_shop", self, "on_close_shop")

func on_open_shop(_npc):
	show()

func on_close_shop():
	hide()
