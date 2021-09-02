extends Control

signal finished

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_Enter_pressed():
	var addr = $Address.text
	#var display_name = $Name.text
	
	if addr == "0.0.0.0":
		var s = load("res://Network/Server.tscn") as PackedScene
		var server = s.instance()
		Global.add_child(server)
		
		server.listen()
		_on_client_connected()
	else:
		var c = load("res://Network/Client.tscn") as PackedScene
		var client = c.instance()
		Global.add_child(client)
		
		# warning-ignore: return_value_discarded
		client.connect("client_connected", self, "_on_client_connected")
		client.connect_to_url(addr)

func _on_tree_entered():
	get_tree().paused = true

func _on_client_connected():
	get_tree().paused = false
	emit_signal("finished")
