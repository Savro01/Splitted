extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var currentArea = null

# Called when the node enters the scene tree for the first time.
func _ready():
	$Player/BodyCommandant.visible = true
	$Player/BodyElectricien.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match currentArea:
		"ZonePilotage":
			if Input.is_action_pressed("object_interact"):
				if $Popup.visible == false:
					$Popup.show()
					$Player.speed = 0
			if Input.is_action_pressed("ui_cancel"):
				if $Popup.visible:
					$Popup.hide()
					$Player.speed = 100


func _on_ZonePilotage_body_entered(body):
	var v = $Player.get_position()
	$Popup.set_position(v)
	currentArea = "ZonePilotage"
