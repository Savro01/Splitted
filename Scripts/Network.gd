extends Node

var is_server
var IPClient = "localhost"

var map_id_with_player = {}
var player_pack = preload("res://Scenes/Player/Player.tscn")

const MAX_PLAYER_COUNT = 2
var players_ready_count = 0

signal game_ready

func start(as_server):
	is_server = as_server
	print(is_server)
	var peer = NetworkedMultiplayerENet.new()

	if is_server:
		print("Creation serveur + player 1")
		peer.create_server(8000, MAX_PLAYER_COUNT)
		create_player(1)
	else:
		print("Création client)")
		peer.create_client(IPClient, 8000) #Changer localhost par IP

	get_tree().network_peer = peer
	get_tree().connect("connected_to_server", self, "_on_connected_to_server")
	get_tree().connect("connection_failed", self, "_on_connection_failed")
	get_tree().connect("network_peer_connected", self, "_on_network_peer_connected")
	get_tree().connect("server_disconnected", self, "_on_server_disconnected")

func create_player(id):
	var player = player_pack.instance()
	player.name = str(id)
	player.set_network_master(id)
	map_id_with_player[id] = player
	if get_tree().network_peer:
		rpc_id(1, "new_player_add", map_id_with_player.size())

remotesync func new_player_add(player_count):
	if MAX_PLAYER_COUNT >= player_count:
		players_ready_count += 1
	if players_ready_count == MAX_PLAYER_COUNT:
		rpc("emit_game_ready")

remotesync func emit_game_ready():
	emit_signal("game_ready")

func _on_connected_to_server():
	print("connected to server")

func _on_connection_failed():
	print("Connexion failed")

func _on_network_peer_connected(id):
	print("peer connected " + str(id))
	create_player(id)

func _on_server_disconnected():
	print("server disconnected ")
	get_tree().network_peer = null
