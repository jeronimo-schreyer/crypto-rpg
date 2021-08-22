extends Resource
class_name ConsumableItem

export (String) var uuid
export (String) var image setget set_texture
export (Dictionary) var effects

var texture : Texture

func set_texture(path : String):
	texture = load(path) as Texture
