extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $RejoindreContainer.visible and Input.is_action_pressed("ui_cancel"):
		$AnimationMenu.play_backwards("AnimationMenu")
		var t = Timer.new()
		t.set_wait_time(1)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		$RejoindreContainer.hide()
		
	if $Attente.visible and Input.is_action_pressed("ui_cancel"):
		$AnimationMenu.play_backwards("AnimationMenu")
		var t = Timer.new()
		t.set_wait_time(1)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		$Attente.hide()
	

func _on_Rejoindre_pressed():
	$RejoindreContainer.show()
	$AnimationMenu.play("AnimationMenu")
	Network.start(false)
	
		
		

func _on_Heberger_pressed():
	$Attente.show()
	$AnimationMenu.play("AnimationMenu")
	start_game(true)

func _on_Quitter_pressed():
	get_tree().quit()

func _on_Connexion_pressed():
	start_game(false)

func start_game(as_server):
	Network.start(as_server)
	
	yield(Network, "game_ready")
	
	var players_ids = Network.map_id_with_player.keys()
	players_ids.sort()
	for id in players_ids:
		var player = Network.map_id_with_player[id]
		if id == 1:
			get_node("Player/BodyElectricien").visible = false
			get_node("Cockpit").add_child(player)
		else:                   
			get_node("Player/BodyCommandant").visible = false
			get_node("Vaisseau").add_child(player)
			
