extends Node

##const RPC_PORT = 8000
##const MAX_PLAYER = 2
##const OFFLINE_TESTING = false
##
##var IPClient = "localhost"
var net_id = null
##var is_host = false
var peer_ids = []
##
##func initialize_server():
##	is_host = true
##	var peer = NetworkedMultiplayerENet.new()
##	peer.create_server(RPC_PORT, MAX_PLAYER)
##	get_tree().network_peer = peer
##
##func initialize_client(server_ip):
##	server_ip = IPClient
##	var peer = NetworkedMultiplayerENet.new()
##	peer.create_client(server_ip, RPC_PORT)
##	get_tree().network_peer = peer

func set_ids():
	net_id = get_tree().get_network_unique_id()
	peer_ids = get_tree().get_network_connected_peers()

var is_server
var IPClient = "localhost"

var map_id_with_player = {}
var player_pack = preload("res://Scenes/Player/Player.tscn")

const MAX_PLAYER_COUNT = 2
var players_ready_count = 0

signal game_ready

func start(as_server):
	is_server = as_server
	var peer = NetworkedMultiplayerENet.new()

	if is_server:
		peer.create_server(8000, MAX_PLAYER_COUNT)
		create_player(1)
	else:
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
