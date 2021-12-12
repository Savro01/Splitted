extends CanvasLayer


signal use_move_vector
signal use_A_btn

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
			
		if $A_Button.is_pressed():
			var a = InputEventAction.new()
			a.action = "object_interact"
			a.pressed = true
			Input.parse_input_event(a)

			
		if $B_Button.is_pressed():
			var b = InputEventAction.new()
			b.action = "ui_cancel"
			b.pressed = true
			Input.parse_input_event(b)

			
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
