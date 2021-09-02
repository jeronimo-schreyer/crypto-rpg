extends Node

signal client_connected

export (X509Certificate) var ssl_certificate

onready var os = OS.get_name()

var ws_client : WebSocketClient


func _init():
	ws_client = WebSocketClient.new()
	# warning-ignore: return_value_discarded
	ws_client.connect("server_close_request", self, "on_client_close_request")
	# warning-ignore: return_value_discarded
	ws_client.connect("connection_closed", self, "on_server_connection_closed")
	# warning-ignore: return_value_discarded
	ws_client.connect("server_disconnected", self, "on_server_disconnected")
	# warning-ignore: return_value_discarded
	ws_client.connect("connection_succeeded", self, "on_client_connection_succeeded")
	
	
	# warning-ignore: return_value_discarded
	ws_client.connect("peer_connected", self, "on_peer_connected")
	# warning-ignore: return_value_discarded
	ws_client.connect("peer_disconnected", self, "on_peer_disconnected")

func _process(_delta):
	if is_connected_to_server():
		if os != "HTML5":
			ws_client.poll()

func is_connected_to_server():
	return ws_client.get_connection_status() == ws_client.CONNECTION_CONNECTED

func disconnect_from_host():
	ws_client.disconnect_from_host(1000, "Bye bye!")

func connect_to_url(host, port=8008, protocols=[], use_ssl=false):
	var ws_protocol = "wss" if use_ssl else "ws"
	if use_ssl:
		if os != "HTML5":
			ws_client.trusted_ssl_certificate = ssl_certificate
	
	var address = "%s://%s:%d" % [ws_protocol, host, port]
	assert(ws_client.connect_to_url(address, protocols, true) == OK)
	get_tree().network_peer = ws_client

# use this two functions to keep the connection alive
remote func pong():
	pass#print("%d responded the ping request" % get_tree().get_rpc_sender_id())

func _on_Ping_timeout():
	rpc("ping")

func on_peer_connected(peer_id):
	Events.emit_signal("peer_connected", peer_id)

func on_peer_disconnected(peer_id):
	Events.emit_signal("peer_disconnected", peer_id)

func on_client_close_request(code, reason):
	print("Closed connection - %d: %s" % [code, reason])

func on_server_disconnected():
	$Ping.stop()

func on_server_connection_closed(was_clean_close):
	print("Server connection closed - wasClean: ", was_clean_close)

func on_client_connection_succeeded():
	ws_client.get_peer(1).set_write_mode(WebSocketPeer.WRITE_MODE_BINARY)
	$Ping.start()
	emit_signal("client_connected")
