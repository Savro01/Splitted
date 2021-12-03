extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var currentArea
var porteUnlock = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match currentArea:
		"ZoneDisjoncteur":
			if Input.is_action_pressed("object_interact"):
#				if $Popup.visible == false:
#					var v = $Player.get_position()
#					$Popup.set_position(v)
#					$Popup.show()
#					$Player.speed = 0
				pass
			if Input.is_action_pressed("ui_cancel"):
#				if $Popup.visible:
#					$Popup.hide()
#					$Player.speed = 100
				pass
#		"ZoneLivre":
#			print("Livre")
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
					$Popup.hide()
					$Player.get_child(0).speed = 100

############################################ Gestion des portes ############################################
func _on_Door1_body_entered(body):
		if(body is Player):
			print(R.code_porte_soute)
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

############################################ Gestion des tâches ############################################

func _on_ButtonEntrerCode_pressed():
	if($PopupCodePorte/CodeEnter.text == 5555):
		porteUnlock = true
		$PopupCodePorte.hide()
		$Door2.tile_set = load("res://Assets/Tileset/door_without_coll.tres")
		$Door2.visible = false
	else:
		$PopupCodePorte/TextureRect/Label.text = "Mauvais code ! Rentrez un code valide"
