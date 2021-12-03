extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var currentArea

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
#	currentArea = null
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match currentArea:
		"ZonePilotage":
			if Input.is_action_pressed("object_interact"):
				if $Popup.visible == false:
					var v = $Player.get_position()
					$Popup.set_position(v)
					$Popup.show()
					$Player.speed = 0
			if Input.is_action_pressed("ui_cancel"):
				if $Popup.visible:
					$Popup.hide()
					$Player.speed = 100
		"ZoneLivre":
			if Input.is_action_pressed("object_interact"):
				if($PopupNotebook.visible == false):
					var v = $Player.get_child(0).get_global_position() - $PopupNotebook.get_rect().size/2
					$PopupNotebook.set_global_position(v)
					R.rng.randomize()
					var code = R.rng.randi_range(1000, 9999)
					$PopupNotebook/LabelTechnique.text = $PopupNotebook/LabelTechnique.text + str(code)
#					change_code_porte(code)
					$PopupNotebook.popup()
					$Player.get_child(0).speed = 0
			if Input.is_action_pressed("ui_cancel"):
				print("Echap pressed")
				if $PopupNotebook.visible:
					print("Popup visible")
					$Popup.hide()
					$Player.get_child(0).speed = 100

# Body Entered

func _on_ZonePilotage_body_entered(body):
	if(body is Player):
		currentArea = "ZonePilotage"

func _on_ZoneLivre_body_entered(body):
	if(body is Player):
		currentArea = "ZoneLivre"


# Body Exited

func _on_ZonePilotage_body_exited(body):
	if(body is Player):
		currentArea = null
		print("sortie pilotage")
		print(R.code_porte_soute)
		rpc("change")

remote func change():
	R.change_test_com()

#remote func change_code_porte(code):
#	print(code)
#	R.set_code_porte_soute(code)

func _on_ZoneLivre_body_exited(body):
	if(body is Player):
		currentArea = null
		print("sortie livre")
	
