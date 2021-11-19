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

func _on_Heberger_pressed():
	$Attente.show()
	$AnimationMenu.play("AnimationMenu")
	start_game(true)

func _on_Quitter_pressed():
	get_tree().quit()

func _on_Connexion_pressed():
	if($RejoindreContainer/IpField != null):
		Network.IPClient = $RejoindreContainer/IpField.text
		start_game(false)

func start_game(as_server):
	pass
	Network.start(as_server)

	yield(Network, "game_ready")

	var players_ids = Network.map_id_with_player.keys()
	if(get_tree().is_network_server()):
		print("Create Serveur scene")
		get_tree().change_scene("res://Scenes/Map/Cockpit.tscn")
	else: 
		print("Create Client scene")                  
		get_tree().change_scene("res://Scenes/Map/Vaisseau.tscn")
