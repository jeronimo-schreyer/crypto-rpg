extends Spatial

var other_player = preload("res://World/OtherPlayer/OtherPlayer.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	# warning-ignore: return_value_discarded
	Events.connect("peer_connected", self, "_on_peer_connected")
	# warning-ignore: return_value_discarded
	Events.connect("peer_disconnected", self, "_on_peer_disconnected")
	
	setup()

func _on_peer_connected(peer_id):
	print("peer connected ", peer_id)
	var new_player = other_player.instance()
	new_player.name = str(peer_id)
	new_player.set_network_master(peer_id)
	add_child(new_player)

func _on_peer_disconnected(peer_id):
	print("peer disconnected ", peer_id)

func setup():
	var peer_id = get_tree().get_network_unique_id()
	$Player.set_network_master(peer_id)
	$Player.name = str(peer_id)
