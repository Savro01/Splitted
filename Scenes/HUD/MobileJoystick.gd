extends CanvasLayer


signal use_move_vector

var move_vector = Vector2(0,0)
var joystick_active = false
var a = InputEventAction.new()
var b = InputEventAction.new()

func _input(event):
	if event is InputEventScreenTouch or event is InputEventScreenDrag:
		if $TouchScreenButton.is_pressed():
			move_vector = calculate_move_vector(event.position)
			emit_signal("use_move_vector", move_vector)
			joystick_active = true
			$Innercircle.position = event.position
			$Innercircle.visible = true
		if(get_parent().get_parent().get_parent().currentArea != null):
			if $A_Button.is_pressed():
					set_a_pressed()
			if $B_Button.is_pressed():
					set_b_pressed()
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

func set_a_pressed():
	a.action = "object_interact"
	a.pressed = true
	b.pressed = false
	Input.parse_input_event(a)
	Input.parse_input_event(b)

func set_b_pressed():
	b.action = "ui_cancel"
	b.pressed = true
	a.pressed = false
	Input.parse_input_event(b)	
	Input.parse_input_event(a)
