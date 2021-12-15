extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

#signal set_connect_type

func updateFullScreenBtn():
	if(OS.window_fullscreen):
		$OptionsContainer/Fullscreen.text = "Windowed"
	else:
		$OptionsContainer/Fullscreen.text = "Fullscreen"
	
# Called when the node enters the scene tree for the first time.
func _ready():
		updateFullScreenBtn()
		
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $RejoindreContainer.visible and Input.is_action_pressed("ui_cancel"):
		backToMenu($RejoindreContainer)
		
	if $Attente.visible and Input.is_action_pressed("ui_cancel"):
		backToMenu($Attente)
		
	if $OptionsContainer.visible and Input.is_action_pressed("ui_cancel"):
		backToMenu($OptionsContainer)

func _on_Rejoindre_pressed():
	$RejoindreContainer.show()
	$AnimationMenu.play("AnimationMenu")

func _on_Heberger_pressed():
	$Attente.show()
	$AnimationMenu.play("AnimationMenu")
	#Network.initialize_server()
	#emit_signal("set_connect_type", true)
	start_game(true)

func _on_Quitter_pressed():
	get_tree().quit()
	
func _on_Options_pressed():
	$OptionsContainer.show()
	$AnimationMenu.play("AnimationMenu")
	

func _on_Fullscreen_pressed():
	OS.window_fullscreen = !OS.window_fullscreen
	updateFullScreenBtn()
	if(!OS.window_fullscreen):
		OS.set_window_size(Vector2(820,480))
	

func _on_Connexion_pressed():
	if($RejoindreContainer/IpField != null):
		Network.IPClient = $RejoindreContainer/IpField.text
		#Network.initialize_client($RejoindreContainer/IpField.text)
		#emit_signal("set_connect_type", false)
		start_game(false)

#func connected():
#	if not Network.is_host:
#		rpc("begin game")
#		begin_game()
#
#remote func begin_game():
#	get_tree().change_scene("res://Scenes/Map/Game.tscn")





func start_game(as_server):
	pass
	Network.start(as_server)

	yield(Network, "game_ready")
	print("Game Ready")
	get_tree().change_scene("res://Scenes/Map/Game.tscn")



func backToMenu(obj):
	if obj.visible:
		$AnimationMenu.play_backwards("AnimationMenu")
		var t = Timer.new()
		t.set_wait_time(1)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		obj.hide()


func _on_Retour_pressed():
	backToMenu($OptionsContainer)
