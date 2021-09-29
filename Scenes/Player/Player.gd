extends KinematicBody2D

var speed = 100
var velocity = Vector2.ZERO

func _physics_process(delta):
	if Input.is_action_pressed("move_right"):
		velocity.x = speed
	elif Input.is_action_pressed("move_left"):
		velocity.x = -speed
	else:
		velocity.x = 0
	if Input.is_action_pressed("move_up"):
		velocity.y = -speed
	elif Input.is_action_pressed("move_down"):
		velocity.y = speed
	else:
		velocity.y = 0
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	move_and_slide(velocity)
	if Input.is_action_just_pressed("move_right"):
		$BodyElectricien.flip_h = false
		$BodyElectricien.animation = "right"
	if Input.is_action_just_pressed("move_down"):
		$BodyElectricien.animation = "down"
	if Input.is_action_just_pressed("move_up"):
		$BodyElectricien.animation = "up"
	if Input.is_action_just_pressed("move_left"):
		$BodyElectricien.animation = "right"
		$BodyElectricien.flip_h = true
