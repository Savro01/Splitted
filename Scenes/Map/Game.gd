extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var CommandantCree = false
remotesync var code_porte = 0
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	#Network.set_ids()
	create_play()

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

func _on_Cockpit_change_code_porte():
	print("Signal recu")
	rng.randomize()
	var code = rng.randi_range(1000, 9999)
	$Cockpit.popupNotebook(code)
	rpc("set_code_porte", code)

remote func set_code_porte(code):
	print(code)
	if (code_porte == 0):
		code_porte = code

#remote func set_code_porte(code):
#	rpc("R.set_code_porte_soute",code)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


