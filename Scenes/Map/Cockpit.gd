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
				$Popup.hide()
				$Player.speed = 100
		"ZoneCarnet":
			if Input.is_action_pressed("object_interact"):
				if($PopupCarnetSpirale.visible == false):
					var v = $Player.get_child(0).get_global_position() - $PopupCarnetSpirale.get_rect().size/2
					$PopupCarnetSpirale.set_global_position(v)
					change_tab_fils()
			if Input.is_action_pressed("ui_cancel"):
				$PopupCarnetSpirale.hide()
				$Player.get_child(0).speed = 100			
		"ZoneLivre":
			if Input.is_action_pressed("object_interact"):
				if($PopupCarnetSpirale.visible == false):
					var v = $Player.get_child(0).get_global_position() - $PopupCarnetSpirale.get_rect().size/2
					$PopupNotebook.set_global_position(v)
					change_code_porte()
			if Input.is_action_pressed("ui_cancel"):
				$PopupNotebook.hide()
				$Player.get_child(0).speed = 100

############################################ Gestion des Zones ############################################
# Body Entered

func _on_ZonePilotage_body_entered(body):
	if(body is Player):
		currentArea = "ZonePilotage"

func _on_ZoneLivre_body_entered(body):
	if(body is Player):
		currentArea = "ZoneLivre"

func _on_ZoneCarnet_body_entered(body):
	if(body is Player):
		currentArea = "ZoneCarnet"

# Body Exited

func _on_ZonePilotage_body_exited(body):
	if(body is Player):
		currentArea = null
		print("sortie pilotage")

func _on_ZoneLivre_body_exited(body):
	if(body is Player):
		currentArea = null
		print("sortie livre")

func _on_ZoneCarnet_body_exited(body):
	if(body is Player):
		currentArea = null
############################################ Gestion des signaux ############################################

signal change_code_porte
func change_code_porte():
	emit_signal("change_code_porte")

signal change_tab_fils
func change_tab_fils():
	emit_signal("change_tab_fils")

############################################ Gestion des fonctions annexes ############################################

func popupNotebook(code, codeGenere):
	if(!codeGenere):
		$PopupNotebook/LabelTechnique.text = $PopupNotebook/LabelTechnique.text + str(code)
	$PopupNotebook.popup()
	$Player.get_child(0).speed = 0

func popupCarnetSpirale(tab, melange):
	if(!melange):
		for i in range(len(tab)):
			$PopupCarnetSpirale/LabelFils.text = $PopupCarnetSpirale/LabelFils.text + tab[i] + " "
			if (i == 0):
				$PopupCarnetSpirale/LabelFils.text = $PopupCarnetSpirale/LabelFils.text + "\n"
	$PopupCarnetSpirale.popup() 
	print(tab)
	$Player.get_child(0).speed = 0
