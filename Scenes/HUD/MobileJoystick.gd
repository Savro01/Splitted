extends CanvasLayer


signal use_move_vector

var move_vector = Vector2(0,0)
var joystick_active = false

func _input(event):
	if event is InputEventScreenTouch or event is InputEventScreenDrag:
		if $TouchScreenButton.is_pressed():
			move_vector = calculate_move_vector(event.position)
			emit_signal("use_move_vector", move_vector)
			joystick_active = true
			$Innercircle.position = event.position
			$Innercircle.visible = true
		
			
	if event is InputEventScreenTouch:
		if event.pressed == false:
			joystick_active = false
			$Innercircle.visible = false

				

func _physics_process(delta):
	if joystick_active:
		emit_signal("use_move_vector", move_vector)
	else:
		emit_signal("use_move_vector", Vector2())
	


func calculate_move_vector(event_position):
	var texture_center = $TouchScreenButton.position + Vector2(80,80)
	return (event_position - texture_center).normalized()
