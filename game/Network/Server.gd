extends Node

export (X509Certificate) var ssl_certificate
export (CryptoKey) var ssl_certificate_key

var ws_server : WebSocketServer
var clients : Dictionary


func _init():
	ws_server = WebSocketServer.new()
	# warning-ignore: return_value_discarded
	ws_server.connect("client_close_request", self, "on_client_close_request")
	
	# warning-ignore: return_value_discarded
	ws_server.connect("peer_connected", self, "on_peer_connected")
	# warning-ignore: return_value_discarded
	ws_server.connect("peer_disconnected", self, "on_peer_disconnected")

func _process(_delta):
	if ws_server.is_listening():
		ws_server.poll()

func listen(port=8008, supported_protocols=[], use_ssl=false):
	if use_ssl:
		ws_server.private_key = ssl_certificate_key
		ws_server.ssl_certificate = ssl_certificate
	
	var res = ws_server.listen(int(port), supported_protocols, true)
	if res != OK:
		printerr("Server::listen - failed to listen to port %d" % int(port))
		return
	
	get_tree().network_peer = ws_server

func set_write_mode(mode):
	for client in clients:
		clients[client].set_write_mode(mode)

func on_client_close_request(id, code, reason=""):
	print("Server::on_client_close_request - %d %d: %s" % [id, code, "No Reason" if reason.empty() else reason])

func on_peer_connected(peer_id):
	clients[peer_id] = ws_server.get_peer(peer_id)
	clients[peer_id].set_write_mode(WebSocketPeer.WRITE_MODE_BINARY)
	Events.emit_signal("peer_connected", peer_id)

func on_peer_disconnected(peer_id):
	# warning-ignore: return_value_discarded
	clients.erase(peer_id)
	Events.emit_signal("peer_disconnected", peer_id)

remote func ping():
	rpc_id(get_tree().get_rpc_sender_id(), "pong")
