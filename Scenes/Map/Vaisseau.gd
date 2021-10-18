extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Player/BodyCommandant.visible = false
	$Player/BodyElectricien.visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


############################################ Gestion des portes ############################################
func _on_Door1_body_entered(body):
		if(body is Player):
			$Door1.tile_set = load("res://Assets/Tileset/door_without_coll.tres")
			$Door1.visible = false

func _on_Door1_body_exited(body):
		if(body is Player):
			$Door1.tile_set = load("res://Assets/Tileset/door_with_coll.tres")
			$Door1.visible = true

func _on_Door2_body_entered(body):
		if(body is Player):
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
