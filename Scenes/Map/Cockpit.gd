extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var currentArea = null
var tabMorse = ["D\nA\nL\nE\nK\nS", "S\nO\nN\nT\nA\nR\nI\nE\nN\nS", "C\nY\nB\nE\nR\nM\nE\nN\nS"]
var boiteNoireDecoder = false
var shipAlign = false
var flechePressed = false
var transfert_win = false
#var imageButtonFinal = preload("res://Assets/Images/")

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	tabMorse.shuffle()
	get_parent().rng.randomize()
	var pos = get_parent().rng.randi_range(50, 495)
	$PopupPilotage/Fleche.rect_position.x = pos
	$PopupPilotage/Line.rect_position.x = pos + 16.5 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if (flechePressed):
		var mouse_pos = get_global_mouse_position().x
		var pos_arrowX = $PopupPilotage/Fleche.rect_position.x
		if(pos_arrowX >= 50 and pos_arrowX <= 495):
			var arrow_pos = $PopupPilotage/Fleche.get_global_position().y
			var line_pos = $PopupPilotage/Line.get_global_position().y
			var vect = Vector2(mouse_pos-$PopupPilotage/Fleche.rect_size.x/2, arrow_pos)
			$PopupPilotage/Fleche.set_global_position(vect)
			vect = Vector2(mouse_pos-$PopupPilotage/Line.rect_size.x/2, line_pos)
			$PopupPilotage/Line.set_global_position(vect)
			if($PopupPilotage/Line.rect_position.x > 285 and $PopupPilotage/Line.rect_position.x < 295):
				$PopupPilotage/Line.rect_position.x = 291.5
				$PopupPilotage/Fleche.rect_position.x = 275
				$PopupPilotage/Line.visible = false
				$PopupPilotage/LineGood.visible = true
				flechePressed = false
				shipAlign = true
				$Player.get_child(0).get_child(4).get_child(1).get_child(1).modulate = Color("5cf70e")
		elif(pos_arrowX > 495):
			flechePressed = false
			$PopupPilotage/Fleche.rect_position.x = 494
			$PopupPilotage/Line.rect_position.x = 510.5
		elif(pos_arrowX < 50):
			flechePressed = false
			$PopupPilotage/Fleche.rect_position.x = 51
			$PopupPilotage/Line.rect_position.x = 67.5
			
			
	match currentArea:
		"ZonePilotage":
			if Input.is_action_pressed("object_interact") :
				if($PopupPilotage.visible == false and get_parent().electriciteRepare):
					var v = $Player.get_child(0).get_global_position() - $PopupPilotage.get_rect().size/2
					$PopupPilotage.set_global_position(v)
					$Player.get_child(0).speed = 0
					$PopupPilotage.popup()
			if Input.is_action_pressed("ui_cancel"):
				$PopupPilotage.hide()
				$Player.get_child(0).speed = 100
		"ZoneCarnet":
			if Input.is_action_pressed("object_interact"):
				if($PopupCarnetSpirale.visible == false):
					var v = $Player.get_child(0).get_global_position() - $PopupCarnetSpirale.get_rect().size/2
					$PopupCarnetSpirale.set_global_position(v)
					$Player.get_child(0).speed = 0
					change_tab_fils()
			if Input.is_action_pressed("ui_cancel"):
				$PopupCarnetSpirale.hide()
				$Player.get_child(0).speed = 100
		"ZoneLivre":
			if Input.is_action_pressed("object_interact"):
				if($PopupCarnetSpirale.visible == false):
					var v = $Player.get_child(0).get_global_position() - $PopupCarnetSpirale.get_rect().size/2
					$PopupNotebook.set_global_position(v)
					$Player.get_child(0).speed = 0
					change_code_porte()
			if Input.is_action_pressed("ui_cancel"):
				$PopupNotebook.hide()
				$Player.get_child(0).speed = 100
		"ZoneBoiteNoire":
			if Input.is_action_pressed("object_interact"):
				if($PopupBoiteNoire.visible == false and get_parent().electriciteRepare):
					var v = $Player.get_child(0).get_global_position() - $PopupBoiteNoire.get_rect().size/2
					$PopupBoiteNoire.set_global_position(v)
					$PopupBoiteNoire/Panel/Label.text = tabMorse[0]
					$Player.get_child(0).speed = 0
					$PopupBoiteNoire.popup()
			if Input.is_action_pressed("ui_cancel"):
				$PopupBoiteNoire.hide()
				$Player.get_child(0).speed = 100
		"ZoneBouton":
			if Input.is_action_pressed("object_interact"):
				if($PopupBoutonCom.visible == false):
					var v = $Player.get_child(0).get_global_position() - $PopupBoutonCom.get_rect().size/2
					$PopupBoutonCom.set_global_position(v)
					$Player.get_child(0).speed = 0
					$PopupBoutonCom.popup()
			if Input.is_action_pressed("ui_cancel"):
				$PopupBoutonCom.hide()
				$Player.get_child(0).speed = 100
		"ZoneServerFile":
			if Input.is_action_pressed("object_interact"):
				if($PopupServerFile.visible == false and get_parent().electriciteRepare):
					var v = $Player.get_child(0).get_global_position() - $PopupServerFile.get_rect().size/2
					$PopupServerFile.set_global_position(v)
					$Player.get_child(0).speed = 0
					$PopupServerFile.popup()
			if Input.is_action_pressed("ui_cancel"):
				$PopupServerFile.hide()
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

func _on_ZoneBoiteNoire_body_entered(body):
	if(body is Player):
		currentArea = "ZoneBoiteNoire"

func _on_ZoneBouton_body_entered(body):
	if(body is Player):
		currentArea = "ZoneBouton"
		
func _on_ZoneServerFile_body_entered(body):
	if(body is Player):
		currentArea = "ZoneServerFile"

# Body Exited

func _on_ZonePilotage_body_exited(body):
	if(body is Player):
		currentArea = null

func _on_ZoneLivre_body_exited(body):
	if(body is Player):
		currentArea = null

func _on_ZoneCarnet_body_exited(body):
	if(body is Player):
		currentArea = null

func _on_ZoneBoiteNoire_body_exited(body):
	if(body is Player):
		currentArea = null

func _on_ZoneCodeMorse_body_exited(body):
	if(body is Player):
		currentArea = null

func _on_ZoneBouton_body_exited(body):
	if(body is Player):
		currentArea = null
		
func _on_ZoneServerFile_body_exited(body):
	if(body is Player):
		currentArea = null


############################################ Gestion des signaux ############################################

signal change_code_porte
func change_code_porte():
	emit_signal("change_code_porte")

signal change_tab_fils
func change_tab_fils():
	emit_signal("change_tab_fils")

signal button_com_pressed
func change_button_pressed():
	emit_signal("button_com_pressed")

signal button_com_unpressed
func change_button_unpressed():
	emit_signal("button_com_unpressed")
	
# file transfert signal
	
func _on_Transfert_win_transfert():
	transfert_win = true
	$Player.get_child(0).get_child(4).get_child(1).get_child(3).modulate = Color("5cf70e")
	
############################################ Gestion des tâches ############################################

func _on_Button_pressed():
	var line = $PopupBoiteNoire/Panel2/LineEdit.text
	if(tabMorse[0] == "D\nA\nL\nE\nK\nS"):
		if (line == "Daleks" or line == "DALEKS" or line == "daleks"):
			boiteNoireDecoder = true
			$PopupBoiteNoire/Panel2/Label2.text = "Boite \n décodé"
			$PopupBoiteNoire/Panel2/LineEdit.text = ""
		else:
			$PopupBoiteNoire/Panel2/LineEdit.text = ""
	elif(tabMorse[0] == "S\nO\nN\nT\nA\nR\nI\nE\nN\nS"):
		if (line == "Sontariens" or line == "SONTARIENS" or line == "sontariens"):
			$PopupBoiteNoire/Panel2/Label2.text = "Boite \n décodé"
			$PopupBoiteNoire/Panel2/LineEdit.text = ""
			boiteNoireDecoder = true
		else:
			$PopupBoiteNoire/Panel2/LineEdit.text = ""
	elif(tabMorse[0] == "C\nY\nB\nE\nR\nM\nE\nN\nS"):
		if (line == "Cybermens" or line == "CYBERMENS" or line == "cybermens"):
			boiteNoireDecoder = true
			$PopupBoiteNoire/Panel2/Label2.text = "Boite \n décodé"
			$PopupBoiteNoire/Panel2/LineEdit.text = ""
		else:
			$PopupBoiteNoire/Panel2/LineEdit.text = ""
	if(boiteNoireDecoder):
		$Player.get_child(0).get_child(4).get_child(1).get_child(2).modulate = Color("5cf70e")

func _on_TextureButton_button_up():
	if(boiteNoireDecoder and shipAlign and transfert_win):
		change_button_pressed()

func _on_TextureButton_button_down():
	change_button_unpressed()

func _on_Fleche_button_down():
	if(shipAlign == false):
		flechePressed = true

func _on_Fleche_button_up():
	flechePressed = false

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
	$Player.get_child(0).speed = 0




