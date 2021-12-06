extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var currentArea = null

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
					print("Enter Notebook")
					print($Player.get_child(0).get_global_position())
					print($PopupNotebook.get_rect().size/2)
					var v = $Player.get_child(0).get_global_position() - $PopupNotebook.get_rect().size/2
					$PopupNotebook.set_global_position(v)
					print($PopupNotebook.get_global_position())
					print(v)
					print($PopupNotebook.get_global_position())
					change_code_porte()
			if Input.is_action_pressed("ui_cancel"):
				print("Echap pressed")
				if ($PopupNotebook.visible == true):
					print("Popup visible")
					$Popup.hide()
					$Player.get_child(0).speed = 100

############################################ Gestion des Zones ############################################
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

func _on_ZoneLivre_body_exited(body):
	if(body is Player):
		currentArea = null
		print("sortie livre")

############################################ Gestion des signaux ############################################

signal change_code_porte
func change_code_porte():
	emit_signal("change_code_porte")


############################################ Gestion des fonctions annexes ############################################

func popupNotebook(code):
	print(code)
	$PopupNotebook/LabelTechnique.text = $PopupNotebook/LabelTechnique.text + str(code)
	$PopupNotebook.popup()
	$Player.get_child(0).speed = 0
