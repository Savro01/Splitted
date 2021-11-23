extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var currentArea

# Called when the node enters the scene tree for the first time.
func _ready():
	$Player/BodyCommandant.visible = true
	$Player/BodyElectricien.visible = false
	currentArea = null

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match currentArea:
		"ZonePilotage":
			if Input.is_action_pressed("object_interact"):
				print("interaction click")
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
			print("Livre")

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
		rset(R.test_com, "Print electricien")
		print(R.test_com)


func _on_ZoneLivre_body_exited(body):
	if(body is Player):
		currentArea = null
		print("sortie livre")
	
