extends Node

var is_server

func start(as_server = false):
	is_server = as_server
	
	var peer = NetworkedMultiplayerENet.new()
	
	if is_server:
		peer.create_server(8000, 1)
		print("server create")
	else:
		peer.create_client("localhost", 8000) #Changer localhost par IP
	
	get_tree().network_peer = peer
	get_tree().connect("connected_to_server", self, "_on_connected_to_server")
	get_tree().connect("connection_failed", self, "_on_connection_failed")
	get_tree().connect("network_peer_connected", self, "_on_network_peer_connected")
	get_tree().connect("server_disconnected", self, "_on_server_disconnected")

func _on_connected_to_server():
	print("connected to server")

func _on_connection_failed():
	print("Connexion failed")

func _on_network_peer_connected(id):
	print("peer connected " + str(id))

func _on_server_disconnected():
	print("server disconnected ")
	get_tree().network_peer = null
