extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var link = preload("res://Scenes/Animated/Link.tscn")
var bouclier = preload("res://Scenes/Animated/bouclier.tscn")
var linkInst = null
var currentArea = null
var porteUnlock = false
var colleObtenu = false
var tuyau1repare = false
var tuyau2repare = false
var tuyau3repare = false
var fil1 = null
var nb_bouclier = 0
var nb_bouclier_lock = 0
var bouclierRepare = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match currentArea:
		"ZoneDisjoncteur":
			if Input.is_action_pressed("object_interact"):
				var v = $Player.get_child(0).get_global_position() - $PopupFils.get_rect().size/2
				$PopupFils.set_global_position(v)
				$PopupFils.popup()
				$Player.get_child(0).speed = 0
			if Input.is_action_pressed("ui_cancel"):
				$PopupFils.hide()
				$Player.get_child(0).speed = 100
		"ZoneDoor2":
			if Input.is_action_pressed("object_interact"):
				if($PopupCodePorte.visible == false):
					var v = $Player.get_child(0).get_global_position() - $PopupCodePorte.get_rect().size/2
					$PopupCodePorte.set_global_position(v)
					$PopupCodePorte.popup()
					$Player.get_child(0).speed = 0
			if Input.is_action_pressed("ui_cancel"): 
				$PopupCodePorte.hide()
				$Player.get_child(0).speed = 100
		"ZoneColle":
			if Input.is_action_pressed("object_interact"):
				$Player.get_child(0).get_child(4).set_b_pressed()
				colleObtenu = true
				if(has_node("TileMapColle")):
					$TileMapColle.queue_free()
				currentArea = null
		"ZoneTuyau1":
			if Input.is_action_pressed("object_interact") and colleObtenu:
				$Player.get_child(0).get_child(4).set_b_pressed()
				tuyau1repare = true
				if(has_node("ZoneTuyau1/Gaz1")):
					$ZoneTuyau1/Gaz1.queue_free()
				currentArea = null
		"ZoneTuyau2":
			if Input.is_action_pressed("object_interact"):
				$Player.get_child(0).get_child(4).set_b_pressed()
				tuyau2repare = true
				if(has_node("ZoneTuyau2/Gaz2")):
					$ZoneTuyau2/Gaz2.queue_free()
				currentArea = null
		"ZoneTuyau3":
			if Input.is_action_pressed("object_interact"):
				$Player.get_child(0).get_child(4).set_b_pressed()
				tuyau3repare = true
				if(has_node("ZoneTuyau3/Gaz3")):
					$ZoneTuyau3/Gaz3.queue_free()
				currentArea = null
		"ZoneBouclier1":
			if Input.is_action_pressed("object_interact"):
				$Player.get_child(0).get_child(4).set_b_pressed()
				nb_bouclier += 1
				if(has_node("Bouclier1")):
					$Bouclier1.queue_free()
				currentArea = null
		"ZoneBouclier2":
			if Input.is_action_pressed("object_interact"):
				$Player.get_child(0).get_child(4).set_b_pressed()
				nb_bouclier += 1
				if(has_node("Bouclier2")):
					$Bouclier2.queue_free()
				currentArea = null
		"ZoneBouclier":
			if Input.is_action_pressed("object_interact"):
				if($PopupBouclier.visible == false):
					for i in nb_bouclier:
						var boucInst = bouclier.instance()
						boucInst.connect("bouclierLock", self, "_on_bouclier_bouclierLock")
						$PopupBouclier.add_child(boucInst)
						nb_bouclier -= 1
					var v = $Player.get_child(0).get_global_position() - $PopupBouclier.get_rect().size/2
					$PopupBouclier.set_global_position(v)
					$PopupBouclier.popup()
					$Player.get_child(0).speed = 0
			if Input.is_action_pressed("ui_cancel"): 
				$PopupBouclier.hide()
				$Player.get_child(0).speed = 100
		"ZoneBoutonElec":
			if Input.is_action_pressed("object_interact"):
				if($PopupBoutonElec.visible == false):
					var v = $Player.get_child(0).get_global_position() - $PopupBoutonElec.get_rect().size/2
					$PopupBoutonElec.set_global_position(v)
					$PopupBoutonElec.popup()
					$Player.get_child(0).speed = 0
			if Input.is_action_pressed("ui_cancel"): 
				$PopupBoutonElec.hide()
				$Player.get_child(0).speed = 100
		"ZoneFile":
			if Input.is_action_pressed("object_interact"):
				if($PopupFilePhone.visible == false):
					var v = $Player.get_child(0).get_global_position() - $PopupFilePhone.get_rect().size/2
					$PopupFilePhone.set_global_position(v)
					$PopupFilePhone.popup()
					$PopupFilePhone/ColorPicker.play()
					$Player.get_child(0).speed = 0
				if Input.is_action_pressed("ui_cancel"): 
					$PopupFilePhone.hide()
					$PopupFilePhone/ColorPicker.stop()
					$Player.get_child(0).speed = 100

############################################ Gestion des portes ############################################
func _on_Door1_body_entered(body):
	if(body is Player and get_parent().electriciteRepare):
		$Door1.tile_set = load("res://Assets/Tileset/door_without_coll.tres")
		$Door1.visible = false

func _on_Door1_body_exited(body):
	if(body is Player):
		$Door1.tile_set = load("res://Assets/Tileset/door_with_coll.tres")
		$Door1.visible = true

func _on_Door2_body_entered(body):
	if(body is Player and get_parent().electriciteRepare):
		currentArea = "ZoneDoor2"
	if(body is Player and porteUnlock):
		$Door2.tile_set = load("res://Assets/Tileset/door_without_coll.tres")
		$Door2.visible = false

func _on_Door2_body_exited(body):
	currentArea = null
	if(body is Player):
		$Door2.tile_set = load("res://Assets/Tileset/door_with_coll.tres")
		$Door2.visible = true

func _on_Door3_body_entered(body):
	if(body is Player):
		$Door3.tile_set = load("res://Assets/Tileset/door_without_coll.tres")
		$Door3.visible = false

func _on_Door3_body_exited(body):
	if(body is Player):
		$Door3.tile_set = load("res://Assets/Tileset/door_with_coll.tres")
		$Door3.visible = true

func _on_Door4_body_entered(body):
	if(body is Player):
		$Door4.tile_set = load("res://Assets/Tileset/door_without_coll.tres")
		$Door4.visible = false

func _on_Door4_body_exited(body):
	if(body is Player):
		$Door4.tile_set = load("res://Assets/Tileset/door_with_coll.tres")
		$Door4.visible = true

func _on_Door5_body_entered(body):
	if(body is Player):
		$Door5.tile_set = load("res://Assets/Tileset/door_without_coll.tres")
		$Door5.visible = false

func _on_Door5_body_exited(body):
	if(body is Player):
		$Door5.tile_set = load("res://Assets/Tileset/door_with_coll.tres")
		$Door5.visible = true

func _on_Door6_body_entered(body):
	if(body is Player):
		$Door6.tile_set = load("res://Assets/Tileset/door_without_coll.tres")
		$Door6.visible = false

func _on_Door6_body_exited(body):
	if(body is Player):
		$Door6.tile_set = load("res://Assets/Tileset/door_with_coll.tres")
		$Door6.visible = true


############################################ Gestion des Zones ############################################

func _on_ZoneDisjoncteur_body_entered(body):
	if(body is Player):
		currentArea = "ZoneDisjoncteur"

func _on_ZoneDisjoncteur_body_exited(body):
	if(body is Player):
		currentArea = null

func _on_ZoneColle_body_entered(body):
	if(body is Player):
		currentArea = "ZoneColle"

func _on_ZoneColle_body_exited(body):
	if(body is Player):
		currentArea = null
		
func _on_ZoneTuyau1_body_entered(body):
	if(body is Player):
		currentArea = "ZoneTuyau1"

func _on_ZoneTuyau1_body_exited(body):
	if(body is Player):
		currentArea = null

func _on_ZoneTuyau2_body_entered(body):
	if(body is Player):
		currentArea = "ZoneTuyau2"

func _on_ZoneTuyau2_body_exited(body):
	if(body is Player):
		currentArea = null

func _on_ZoneTuyau3_body_entered(body):
	if(body is Player):
		currentArea = "ZoneTuyau3"

func _on_ZoneTuyau3_body_exited(body):
	if(body is Player):
		currentArea = null

func _on_ZoneBouclier1_body_entered(body):
	if(body is Player):
		currentArea = "ZoneBouclier1"

func _on_ZoneBouclier1_body_exited(body):
	if(body is Player):
		currentArea = null

func _on_ZoneBouclier2_body_entered(body):
	if(body is Player):
		currentArea = "ZoneBouclier2"

func _on_ZoneBouclier2_body_exited(body):
	if(body is Player):
		currentArea = null

func _on_ZoneBouclier_body_entered(body):
	if(body is Player):
		currentArea = "ZoneBouclier"

func _on_ZoneBouclier_body_exited(body):
	if(body is Player):
		currentArea = null

func _on_ZoneBoutonElec_body_entered(body):
	if(body is Player):
		currentArea = "ZoneBoutonElec"

func _on_ZoneBoutonElec_body_exited(body):
	if(body is Player):
		currentArea = null
		
func _on_ZoneFile_body_entered(body):
	if(body is Player):
		currentArea = "ZoneFile"

func _on_ZoneFile_body_exited(body):
	if(body is Player):
		currentArea = null
		
		
############################################ Gestion des signaux ############################################

signal electricite_changed
func change_electricite_status():
	emit_signal("electricite_changed")

signal button_elec_pressed
func change_button_pressed():
	emit_signal("button_elec_pressed")

signal button_elec_unpressed
func change_button_unpressed():
	emit_signal("button_elec_unpressed")

############################################ Gestion des tâches ############################################

#Ouverture porte
func _on_ButtonEntrerCode_pressed():
	if($PopupCodePorte/CodeEnter.text == str(get_parent().code_porte)):
		porteUnlock = true
		$PopupCodePorte.hide()
		$Player.get_child(0).speed = 100
		$Player.get_child(0).get_child(4).set_b_pressed()
		$Door2.tile_set = load("res://Assets/Tileset/door_without_coll.tres")
		$Door2.visible = false
	else:
		$PopupCodePorte/TextureRect/Label.text = "Code non valide !"

#Tâches fil electrique
func _on_BlueLeft_button_down():
	fil1 = $PopupFils/BlueLeft

func _on_BlueRight_button_down():
	if(fil1 != null):
		creation_fil($PopupFils/BlueRight)

func _on_PinkLeft_button_down():
	fil1 = $PopupFils/PinkLeft

func _on_PinkRight_button_down():
	if(fil1 != null):
		creation_fil($PopupFils/PinkRight)

func _on_YellowLeft_button_down():
	fil1 = $PopupFils/YellowLeft

func _on_YellowRight_button_down():
	if(fil1 != null):
		creation_fil($PopupFils/YellowRight)

func _on_RedLeft_button_down():
	fil1 = $PopupFils/RedLeft

func _on_RedRight_button_down():
	if(fil1 != null):
		creation_fil($PopupFils/RedRight)

func creation_fil(text_butt):
	linkInst = link.instance()
	linkInst.item1 = fil1
	linkInst.item2 = text_butt
	if fil1 == $PopupFils/BlueLeft:
		linkInst.get_child(0).get_child(0).set_default_color(Color("#0100ff"))
	elif fil1 == $PopupFils/PinkLeft:
		linkInst.get_child(0).get_child(0).set_default_color(Color("#fe00fd"))
	elif fil1 == $PopupFils/YellowLeft:
		linkInst.get_child(0).get_child(0).set_default_color(Color("#fae806"))
	else:
		linkInst.get_child(0).get_child(0).set_default_color(Color("#ff0000"))
	$PopupFils.add_child(linkInst)
	fil1 = null

func _on_TextureRectPoignee_pressed():
	$PopupFils/TextureRectPoignee.rect_position.y = 165
	if(verif_fil()):
		change_electricite_status()
	else:
		for i in range($PopupFils.get_child_count()):
			if($PopupFils.get_child(i) is Link):
				$PopupFils.get_child(i).queue_free()
		$PopupFils/TextureRectPoignee.rect_position.y = 190

func verif_fil():
	var verif = true
	for i in range($PopupFils.get_child_count()):
		if($PopupFils.get_child(i) is Link):
			if($PopupFils.get_child(i).item1 == $PopupFils/BlueLeft):
				if(get_string_fil($PopupFils.get_child(i).item2) != get_parent().tabFils[0]):
					verif = false
			if($PopupFils.get_child(i).item1 == $PopupFils/PinkLeft):
				if(get_string_fil($PopupFils.get_child(i).item2) != get_parent().tabFils[1]):
					verif = false
			if($PopupFils.get_child(i).item1 == $PopupFils/YellowLeft):
				if(get_string_fil($PopupFils.get_child(i).item2) != get_parent().tabFils[2]):
					verif = false
			if($PopupFils.get_child(i).item1 == $PopupFils/RedLeft):
				if(get_string_fil($PopupFils.get_child(i).item2) != get_parent().tabFils[3]):
					verif = false
	return verif

func get_string_fil(texture):
	if(texture == $PopupFils/BlueRight):
		return "Bleu"
	if(texture == $PopupFils/PinkRight):
		return "Rose"
	if(texture == $PopupFils/YellowRight):
		return "Jaune"
	if(texture == $PopupFils/RedRight):
		return "Rouge"
		
# 			  rouge -   orange -  jaune -    vert -     rose -    bleu
var order = ["fd0100", "f76915", "eede04", "a0d636", "f79cee", "333ed4"]

func get_tab_ColorPicker(animation):
	if(animation == "bleu"):
		return ["333ed4", "a0d636", "eede04", "f76915", "fd0100", "f79cee"]
	if(animation == "rose"):
		return ["f79cee", "a0d636", "eede04", "f76915", "fd0100", "333ed4"]
	if(animation == "rouge"):
		return ["fd0100", "f76915", "eede04", "a0d636", "f79cee", "333ed4"]
	if(animation == "orange"):
		return ["f76915", "f79cee", "a0d636", "eede04", "333ed4", "fd0100"]
	if(animation == "vert"):
		return ["a0d636", "f76915", "f79cee", "333ed4", "fd0100", "eede04"]

func _on_bouclier_bouclierLock():
	nb_bouclier_lock += 1
	if(nb_bouclier_lock >= 2):
		bouclierRepare = true

func _on_TextureButton_button_down():
	if(tuyau1repare and tuyau2repare and tuyau3repare and bouclierRepare):
		$PopupBoutonElec/TextureButton.modulate == Color("0e78fc")
		change_button_pressed()

func _on_TextureButton_button_up():
	$PopupBoutonElec/TextureButton.modulate == Color("ffffff")
	change_button_unpressed()



