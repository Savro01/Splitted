extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var link = preload("res://Scenes/Animated/Link.tscn")
var linkInst = null
var currentArea = null
var porteUnlock = false
var colleObtenu = false
var tuyau1repare = false
var tuyau2repare = false
var tuyau3repare = false
var fil1 = null

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
				print("Echap pressed")
				if $PopupFils.visible:
					print("Popup visible")
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
				print("Echap pressed")
				if $PopupCodePorte.visible:
					print("Popup visible")
					$PopupCodePorte.hide()
					$Player.get_child(0).speed = 100
		"ZoneColle":
			if Input.is_action_pressed("object_interact"):
				colleObtenu = true
				if(has_node("TileMapColle")):
					$TileMapColle.queue_free()
		"ZoneTuyau1":
			if Input.is_action_pressed("object_interact") and colleObtenu:
				tuyau1repare = true
				if(has_node("ZoneTuyau1/Gaz1")):
					$ZoneTuyau1/Gaz1.queue_free()
		"ZoneTuyau2":
			if Input.is_action_pressed("object_interact"):
				tuyau2repare = true
				if(has_node("ZoneTuyau2/Gaz2")):
					$ZoneTuyau2/Gaz2.queue_free()
		"ZoneTuyau3":
			if Input.is_action_pressed("object_interact"):
				tuyau3repare = true
				if(has_node("ZoneTuyau3/Gaz3")):
					$ZoneTuyau3/Gaz3.queue_free()

############################################ Gestion des portes ############################################
func _on_Door1_body_entered(body):
	if(body is Player):
		print("body is Player")
		print(R.code_porte)
		$Door1.tile_set = load("res://Assets/Tileset/door_without_coll.tres")
		$Door1.visible = false

func _on_Door1_body_exited(body):
	if(body is Player):
		$Door1.tile_set = load("res://Assets/Tileset/door_with_coll.tres")
		$Door1.visible = true

func _on_Door2_body_entered(body):
	currentArea = "ZoneDoor2"
	if(body is Player and porteUnlock):
		$Door2.tile_set = load("res://Assets/Tileset/door_without_coll.tres")
		$Door2.visible = false

func _on_Door2_body_exited(body):
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

############################################ Gestion des tâches ############################################

#Ouverture porte
func _on_ButtonEntrerCode_pressed():
	print(get_parent().code_porte)
	if($PopupCodePorte/CodeEnter.text == str(get_parent().code_porte)):
		porteUnlock = true
		$PopupCodePorte.hide()
		$Player.get_child(0).speed = 100
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
	$PopupFils.add_child(linkInst)
	fil1 = null
