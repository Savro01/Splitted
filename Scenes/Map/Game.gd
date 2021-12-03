extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var CommandantCree = false
var code = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	#Network.set_ids()
	create_play()
	rpc("set_code_porte",code)
#
#func create_players():
#	for id in Network.peer_ids:
#		create_play(id)
	#create_play(Network.net_id)

func create_play():
	var players_ids = Network.map_id_with_player.keys()
	players_ids.sort()

	for id in players_ids:
		var player = Network.map_id_with_player[id]
		if(get_tree().is_network_server() and !CommandantCree):
			if(player.get_node("BodyElectricien") != null):
				player.get_node("BodyElectricien").visible = false
			get_node("Cockpit/Player").add_child(player)
			CommandantCree = true
		else:
			player.get_node("BodyCommandant").visible = false
			get_node("Vaisseau/Player").add_child(player)

#remote func set_code_porte(code):
#	rpc("R.set_code_porte_soute",code)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
