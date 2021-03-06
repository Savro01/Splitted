extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var CommandantCree = false
var rng = RandomNumberGenerator.new()
remotesync var code_porte = 0
remotesync var electriciteRepare = false

remotesync var tabFils = ["Bleu", "Rose", "Jaune", "Rouge"]
remotesync var colorPick = ["bleu", "rouge", "vert", "rose", "orange"]
remotesync var order = ["fd0100", "f76915", "eede04", "a0d636", "f79cee", "333ed4"]

remotesync var button_com = false
remotesync var button_elec = false
var tabmelange = false
var codeGenere = false
var colorGenere = false

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
		$AudioStreamPlayer.play(2)


func _on_Cockpit_change_code_porte():
	rng.randomize()
	var code = rng.randi_range(1000, 9999)
	$Cockpit.popupNotebook(code, codeGenere)
	rpc("set_code_porte", code)
	set_code_porte(code)

remote func set_code_porte(code):
	if (!codeGenere):
		code_porte = code
		codeGenere = true

func _on_Vaisseau_electricite_changed():
	rpc("changed_electricite")
	changed_electricite()

remote func changed_electricite():
	electriciteRepare = true
	
############# Electricity Fils 
	
func _on_Cockpit_change_tab_fils():
	var tab = tabFils
	if(!tabmelange):
		randomize()
		tab.shuffle()
		$Cockpit.popupCarnetSpirale(tab, tabmelange)
		rpc("set_tab_fils", tab)
		set_tab_fils(tab)
	else:
		$Cockpit.popupCarnetSpirale(tab, tabmelange)

remote func set_tab_fils(tab):
	if(!tabmelange):
		tabFils = tab
		tabmelange = true
		
		
############# File Transert

func _on_Vaisseau_file_transfert_changed():
	var tab = colorPick
	if(!colorGenere):
		randomize()
		tab.shuffle()
		$Vaisseau.popupColorPicker(tab, colorGenere)
		rpc("set_tab_colorPick", tab)
		set_tab_colorPick(tab)
	else:
		$Vaisseau.popupColorPicker(tab, colorGenere)

remote func set_tab_colorPick(tab):
	if(!colorGenere):
		colorPick = tab
		rpc("setOrder")
		setOrder()
		colorGenere = true

func _on_Cockpit_button_com_pressed():
	rpc("button_com_true")
	button_com_true()

remote func button_com_true():
	button_com = true
	if (button_elec == true):
		rpc("change_scene_final")
		change_scene_final()

func _on_Cockpit_button_com_unpressed():
	rpc("button_com_false")
	button_com_false()

remote func button_com_false():
	button_com = false

func _on_Vaisseau_button_elec_pressed():
	rpc("button_elec_true")
	button_elec_true()

remote func button_elec_true():
	button_elec = true
	if (button_com == true):
		rpc("change_scene_final")
		change_scene_final()

func _on_Vaisseau_button_elec_unpressed():
	rpc("button_elec_false")
	button_elec_false()

remote func button_elec_false():
	button_elec = false

remote func change_scene_final():
	get_tree().change_scene("res://Scenes/FinalScene.tscn")

remote func setOrder():
	var tab = colorPick
	
	var value = tab[0]
	print(value)
	var newOrder = order
	
	if(value == "bleu"):
		newOrder =  ["333ed4", "a0d636", "eede04", "f76915", "fd0100", "f79cee"]
	if(value == "rose"):
		newOrder = ["f79cee", "a0d636", "eede04", "f76915", "fd0100", "333ed4"]
	if(value == "rouge"):
		newOrder =  ["fd0100", "f76915", "eede04", "a0d636", "f79cee", "333ed4"]
	if(value == "orange"):
		newOrder =  ["f76915", "f79cee", "a0d636", "eede04", "333ed4", "fd0100"]
	if(value == "vert"):
		newOrder = ["a0d636", "f76915", "f79cee", "333ed4", "fd0100", "eede04"]
	
	order = newOrder
	print(newOrder)
